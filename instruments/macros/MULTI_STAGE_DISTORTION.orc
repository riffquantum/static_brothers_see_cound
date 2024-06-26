/*
  MULTI_MODE_REVERB
  Creates an effect instrument that applies distortion to a signal. Distortion is a
  generated from multiple clipping and filtering stages in sequence.

  Global Variables:
    None

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define MULTI_STAGE_DISTORTION(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
    iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    aSignalOutL += hansDistortion(aSignalOutL, 1.3, .7, .1, .1, iTableLight)
    aSignalOutR += hansDistortion(aSignalOutR, 1.3, .7, .1, .1, iTableLight)

    aSignalOutL = clip(aSignalOutL * 1.3, 1, 1, 0)
    aSignalOutR = clip(aSignalOutL * 1.3, 1, 1, 0)

    aSignalOutL = butterlp(aSignalOutL, 5000)
    aSignalOutR = butterlp(aSignalOutR, 5000)

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
