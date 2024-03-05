/*
  SPECTRAL_DELAY
  Based on PureMagnetik's module for their Lore console:
    https://puremagnetik.com/products/lore-experimental-sound-console
  Creates an effect instrument which applies separate delays to
  different frequency bands for an audio input. The various delay times,
  feedback levels, and volumes are stored in separate Left and Right tables.
  The tables can be altered while the instrument is active.
  Setting table values here is not the most intuitive thing. Gen routines 2 and
  7 are both good candidates though. Gen routine 21 might be a good option for
  random values. Below are some examples:

    - Arbitrary Input for a 4 band delay
      giSpectralDelayInputAmountsL ftgen 0, 0, 4, -2, 1, 2, 3, 4
      giSpectralDelayInputAmountsR = giSpectralDelayInputAmountsL
      giSpectralDelayDelayTimesTableL ftgen 0, 0, 4, -2, 1, 2, 3, 4
      giSpectralDelayDelayTimesTableR = giSpectralDelayDelayTimesTableL
      giSpectralDelayFeedbackL ftgen 0, 0, 4, -2, 0.5, 0.7, 0.9, 0.99
      giSpectralDelayFeedbackR = giSpectralDelayFeedbackL

    - Line Segment Input for a 64 band delay
      giSpectralDelayInputAmountsL ftgen 0, 0, 64, -7, .1, 16, 1, 16, .8, 16, 1, 16, .1
      giSpectralDelayInputAmountsR = giSpectralDelayInputAmountsL
      giSpectralDelayDelayTimesTableL ftgen 0, 0, 64, -7, .1, 16, 1, 16, .8, 16, 1, 16, .1
      giSpectralDelayDelayTimesTableR = giSpectralDelayDelayTimesTableL
      giSpectralDelayFeedbackL ftgen 0, 0, 64, -7, 0.5, 16, 0.7, 16, 0.9, 16, 0.99, 16, 0
      giSpectralDelayFeedbackR = giSpectralDelayFeedbackL

  Global Variables:
    $INSTRUMENT_NAME.NumberOfBands - i - Number of bands to split the signal into.
    $INSTRUMENT_NAME.InputAmountMod - k - Modifies the input amplitude for each partial
    $INSTRUMENT_NAME.DelayLevelMod - k - Modifies the delay level for each partial
    $INSTRUMENT_NAME.DelayTimeMod - k - Modifies the read pointer of the pvs buffer
    $INSTRUMENT_NAME.FeedbackLevelMod - k - Modifies the feeback level for each partial. Currently busted
    $INSTRUMENT_NAME.DefaultValue - i - A number used to seed the default table values
    $INSTRUMENT_NAME.InputAmounts[L, R]- i - Two tables (left and right) containing the input amplitudes for
      each partial. Length should match number of bands
    $INSTRUMENT_NAME.DelayTimes[L, R]- i - Two tables (left and right) containing the delay times for
      each partial. Length should match number of bands
    $INSTRUMENT_NAME.FeedBackLevels[L, R] - i - Two tables (left and right) containing the feedback amounts for
      each partial. Length should match number of bands

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.
    $NUMBER_OF_BANDS - Number - Number of bands to split the signal into.
*/

