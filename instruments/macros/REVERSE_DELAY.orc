#define REVERSE_DELAY(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'BUFFER_LENGTH) #
  $REVERSE_BUFFER($INSTRUMENT_NAME.Buffer'$DRY_ROUTE'$INSTRUMENT_NAME.DelayInput'$BUFFER_LENGTH)
  $DELAY($INSTRUMENT_NAME.Delay''$WET_ROUTE'$BUFFER_LENGTH'$BUFFER_LENGTH/4'0.7'1'0)

  alwayson "$INSTRUMENT_NAME.Input"
  stereoRoute "$INSTRUMENT_NAME.Input", "$INSTRUMENT_NAME.BufferInput"

  gk$INSTRUMENT_NAME.DryAmount init 1
  gk$INSTRUMENT_NAME.WetAmount init 1

  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    gk$INSTRUMENT_NAME.BufferDryAmount = gk$INSTRUMENT_NAME.DryAmount
    gk$INSTRUMENT_NAME.DelayWetAmount = gk$INSTRUMENT_NAME.WetAmount

    outleta "OutL", aInL
    outleta "OutR", aInR
  endin


  instr $INSTRUMENT_NAME
    event_i "i", "$INSTRUMENT_NAME.Delay", 0, p3
    event_i "i", "$INSTRUMENT_NAME.Buffer", 0, p3
  endin
#
