/*
  GRAIN_TO_DELAY
  This is more of a usage pattern than a true instrument macro. Sets up
  a set of instruments to apply delay to a signal and then process the
  delay signal only through granular synthesis. The dry signal is passed
  through unaltered.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.

*/

#define DELAY_TO_GRAIN(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $DELAY($INSTRUMENT_NAME.Delay'$DRY_ROUTE'$INSTRUMENT_NAME.GrainInput'5'.5'0.7'1'0)
  $LIVE_SYNCLOOP($INSTRUMENT_NAME.Grain''$WET_ROUTE')

  alwayson "$INSTRUMENT_NAME.Input"
  stereoRoute "$INSTRUMENT_NAME.Input", "$INSTRUMENT_NAME.DelayInput"
  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    outleta "OutL", aInL
    outleta "OutR", aInR
  endin

  instr $INSTRUMENT_NAME
    gk$INSTRUMENT_NAME.DelayDryAmount = 1
    gk$INSTRUMENT_NAME.GrainDryAmount = 0
    event_i "i", "$INSTRUMENT_NAME.Delay", 0, p3
    event_i "i", "$INSTRUMENT_NAME.Grain", 0, p3
  endin
#
