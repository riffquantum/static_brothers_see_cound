/*
  TAPE_WOBBLE
  Creates an effect instrument that uses a delay to apply a pitch vibrato
  to a signal meant to sound like a degraded cassette tape. Additionally
  creates a "Nudge" instrument meant to allow for sudden acute adjustments
  to the wobble rate and depth.

  Global Variables:
    Amount - a - Amplitude of modulation wave.
    Speed - a - Frequency of modulation wave.
    WobbleWave - i, table - Waveform for the wobble modulation.
      Sine is default.
    BufferLength - i - Buffer length for delay. Determines maximum
      time value.
    AmountNudge - a - This value is not meant to be set directly but
      is instead controlled by p fields on nudge instrument instances.
    SpeedNudge - a - This value is not meant to be set directly but is
      instead controlled by p fields on nudge instrument instances.

  P Fields:
    None

  Nudge P Fields:
    p4 - Factor by which the nudge should multiply the
      amplitude of the modulation wave.
    p5 - Factor by which the nudge should multiply the
      frequency of the modulation wave.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define TAPE_WOBBLE(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  ga$INSTRUMENT_NAME.Amount init .03
  ga$INSTRUMENT_NAME.Speed init .1
  gi$INSTRUMENT_NAME.WobbleWave init sineWave()
  gi$INSTRUMENT_NAME.BufferLength init 1

  ga$INSTRUMENT_NAME.AmountNudge init 0
  ga$INSTRUMENT_NAME.SpeedNudge init 0

  instr $INSTRUMENT_NAME.Nudge
    aEnvelope = linseg(0, p3/2, 1, p3/2, 0)

    ga$INSTRUMENT_NAME.AmountNudge = p4 * aEnvelope
    ga$INSTRUMENT_NAME.SpeedNudge = p5 * aEnvelope
  endin

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iDelayAttackTime = .2
    iBufferLength = gi$INSTRUMENT_NAME.BufferLength * 1000
    iMinimumDelayTime = 50/sr

    aAmount = ga$INSTRUMENT_NAME.Amount / 2
    aSpeed = ga$INSTRUMENT_NAME.Speed

    aAmount += ga$INSTRUMENT_NAME.AmountNudge
    aSpeed += ga$INSTRUMENT_NAME.SpeedNudge

    aAttackTime = linseg(0, iDelayAttackTime, 1)
    aOscillator = poscil(aAmount, aSpeed, gi$INSTRUMENT_NAME.WobbleWave, .75) + (aAmount)

    aDelayTime = (aAttackTime * aOscillator)
    aDelayTime = limit(aDelayTime, iMinimumDelayTime, (iBufferLength/1000) - iMinimumDelayTime)

    aDelayBufferOutL delayr iBufferLength
    aDelayOutL       deltapi aDelayTime
                     delayw aSignalInL

    aDelayBufferOutR delayr iBufferLength
    aDelayOutR       deltapi aDelayTime
                     delayw aSignalInR

    aSignalOutL = aDelayOutL
    aSignalOutR = aDelayOutR

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

