#include "../../songs/Charybdis/instruments/CharybdisLoop1.orc"
#include "../../songs/Charybdis/instruments/DelayForCharybdisLoop1.orc"
#include "../../songs/Charybdis/instruments/CharybdisLoop2.orc"
#include "../../songs/Charybdis/instruments/Stab.orc"
#include "../../songs/Charybdis/instruments/RaspingTone.orc"
#include "../../songs/Charybdis/instruments/ChorusForRaspingTone.orc"
#include "../../songs/Charybdis/instruments/DustyBass.orc"
#include "../../songs/Charybdis/instruments/DustyBassGrain.orc"
#include "../../songs/Charybdis/instruments/DelayForDustyBassGrain.orc"

$DRUM_SAMPLE(CharybdisSnare'Mixer'localSamples/Drums/Mixed-Drums_Snare_EA8512.wav'0'1)

instr config
  giCurrentSong = 2
  gaDelayForDustyBassGrainTime = oscil(.1, .05) + 3
  gkDelayForDustyBassGrainFeedbackAmount = .5
  gkDistorted808KickPreGain = 5
  gkBPM = 100
  beatScoreline "ChorusForRaspingTone", 0, -1
  midiMonitor
endin

alwayson "DelayForDustyBassGrain"

instr DustyBassGrainToggle
  if (active("DustyBassGrain") > 0) then
    ; turnoff2 "Dust", 1
  else
    event_i "i", "DustyBassGrain", 0, -1, 30, 2.07
  endif
endin

giCharybdisSongIndex init 2
giEventsForNoteInstruments[giCharybdisSongIndex][giKickNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1
giEventsForNoteInstruments[giCharybdisSongIndex][giKickNote][1] ftgen 0, 0, 0, -2, 1, nstrnum("Distorted808Kick"), 0, 1, 90, 0.5

giEventsForNoteInstruments[giCharybdisSongIndex][giHatPedalNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giSnareNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSnare"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giOrangePadNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("RaspingTone"), 0, 6, 0, 261

giEventsForNoteInstruments[giCharybdisSongIndex][giCrashNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitCrash"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giHatClosedNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1
giEventsForNoteInstruments[giCharybdisSongIndex][giHatPedalNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giHatOpenNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitOpenHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giRideNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitRide"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giTom1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomLow"), 0, 1, 0, 1
giEventsForNoteInstruments[giCharybdisSongIndex][giTom2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomMid"), 0, 1, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giTomPad1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("CharybdisLoop1"), 0, beatsToSeconds(6, 100), 0, 1, 0, 0

giEventsForNoteInstruments[giCharybdisSongIndex][giTomPad2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("CharybdisLoop2"), 0, beatsToSeconds(7, 100), 0, 0.5, 0, 1

giEventsForNoteInstruments[giCharybdisSongIndex][giGreenPadNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("DustyBass"), 0, beatsToSeconds(3, 100), 0, 3.09

giEventsForNoteInstruments[giCharybdisSongIndex][giBluePadNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("DustyBass"), 0, beatsToSeconds(3, 100), 0, 3.07

giEventsForNoteInstruments[giCharybdisSongIndex][giRedPadNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("DustyBassGrainToggle"), 0, 2, 0, 0.5


; Interrupts
giMidiNoteInterruptList[giCharybdisSongIndex][giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("BirdshitOpenHat")
giMidiNoteInterruptList[giCharybdisSongIndex][giHatClosedNote] ftgen 0, 0, 0, -2, nstrnum("BirdshitOpenHat")
