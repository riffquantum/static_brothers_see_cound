/*
  SPECTRAL_DELAY
  Based on PureMagnetik's module for their Lore console:
    https://puremagnetik.com/products/lore-experimental-sound-console
  Creates an effect instrument which applies a sort of old tape effect.
  It adds some pops and crackles along with some filtering and a bit of
  wobble.

  Global Variables:
    Buffer1L - i - Buffer table for the effect
    Buffer1R - i - Buffer table for the effect
    Age - k - Age of the tape, affects intensity of effects
    Dirt - k - The amount of dirt, crackle and noise to add
    Drop - k - Frequency with which the signal drops out significantly
    Spread - k - Does some kind of smearing thing with a delay? I dunno.
      It gets divided by 23 so a value of 23 might be the clearest way to
      hear what its doing.
    Output - k - Overall level of the signal after modulation
    MaxPitchVariation - k - The maximum amount of detuning and wobble applied
      to the signal.

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.
*/

#define CASSETTE(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.Buffer1L ftgen 0,0,131072,2,0
  gi$INSTRUMENT_NAME.Buffer1R ftgen 0,0,131072,2,0

  gk$INSTRUMENT_NAME.Age init 0.5
  gk$INSTRUMENT_NAME.Dirt init 0.3
  gk$INSTRUMENT_NAME.Drop init 0.5
  gk$INSTRUMENT_NAME.Spread init 0.5
  gk$INSTRUMENT_NAME.Output init 0.5
  gk$INSTRUMENT_NAME.MaxPitchVariation init 0.015

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    kAge = gk$INSTRUMENT_NAME.Age
    kDirt = gk$INSTRUMENT_NAME.Dirt
    kDrop = gk$INSTRUMENT_NAME.Drop
    kSpread = gk$INSTRUMENT_NAME.Spread
    kOutput = gk$INSTRUMENT_NAME.Output

    kFadeReadIndex, kFadeGain init 0
    kFadeInSamples = sr*0.002 ;seconds to fade
    iTableLength = ftlen(gi$INSTRUMENT_NAME.Buffer1L)
    ; fade in/out. follow pointer and fade at greater and less than "kFadeInSamples"
    if (kFadeReadIndex < kFadeInSamples) then
      kFadeGain = kFadeReadIndex/(kFadeInSamples)
    elseif (kFadeReadIndex > iTableLength - kFadeInSamples) then
      kFadeGain = (iTableLength-kFadeReadIndex)/kFadeInSamples
    else
      kFadeGain = 1
    endif

    ; Write to buffer
    kIndex = (sr/iTableLength) ;speed calculation for phasor
    aIndex		phasor kIndex
    tablew   aInL, aIndex, gi$INSTRUMENT_NAME.Buffer1L, 1 ; write audio to function table
    tablew   aInR, aIndex, gi$INSTRUMENT_NAME.Buffer1R, 1 ; write audio to function table

    kFadeReadIndex = iTableLength*aIndex

    kMaxPitchVariation = gk$INSTRUMENT_NAME.MaxPitchVariation ;maximum pitch variation 0 to 1
    kRandomRate random 1, 1 ;trigger kPitchModulation at random rates
    kPitchModulation randh kAge * kMaxPitchVariation, abs(kRandomRate), 1
    kPitchModulation portk abs(kPitchModulation), 0.5 ;interpolate btween pitch vars n seconds

    aDust dust2 0.6 * kDirt, 2 * kDirt
    aNoise noise 0.01 * kAge, -0.4

    aSignalL table aIndex * (1 - kPitchModulation), gi$INSTRUMENT_NAME.Buffer1L, 1, 0, 1
    aSignalR table aIndex * (1 - kPitchModulation), gi$INSTRUMENT_NAME.Buffer1R, 1, 0, 1

    kFilterCutoffLow = (15000 * (1 - kAge))+1000
    kFilterCutoffHigh = (400 * 0.83) * kAge
    kDist = kAge
    iMaxDelay = 3

    aDelayL vdelay aSignalL, 0.2, iMaxDelay
    aDelayR vdelay aSignalR, 0.2, iMaxDelay

    ;add feedback
    aDelayL = aSignalL + (aDelayL * kSpread / 23)
    aDelayR = aSignalR + (aDelayR * kSpread / 23)

    aLowpassFilterL lpf18 aDelayL, kFilterCutoffLow, 0.1, kDist
    aLowpassFilterR lpf18 aDelayR, kFilterCutoffLow, 0.1, kDist

    aLowpassFilterL2, aHighpassFilterL, aBandL svfilter aLowpassFilterL, kFilterCutoffHigh, 0
    aLowpassFilterR2, aHighpassFilterR, aBandR svfilter aLowpassFilterR, kFilterCutoffHigh, 0


    aAgedL = (aHighpassFilterL + aNoise * 0.3 + aDust * 0.5) * kFadeGain
    aAgedR = (aHighpassFilterR + aNoise * 0.3 + aDust * 0.5) * kFadeGain

    kDropoutFrequency = 6 * kDrop

    kPulseRate = abs(round(randh(1, kDropoutFrequency)))
    kMetro  metro kPulseRate ;generate pulses at a random rate
    kDropfade lineto 1 - kMetro, 0.05

    aOutL =  aAgedL * kOutput * kDropfade
    aOutR =  aAgedR * kOutput * kDropfade

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
