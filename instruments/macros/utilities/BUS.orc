/*
  BUS
  Creates a mixer channel instrument with a route argument. Useful for gathering multiple
  inputs into a single signal for modification.

  Global Variables:
    EqBass - k - Modifies low frequency content of signal
      in a three band equalizer.
    EqMid - k - Modifies mid frequency content of signal
      in a three band equalizer.
    EqHigh - k - Modifies high frequency content of signal
      in a three band equalizer.
    Fader - k - Volume modifier for signal.
    Pan - k - 0 to 100, pans the signal right or left.

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $ROUTE - String - Name of the route for the signal.
*/

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
