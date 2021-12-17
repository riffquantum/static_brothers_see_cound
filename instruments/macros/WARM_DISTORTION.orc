/*
  WARM_DISTORTION
  Creates an effect instrument that applies distortion to a signal. It uses multiple
  gain stages, clipping stages and filters to make a warmer distortion effect.

  Global Variables:
    PreGain - k - Gain applied before clipping.
    PostGain - k - Gain applied after first clipping stage.
    DutyOffset - k - Duty offset value for first clipping stage.
    SlopeShift - k - Slope shift value for first clipping stage.
    Stage2ClipLevel - i - Level for second clipping stage.
    FinalGainAmount - i - Final gain modifier applied before output.
      Typically used for overall volume control of the signal.

  P Fields:
    p4 - PreGainInstanceModifier - Instance modifier of corresponding global variable.
    p5 - PostGainInstanceModifier - Instance modifier of corresponding global variable.
    p6 - DutyOffsetModifier - Instance modifier of corresponding global variable.
    p7 - SlopeShiftOffsetModifier - Instance modifier of corresponding global variable.
    p8 - Stage2ClipLevelInstanceModifier - Instance modifier of corresponding global variable.
    p9 - FinalGainAmountInstanceModifier - Instance modifier of corresponding global variable.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define WARM_DISTORTION(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.PreGain init 10
  gk$INSTRUMENT_NAME.PostGain init 1
  gk$INSTRUMENT_NAME.DutyOffset init .01
  gk$INSTRUMENT_NAME.SlopeShift init .01
  gi$INSTRUMENT_NAME.Stage2ClipLevel init 0dbfs/2
  gi$INSTRUMENT_NAME.FinalGainAmount init .25

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iPreGainInstanceModifier = p4
    iPostGainInstanceModifier = p5
    iDutyOffsetModifier = p6
    iSlopeShiftOffsetModifier = p7
    iStage2ClipLevelInstanceModifier = p8
    iFinalGainAmountInstanceModifier = p9

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    kPreGain = (gk$INSTRUMENT_NAME.PreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
    kPostGain = gk$INSTRUMENT_NAME.PostGain + iPostGainInstanceModifier
    kDutyOffset = (gk$INSTRUMENT_NAME.DutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
    kSlopeShift = (gk$INSTRUMENT_NAME.SlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

    kDeclick madsr .005, .01, 1, .01

    aSignalOutL hansDistortion aSignalInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
    aSignalOutR hansDistortion aSignalInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

    aSignalOutL butterlp aSignalOutL, 1000
    aSignalOutR butterlp aSignalOutR, 1000

    iStage2ClipLevel = gi$INSTRUMENT_NAME.Stage2ClipLevel + iStage2ClipLevelInstanceModifier

    aSignalOutR clip aSignalOutR, 1, iStage2ClipLevel
    aSignalOutL clip aSignalOutL, 1, iStage2ClipLevel


    aSignalOutL butterlp aSignalOutL, 5000
    aSignalOutR butterlp aSignalOutR, 5000

    aSignalOutL *= gi$INSTRUMENT_NAME.FinalGainAmount + iFinalGainAmountInstanceModifier
    aSignalOutR *= gi$INSTRUMENT_NAME.FinalGainAmount + iFinalGainAmountInstanceModifier

    aSignalOutL *= kDeclick
    aSignalOutR *= kDeclick

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
