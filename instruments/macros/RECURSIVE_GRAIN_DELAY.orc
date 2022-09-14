/*
  RECURSIVE_GRAIN_DELAY
  This is more of a usage pattern than a true instrument macro. Sets up
  delay with a patch out to a granular synthesis effect, resulting
  in recursive granular processing of delay signals.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.

*/

#define RECURSIVE_GRAIN_DELAY(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $DELAY_WITH_PATCH($INSTRUMENT_NAME.Delay'$DRY_ROUTE'$WET_ROUTE'$INSTRUMENT_NAME.GrainInput)
  $LIVE_SYNCLOOP($INSTRUMENT_NAME.Grain'$INSTRUMENT_NAME.DelayPatch'$INSTRUMENT_NAME.DelayPatch')

  alwayson "$INSTRUMENT_NAME.Input"
  stereoRoute "$INSTRUMENT_NAME.Input", "$INSTRUMENT_NAME.DelayInput"
  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    outleta "OutL", aInL
    outleta "OutR", aInR
  endin

  instr $INSTRUMENT_NAME
    event_i "i", "$INSTRUMENT_NAME.Delay", 0, p3
    event_i "i", "$INSTRUMENT_NAME.Grain", 0, p3
  endin
#