#define SPECTRAL_DELAY(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'NUMBER_OF_BANDS) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  gi$INSTRUMENT_NAME.NumberOfBands init $NUMBER_OF_BANDS

  gk$INSTRUMENT_NAME.InputAmountMod init 0
  gk$INSTRUMENT_NAME.DelayLevelMod init 0
  gk$INSTRUMENT_NAME.DelayTimeMod init 1
  gk$INSTRUMENT_NAME.FeedbackLevelMod init 0

  gi$INSTRUMENT_NAME.DefaultValue init 2 ; was 0.7

  gi$INSTRUMENT_NAME.InputAmountsL ftgen 0, 0, gi$INSTRUMENT_NAME.NumberOfBands, -7, gi$INSTRUMENT_NAME.DefaultValue*0.7, gi$INSTRUMENT_NAME.NumberOfBands/2, gi$INSTRUMENT_NAME.DefaultValue*0.3, gi$INSTRUMENT_NAME.NumberOfBands/2, gi$INSTRUMENT_NAME.DefaultValue*0.7
  gi$INSTRUMENT_NAME.InputAmountsR ftgen 0, 0, gi$INSTRUMENT_NAME.NumberOfBands, -7, gi$INSTRUMENT_NAME.DefaultValue*0.7, gi$INSTRUMENT_NAME.NumberOfBands/2, gi$INSTRUMENT_NAME.DefaultValue*0.3, gi$INSTRUMENT_NAME.NumberOfBands/2, gi$INSTRUMENT_NAME.DefaultValue*0.7

  gi$INSTRUMENT_NAME.DelayTimesL ftgen 0, 0, gi$INSTRUMENT_NAME.NumberOfBands, -7, gi$INSTRUMENT_NAME.DefaultValue*0.7, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.3, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.5, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.3, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.5
  gi$INSTRUMENT_NAME.DelayTimesR ftgen 0, 0, gi$INSTRUMENT_NAME.NumberOfBands, -7, gi$INSTRUMENT_NAME.DefaultValue*0.3, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.7, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.5, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.7, gi$INSTRUMENT_NAME.NumberOfBands/4, gi$INSTRUMENT_NAME.DefaultValue*0.5

  gi$INSTRUMENT_NAME.FeedBackLevelsL ftgen 0, 0, gi$INSTRUMENT_NAME.NumberOfBands, -7, gi$INSTRUMENT_NAME.DefaultValue*0.2, gi$INSTRUMENT_NAME.NumberOfBands, gi$INSTRUMENT_NAME.DefaultValue*0.2
  gi$INSTRUMENT_NAME.FeedBackLevelsR ftgen 0, 0, gi$INSTRUMENT_NAME.NumberOfBands, -7, gi$INSTRUMENT_NAME.DefaultValue*0.2, gi$INSTRUMENT_NAME.NumberOfBands, gi$INSTRUMENT_NAME.DefaultValue*0.2

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    ; Initialize some operation tables
    iBandInputs = 513
    iMaskL ftgen 0, 0, iBandInputs, -2, 0
    iMaskR ftgen 0, 0, iBandInputs, -2, 0

    iDelayTimesL ftgen 0, 0, 1024, -2, 0
    iDelayTimesR ftgen 0, 0, 1024, -2, 0

    iFeedBackLevelsL ftgen 0, 0, 1024, -2, 0
    iFeedBackLevelsR ftgen 0, 0, 1024, -2, 0

    ; Set some FFT values and initialize the Phase Vocoder Stream
    iFftSize init 1024
    iOverlap = iFftSize*0.25
    iWindowSize = iFftSize*2
    iMaxLength = 5 ;max length of delay buffer

    fFftInL pvsanal aInL, iFftSize, iOverlap, iWindowSize, 1
    fFftInR pvsanal aInR, iFftSize, iOverlap, iWindowSize, 1


    kInputAmountMod = abs(gk$INSTRUMENT_NAME.InputAmountMod)
    kDelayLevelMod = abs(gk$INSTRUMENT_NAME.DelayLevelMod)
    kFeedbackLevelMod = abs(gk$INSTRUMENT_NAME.FeedbackLevelMod)

    ; Copy control tables to full res masks
    tablecopy iMaskL, gi$INSTRUMENT_NAME.InputAmountsL
    tablecopy iDelayTimesL, gi$INSTRUMENT_NAME.DelayTimesL
    tablecopy iFeedBackLevelsL, gi$INSTRUMENT_NAME.FeedBackLevelsL

    tablecopy iMaskR, gi$INSTRUMENT_NAME.InputAmountsR
    tablecopy iDelayTimesR, gi$INSTRUMENT_NAME.DelayTimesR
    tablecopy iFeedBackLevelsR, gi$INSTRUMENT_NAME.FeedBackLevelsR

    ; This cold doesn't work
    if kFeedbackLevelMod > 0 then
      // scale iFeedBackLevelsl to modulate it
      kFeedbackArrayL[] init gi$INSTRUMENT_NAME.NumberOfBands ;create array to store fb values
      copyf2array kFeedbackArrayL, gi$INSTRUMENT_NAME.FeedBackLevelsL ; copy fb table to array (for scaling)
      scalearray kFeedbackArrayL, 0, 1-(kFeedbackLevelMod) ; scale vals in fb table based on lfo val
      copya2ftab kFeedbackArrayL, iFeedBackLevelsL ; copy array to gi$INSTRUMENT_NAME.FeedBack masking table

      kFeedbackArrayR[] init gi$INSTRUMENT_NAME.NumberOfBands ;create array to store fb values
      copyf2array kFeedbackArrayR, gi$INSTRUMENT_NAME.FeedBackLevelsR ; copy fb table to array (for scaling)
      scalearray kFeedbackArrayR, 0, 1-(kFeedbackLevelMod) ; scale vals in fb table based on lfo val
      copya2ftab kFeedbackArrayR, iFeedBackLevelsR ; copy array to gi$INSTRUMENT_NAME.FeedBack masking table
    endif

    fDelayMaskedForFeedbackL pvsinit iFftSize
    fDelayMaskedForFeedbackR pvsinit iFftSize

    ; pvsmaska applies a table of amplitude modifiers to a spectral stream
    ; and those modifiers are scaled by arguemnt 3
    ; I think I don't quite get something here
    fAttenuationMaskL pvsmaska fFftInL, iMaskL, 1-kInputAmountMod
    fAttenuationMaskR pvsmaska fFftInR, iMaskR, 1-kInputAmountMod

    //Delay Line and Buffer
    fFeedbackL pvsmix fAttenuationMaskL, fDelayMaskedForFeedbackL ; mix feedback mask back into buffer
    fFeedbackR pvsmix fAttenuationMaskR, fDelayMaskedForFeedbackR ; mix feedback mask back into buffer

    iBufferL, kWriteTimeL pvsbuffer fFeedbackL, iMaxLength
    iBufferR, kWriteTimeR pvsbuffer fFeedbackR, iMaxLength

    fDelayL pvsbufread2 kWriteTimeL * gk$INSTRUMENT_NAME.DelayTimeMod, iBufferL, iDelayTimesL, iDelayTimesL ;ift 1 & 2 at least n/2 + 1 positions long. n= bins
    fDelayR pvsbufread2 kWriteTimeR * gk$INSTRUMENT_NAME.DelayTimeMod, iBufferR, iDelayTimesR, iDelayTimesR ;ift 1 & 2 at least n/2 + 1 positions long. n= bins

    ; Mask delay streams with feedback table
    fDelayMaskedForFeedbackL pvsmaska fDelayL, iFeedBackLevelsL, 1-kDelayLevelMod
    fDelayMaskedForFeedbackR pvsmaska fDelayR, iFeedBackLevelsR, 1-kDelayLevelMod

    ; f signal to audio
    aOutL pvsynth fDelayL
    aOutR pvsynth fDelayR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

