#define BUS(INSTRUMENT_NAME'ROUTE) #
  stereoRoute "$INSTRUMENT_NAME", "$ROUTE"
  alwayson "$INSTRUMENT_NAME"

  gk$INSTRUMENT_NAME.EqBass init 1
  gk$INSTRUMENT_NAME.EqMid init 1
  gk$INSTRUMENT_NAME.EqHigh init 1
  gk$INSTRUMENT_NAME.Fader init 1
  gk$INSTRUMENT_NAME.Pan init 50

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutL, aSignalOutR mixerChannel aSignalInL, aSignalInR, gk$INSTRUMENT_NAME.Fader, gk$INSTRUMENT_NAME.Pan, gk$INSTRUMENT_NAME.EqBass, gk$INSTRUMENT_NAME.EqMid, gk$INSTRUMENT_NAME.EqHigh

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin
#
