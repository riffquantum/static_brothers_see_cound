; Midi Controller Setup
giAvianPeterSongIndex init 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giKickNote][0] ftgen 0, 0, 0, -2, nstrnum("Kick"), 0, 1, 0

giEventsForNoteInstruments[giAvianPeterSongIndex][giSnareNote][0] ftgen 0, 0, 0, -2, nstrnum("Snare"), 0, 1, 0

giEventsForNoteInstruments[giAvianPeterSongIndex][giOrangePadNote][0] ftgen 0, 0, 0, -2, nstrnum("PitchedDownCrash"), 0, 1, 0
giEventsForNoteInstruments[giAvianPeterSongIndex][giCrashNote][0] ftgen 0, 0, 0, -2, nstrnum("Crash"), 0, 1, 0

giEventsForNoteInstruments[giAvianPeterSongIndex][giHatClosedNote][0] ftgen 0, 0, 0, -2, nstrnum("ClosedHat"), 0, 1, 0
giEventsForNoteInstruments[giAvianPeterSongIndex][giHatPedalNote][1] ftgen 0, 0, 0, -2, nstrnum("ClosedHat"), 0, 1, 0

giEventsForNoteInstruments[giAvianPeterSongIndex][giHatOpenNote][0] ftgen 0, 0, 0, -2, nstrnum("OpenHat"), 0, 1, 0

giEventsForNoteInstruments[giAvianPeterSongIndex][giRideNote][0] ftgen 0, 0, 0, -2, nstrnum("Ride"), 0, 1, 0

; Interrupts
giMidiNoteInterruptList[giAvianPeterSongIndex][giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("OpenHat")
