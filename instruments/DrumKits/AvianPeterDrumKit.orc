#include "../../songs/AvianPeter/instruments/PhotoshopSamples/PhotoshopSamples.orc"
#include "../../songs/AvianPeter/instruments/PunishmentAwaits/PunishmentAwaits.orc"
#include "../../songs/AvianPeter/instruments/PunishYou/PunishYou.orc"

; Midi Controller Setup
giAvianPeterSongIndex init 1

instr AvianPeterConfig
  gkPhotoshopSamplesFader = 0.75
endin

; Drums
giEventsForNoteInstruments[giAvianPeterSongIndex][giKickNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giHatPedalNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1

giEventsForNoteInstruments[giAvianPeterSongIndex][giSnareNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSnare"), 0, 1, 0, 1

giEventsForNoteInstruments[giAvianPeterSongIndex][giSpd30Pad4Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitPitchedDownCrash"), 0, 2, 0, 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giCrashNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitCrash"), 0, 1, 0, 1

giEventsForNoteInstruments[giAvianPeterSongIndex][giHatClosedNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giHatPedalNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giAvianPeterSongIndex][giHatOpenNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitOpenHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giAvianPeterSongIndex][giRideNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitRide"), 0, 1, 0, 1

giEventsForNoteInstruments[giAvianPeterSongIndex][giTom1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomLow"), 0, 1, 0, 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giTom2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomMid"), 0, 1, 0, 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giTomPad1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("Distorted808Kick"), 0, 2, 0, 0.5

; Photoshop Samples
giEventsForNoteInstruments[giAvianPeterSongIndex][giRideNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 7
giEventsForNoteInstruments[giAvianPeterSongIndex][giHatOpenNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 5
giEventsForNoteInstruments[giAvianPeterSongIndex][giHatClosedNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 0
giEventsForNoteInstruments[giAvianPeterSongIndex][giHatPedalNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 3
giEventsForNoteInstruments[giAvianPeterSongIndex][giCrashNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0,1
giEventsForNoteInstruments[giAvianPeterSongIndex][giKickNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 4
giEventsForNoteInstruments[giAvianPeterSongIndex][giSnareNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 8
giEventsForNoteInstruments[giAvianPeterSongIndex][giTomPad1Note][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 11
giEventsForNoteInstruments[giAvianPeterSongIndex][giTomPad2Note][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 12
giEventsForNoteInstruments[giAvianPeterSongIndex][giTom1Note][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 9
giEventsForNoteInstruments[giAvianPeterSongIndex][giTom2Note][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 10
giEventsForNoteInstruments[giAvianPeterSongIndex][giSpd30Pad5Note][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 6
giEventsForNoteInstruments[giAvianPeterSongIndex][giSpd30Pad6Note][1] ftgen 0, 0, 0, -2, 0, nstrnum("PhotoshopSamples"), 0, 1, 0, 2

; Other Samples
giEventsForNoteInstruments[giAvianPeterSongIndex][giSpd30Pad1Note][1] ftgen 0, 0, 0, -2, 1, nstrnum("PunishmentAwaits"), 0, 0.75, 0, 6
giEventsForNoteInstruments[giAvianPeterSongIndex][giSpd30Pad5Note][1] ftgen 0, 0, 0, -2, 1, nstrnum("PunishmentAwaits"), 0, 4, 0, 6
giEventsForNoteInstruments[giAvianPeterSongIndex][giSpd30Pad6Note][1] ftgen 0, 0, 0, -2, 1, nstrnum("PunishYou"), 0, 4, 0, 2

; Interrupts

giMidiNoteInterruptList[giAvianPeterSongIndex][giSpd30Pad1Note] ftgen 0, 0, 0, -2, nstrnum("PunishYou")
giMidiNoteInterruptList[giAvianPeterSongIndex][giSpd30Pad5Note] ftgen 0, 0, 0, -2, nstrnum("PunishYou")
giMidiNoteInterruptList[giAvianPeterSongIndex][giSpd30Pad6Note] ftgen 0, 0, 0, -2, nstrnum("PunishmentAwaits")


giEventsForNoteInstruments[giAvianPeterSongIndex][giPadC13Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 0
giEventsForNoteInstruments[giAvianPeterSongIndex][giPadC14Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 1
giEventsForNoteInstruments[giAvianPeterSongIndex][giPadC15Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 2
giEventsForNoteInstruments[giAvianPeterSongIndex][giPadC16Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 3
