giVileArcSongIndex init 3
#include "../../songs/VileArc/instruments/KickHelix.orc"
#include "../../songs/VileArc/instruments/HatWarp.orc"
#include "../../songs/VileArc/instruments/PainSpiral.orc"
#include "../../songs/VileArc/instruments/GlobalReverb.orc"
; #include "../../songs/VileArc/instruments/Snare.orc"
#include "../../songs/VileArc/instruments/DistortionForSnare.orc"
#include "../../songs/VileArc/instruments/FlangeDelayForSnare.orc"
#include "../../songs/VileArc/instruments/DelayForSnare.orc"
#include "../../songs/VileArc/instruments/ReverbForSnare.orc"
#include "../../songs/VileArc/instruments/DistortionForAwfulCrash.orc"
#include "../../songs/VileArc/instruments/AwfulCrash.orc"
#include "../../songs/VileArc/instruments/DelayForAwfulCrash.orc"

$DRUM_SAMPLE(VileArcSnare'DistortionForSnareInput'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'0'1)


instr VileArcPattern1
  iVariation = p6
  iGrainVariation random 0, 7

  print iGrainVariation

  interruptThenTrigger nstrnum("KickHelix"), beatsToSeconds(4), 100, 3.05
  event_i "i", nstrnum("HatWarp"), 0, beatsToSeconds(4), 100, 3.05

  event_i "i", "PainSpiral", 0.0, beatsToSeconds(2.5), 120, 2.06
  event_i "i", "PainSpiral", 0.0, beatsToSeconds(2.5), 120, 4.06

  if iVariation == 1 then
    interruptThenTrigger nstrnum("HatWarp"), beatsToSeconds(4), 40, 2.05
  elseif iVariation == 2 then
    interruptThenTrigger nstrnum("HatWarp"), beatsToSeconds(4), 40, 1.05
  endif

  if iGrainVariation >= 3 && iGrainVariation < 4 then
    prints "%n variation 1 %n"
    gkKickHelixGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(4), 0, 0, 1, \
      2, 1, \
      2, 1.3, \
      0, 1, \
      0 \
    )
    gkHatWarpGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(4), 0, 0, 1, \
      2, 1, \
      2, 1.3, \
      0, 1, \
      0 \
    )
  elseif iGrainVariation >= 4 && iGrainVariation < 5 then
    prints "%n variation 2 %n"

    gkKickHelixGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(4), 0, 0, 1, \
      1.5, 4, \
      0, 1, \
      0 \
    )
    gkHatWarpGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(4), 0, 0, 1, \
      2, 1, \
      2, .75, \
      0, 1, \
      0 \
    )
  elseif iGrainVariation >= 5 && iGrainVariation < 6 then
    prints "%n variation 3 %n"
    gkKickHelixGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(4), 0, 0, 1, \
      2, 1.25, \
      2, 1.8, \
      0 \
    )
    gkHatWarpGrainFrequencyAdjustment = loopseg( 1/beatsToSeconds(4), 0, 0, 1, \
      2, .75, \
      2, 1.8, \
      0, 1, \
      0 \
    )
  else
    prints "%n regular %n"
    gkKickHelixGrainFrequencyAdjustment = 1
    gkHatWarpGrainFrequencyAdjustment = 1
  endif

endin

instr VileArcPattern2

  gkKickHelixGrainFrequencyAdjustment = 2.1
  interruptThenTrigger nstrnum("KickHelix"), beatsToSeconds(4), 70, 3.05
  interruptThenTrigger nstrnum("HatWarp"), beatsToSeconds(4), 100, 3.05

  event_i "i", "AwfulCrash", 0.0, beatsToSeconds(2.5), 0, .25
endin

instr VileArcBridge
  event_i "i", "PainSpiral", 0, secondsToBeats(9.5), 120, 2.06
  event_i "i", "PainSpiral", 0, secondsToBeats(9.5), 120, 4.06
endin

giEventsForNoteInstruments[giVileArcSongIndex][giSpd30Pad5Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("VileArcPattern1"), 0, beatsToSeconds(2, 100), 0, 0, 0
giEventsForNoteInstruments[giVileArcSongIndex][giSpd30Pad6Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("VileArcPattern1"), 0, beatsToSeconds(2, 100), 0, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giSpd30Pad7Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("VileArcPattern1"), 0, beatsToSeconds(2, 100), 0, 0, 2

giEventsForNoteInstruments[giVileArcSongIndex][giSpd30Pad1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("VileArcBridge"), 0, beatsToSeconds(2, 100), 0, 0


giEventsForNoteInstruments[giVileArcSongIndex][giSpd30Pad2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("VileArcPattern2"), 0, beatsToSeconds(2, 100), 0, 0

giEventsForNoteInstruments[giVileArcSongIndex][giSnareNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSnare"), 0, 1, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giKickNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitCbKick"), 0, 1, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giKickNote][1] ftgen 0, 0, 0, -2, 1, nstrnum("Distorted808Kick"), 0, 2, 40, 0.5

giEventsForNoteInstruments[giVileArcSongIndex][giHatClosedNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giHatPedalNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giHatPedalNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giVileArcSongIndex][giHatOpenNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitOpenHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giVileArcSongIndex][giTom1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomLow"), 0, 1, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giTom2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomMid"), 0, 1, 0, 1

; Interrupts
giMidiNoteInterruptList[giVileArcSongIndex][giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("BirdshitOpenHat")
giMidiNoteInterruptList[giVileArcSongIndex][giHatClosedNote] ftgen 0, 0, 0, -2, nstrnum("BirdshitOpenHat")


instr VileArcConfig
  gkBPM = 80
  giGlobalReverbMode = 3
  gkGlobalReverbWetAmount = .275 + oscil(.025, 1/beatsToSeconds(32))

  gkPainSpiralFader = 1.1

  giDistorted808KickFinalGainAmount = .75

  gkKickHelixEqBass = 1.5
  gkKickHelixFader = 0.9

  gkHatWarpFader = 1.1
  gkDistorted808KickPreGain = 1
  ; gkPreClipMixerFader = .75

  gaDelayForAwfulCrashTime = oscil(0.00004, 15) + 0.00085 + oscil(0.0001, 1/beatsToSeconds(3))
  gkDistortionForAwfulCrashFader = .0025

  gkDistortionForSnareFader = .0025
  gkSnareFader = 2
  gkReverbForSnareWetAmount = .15

  event_i "i", "GlobalReverb", 0, -1
  event_i "i", "DistortionForSnare", 0, -1

endin

giEventsForNoteInstruments[giVileArcSongIndex][giPadC13Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 0
giEventsForNoteInstruments[giVileArcSongIndex][giPadC14Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 1
giEventsForNoteInstruments[giVileArcSongIndex][giPadC15Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 2
giEventsForNoteInstruments[giVileArcSongIndex][giPadC16Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 0.1, 0, 0, 3
