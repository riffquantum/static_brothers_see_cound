/*
  GRAIN_TO_DELAY
  This is more of a usage pattern than a true instrument macro. Sets up
  a set of instruments to process a signal with granular synthesis
  before passing the processed signal to a delay. The dry signal is
  passed through unaltered.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.

*/

#define GRAIN_TO_DELAY(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $LIVE_SYNCLOOP($INSTRUMENT_NAME.Grain'$DRY_ROUTE'$INSTRUMENT_NAME.DelayInput')
  $DELAY($INSTRUMENT_NAME.Delay''$WET_ROUTE'5'.5'0.7'1'0)

  alwayson "$INSTRUMENT_NAME.Input"
  stereoRoute "$INSTRUMENT_NAME.Input", "$INSTRUMENT_NAME.GrainInput"
  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    outleta "OutL", aInL
    outleta "OutR", aInR
  endin

  instr $INSTRUMENT_NAME
    gk$INSTRUMENT_NAME.DelayDryAmount = 0
    gk$INSTRUMENT_NAME.GrainDryAmount = 1
    event_i "i", "$INSTRUMENT_NAME.Delay", 0, p3
    event_i "i", "$INSTRUMENT_NAME.Grain", 0, p3
  endin
#
