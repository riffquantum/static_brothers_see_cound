#define REVERSE_DELAY(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'BUFFER_LENGTH) #
  $REVERSE_BUFFER($INSTRUMENT_NAME.Buffer'Mixer'$INSTRUMENT_NAME.DelayInput'$BUFFER_LENGTH)
  $DELAY($INSTRUMENT_NAME.Delay'$WET_ROUTE'$WET_ROUTE'$BUFFER_LENGTH'$BUFFER_LENGTH/4'0.7'1'0)

  alwayson "$INSTRUMENT_NAME.Input"
  stereoRoute "$INSTRUMENT_NAME.Input", "$INSTRUMENT_NAME.BufferInput"
  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    outleta "OutL", aInL
    outleta "OutR", aInR
  endin


  instr $INSTRUMENT_NAME
    event_i "i", "$INSTRUMENT_NAME.Delay", 0, p3
    event_i "i", "$INSTRUMENT_NAME.Buffer", 0, p3
  endin
#
