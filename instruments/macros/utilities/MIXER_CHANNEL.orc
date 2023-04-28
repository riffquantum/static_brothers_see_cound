/*
  BUS
  Creates a mixer channel instrument that applies volume, panning and EQ modifications
  to a signal.

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
*/

#define MIXER_CHANNEL(INSTRUMENT_NAME) #
  alwayson "$INSTRUMENT_NAME.MixerChannel"

  gk$INSTRUMENT_NAME.EqBass init 1
  gk$INSTRUMENT_NAME.EqMid init 1
  gk$INSTRUMENT_NAME.EqHigh init 1
  gk$INSTRUMENT_NAME.Fader init 1
  gk$INSTRUMENT_NAME.Pan init 50

  instr $INSTRUMENT_NAME.MixerChannel
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"


    aSignalOutL, aSignalOutR mixerChannel aSignalInL, aSignalInR, gk$INSTRUMENT_NAME.Fader, gk$INSTRUMENT_NAME.Pan, gk$INSTRUMENT_NAME.EqBass, gk$INSTRUMENT_NAME.EqMid, gk$INSTRUMENT_NAME.EqHigh

    ; IDEA FOR BOUNCING STEMS -- Set the SONG_MACRO macro and declare the gSStemsToWrite array
    ; as a list of instrument names in the main csd.
    ; if arrayContainsS(gSStemsToWrite, "$INSTRUMENT_NAME") == 1 then
    ;   fout "songs/$SONG_NAME/stems/$SONG_NAME._$INSTRUMENT_NAME..wav", 14, aSignalOutL, aSignalOutR
    ; endif

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin
#
