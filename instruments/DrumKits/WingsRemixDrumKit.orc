giWingsRemixSongIndex init 10

# define ASSIGN_PAD(SONG_INDEX'NOTE'INDEX'INTERRUPT_SELF'INSTRUMENT'P_FIELDS) #
  giEventsForNoteInstruments[$SONG_INDEX][$NOTE][$INDEX] ftgen 0, 0, 0, -2, $INTERRUPT_SELF, nstrnum("$INSTRUMENT"), $P_FIELDS
#

# define ASSIGN_INTERUPT(SONG_INDEX'NOTE'INTERUPT_LIST) #
  giMidiNoteInterruptList[$SONG_INDEX][$NOTE] ftgen 0, 0, 0, -2, $INTERUPT_LIST
#

$ASSIGN_PAD(giWingsRemixSongIndex'giKickNote'0'BirdshitKick'0, 1, 0, 1)
$ASSIGN_PAD(giWingsRemixSongIndex'giKickNote'1'Distorted808Kick'0, 1, 90, 0.5)
