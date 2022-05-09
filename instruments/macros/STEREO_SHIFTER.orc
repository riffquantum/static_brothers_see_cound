/*
  STEREO_SHIFTER
  Creates an effect instrument that recieves a stereo signal and pans them individually.
  Can be used to flip a stereo image, isolate one side, or convert mono.

  Global Variables:
    LeftPan - k - A Panning value between -50 and 50 that will affect the left signal.
    RightPan - k - A Panning value between -50 and 50 that will affect the right signal.

  P Fields:
    p4 - LeftPan - Number - A Panning value between -50 and 50 corresponding
      to left and right respectively.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define STEREO_SHIFTER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.LeftPan init 0
  gk$INSTRUMENT_NAME.RightPan init 100

  gk$INSTRUMENT_NAME.LeftAmount init 1
  gk$INSTRUMENT_NAME.RightAmount init 1


  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    iLeftPan = p4
    iRightPan = p5
    kLeftPan = limit(iLeftPan + gk$INSTRUMENT_NAME.LeftPan, -50, 50)
    kRightPan = limit(iRightPan + gk$INSTRUMENT_NAME.RightPan, -50, 50)

    aLeftLeft = aInL * ((100 - kLeftPan)/100) * gk$INSTRUMENT_NAME.LeftAmount
    aLeftRight = aInL * (kLeftPan / 100) * gk$INSTRUMENT_NAME.LeftAmount

    aRightLeft  = aInR * ((100 - kRightPan)/100) * gk$INSTRUMENT_NAME.RightAmount
    aRightRight  = aInR * (kRightPan / 100) * gk$INSTRUMENT_NAME.RightAmount

    aOutL = aLeftLeft + aRightLeft
    aOutR = aRightRight + aLeftRight

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
