#define TO_MONO(INSTRUMENT_NAME'ROUTE) #
  alwayson "$INSTRUMENT_NAME"
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOut = aSignalInL + aSignalInR


    outleta "OutL", aSignalOut
    outleta "OutR", aSignalOut
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
