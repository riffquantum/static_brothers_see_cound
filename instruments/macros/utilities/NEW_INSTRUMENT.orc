#define NEW_INSTRUMENT(INSTRUMENT_NAME'ROUTE'GLOBALS'BODY) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  $GLOBALS

  instr $INSTRUMENT_NAME
    $BODY
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
