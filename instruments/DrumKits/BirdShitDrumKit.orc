;Kicks
$DRUM_SAMPLE(BirdshitCbKick'BirdshitKickBus'localSamples/CB_Kick.wav'1'1)
$DRUM_SAMPLE(BirdshitLongDeepKick'BirdshitKickBus'localSamples/Drums/R8-Drums_Kick_EA7604.wav'1'1)

$DRUM_SAMPLE(BirdshitSharpKick'BirdshitReverbForSharpKick'localSamples/Drums/R8-Drums_Kick_EA7614.wav'1'1)
gkBirdshitReverbForSharpKickWetAmount init .2
gkBirdshitReverbForSharpKickDry init 1
gkBirdshitReverbForSharpKickDelay init .9
gkBirdshitReverbForSharpKickCutoff init sr/2-100

alwayson "BirdshitReverbForSharpKick"
stereoRoute "BirdshitReverbForSharpKick", "BirdshitKickBus"
instr BirdshitReverbForSharpKick
  aSignalL inleta "InL"
  aSignalR inleta "InR"

  aSignalWetL, aSignalWetR reverbsc aSignalL, aSignalR, gkBirdshitReverbForSharpKickDelay, gkBirdshitReverbForSharpKickCutoff

  kHighFrequencyDampening = .1
  aSignalWetL, aSignalWetR freeverb aSignalWetL, aSignalWetR, gkBirdshitReverbForSharpKickDelay, kHighFrequencyDampening

  aSignalOutL = (aSignalWetL * gkBirdshitReverbForSharpKickWetAmount) + (aSignalL * gkBirdshitReverbForSharpKickDry)
  aSignalOutR = (aSignalWetR * gkBirdshitReverbForSharpKickWetAmount) + (aSignalR * gkBirdshitReverbForSharpKickDry)

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr BirdshitKick
  event_i "i", "BirdshitCbKick", 0, p3, p4, p5
  event_i "i", "BirdshitLongDeepKick", 0, p3, p4, p5
  event_i "i", "BirdshitSharpKick", 0, p3, p4, p5
endin

$BUS(BirdshitKickBus'BirdshitBus)

;Snares
$DRUM_SAMPLE(BirdshitSnare'BirdshitSnareBus'localSamples/Drums/R8-Drums_Snare_EA7741.wav'1'1)
$DRUM_SAMPLE(BirdshitSharpSnare'BirdshitSnareBus'localSamples/Drums/R8-Drums_Snare_EA7739.wav'1'1)

instr BirdshitSnare
  event_i "i", "Snare", 0, p3, p4, p5

  if p4 > 100 then
    event_i "i", "SharpSnare", 0, p3, p4, p5
  endif
endin

$BUS(BirdshitSnareBus'BirdshitBus)

;Other Drums
$DRUM_SAMPLE(BirdshitCrash'BirdshitBus'localSamples/Drums/R8-Drums_Crash_EA7847.wav'1'1) ; missing from localsamples

$DRUM_SAMPLE(BirdshitPitchedDownCrash'BirdshitBus'localSamples/Drums/R8-Drums_Crash_EA7847.wav'1'1)
gkBirdshitPitchedDownCrashTuning init .5

$DRUM_SAMPLE(BirdshitClosedHat'BirdshitBus'localSamples/Drums/R8-Drums_Closed-Hat_EA7803.wav'1'1)
$DRUM_SAMPLE(BirdshitOpenHat'BirdshitBus'localSamples/Drums/R8-Drums_Open-Hat_EA7804.wav'1'1)
$DRUM_SAMPLE(BirdshitRide'BirdshitBus'localSamples/Drums/R8-Drums_Ride_EA7810.wav'1'1)
$DRUM_SAMPLE(BirdshitTomLow'BirdshitBus'localSamples/Drums/R8-Drums_Tom_E7661.wav'0'1)
$DRUM_SAMPLE(BirdshitTomMid'BirdshitBus'localSamples/Drums/R8-Drums_Tom_E7662.wav'0'1)


;Final Bus
alwayson "BirdshitFxMainReverb"
$BUS(BirdshitBus'BirdshitFxMainReverbInput)
$FT_CONV_REVERB(BirdshitFxMainReverb'BirdshitPostFxBus'BirdshitPostFxBus'./localSamples/IMreverbs/Narrow Bumpy Space.wav)
$BUS(BirdshitPostFxBus'Mixer)


instrumentRoute "BirdshitSynth", "BirdshitSynthDistortion"
instr BirdshitSynth
  print p4
  print p5
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5
  iSineTable sineWave
  kTremolo = .75 + oscil(.25, 1.5, iSineTable)
  kAmplitudeEnvelope = madsr(.005, .01, 1, .5, 0) * iAmplitude
  kAmplitudeEnvelope = kAmplitudeEnvelope * kTremolo

  aBirdShitSynthL = oscil(kAmplitudeEnvelope*0.5, iPitch*1.1, iSineTable)
  aBirdShitSynthL += oscil(kAmplitudeEnvelope, iPitch*1.1*.5, iSineTable)
  aBirdShitSynthL += oscil(kAmplitudeEnvelope*0.25, iPitch*1.1*.9, iSineTable)

  aBirdShitSynthR = oscil(kAmplitudeEnvelope*0.5, iPitch*.9, iSineTable)
  aBirdShitSynthR += oscil(kAmplitudeEnvelope, iPitch*.9*.5, iSineTable)
  aBirdShitSynthR += oscil(kAmplitudeEnvelope*0.25, iPitch*.9*.9, iSineTable)


  outleta "OutL", aBirdShitSynthL
  outleta "OutR", aBirdShitSynthR
endin
$MIXER_CHANNEL(BirdshitSynth)

instrumentRoute "BirdshitSynthDistortion", "Mixer"
alwayson "BirdshitSynthDistortion"
instr BirdshitSynthDistortion
  aBirdShitSynthDistortionInL inleta "InL"
  aBirdShitSynthDistortionInR inleta "InR"

  aBirdShitSynthDistortionOutL = aBirdShitSynthDistortionInL
  aBirdShitSynthDistortionOutR = aBirdShitSynthDistortionInR

  aBirdShitSynthDistortionOutL += hansDistortion(aBirdShitSynthDistortionOutL, 1.3, .7, .1, .1)
  aBirdShitSynthDistortionOutR += hansDistortion(aBirdShitSynthDistortionOutR, 1.3, .7, .1, .1)

  aBirdShitSynthDistortionOutL = clip(aBirdShitSynthDistortionOutL * 1.3, 1, 1, 0)
  aBirdShitSynthDistortionOutR = clip(aBirdShitSynthDistortionOutL * 1.3, 1, 1, 0)

  aBirdShitSynthDistortionOutL = butterlp(aBirdShitSynthDistortionOutL, 5000)
  aBirdShitSynthDistortionOutR = butterlp(aBirdShitSynthDistortionOutR, 5000)

  outleta "OutL", aBirdShitSynthDistortionOutL
  outleta "OutR", aBirdShitSynthDistortionOutR
endin
$MIXER_CHANNEL(BirdshitSynthDistortion)


; Midi Controller Setup
giBirshitSongIndex init 1
giEventsForNoteInstruments[giBirshitSongIndex][giKickNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1
giEventsForNoteInstruments[giBirshitSongIndex][giHatPedalNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitKick"), 0, 1, 0, 1

giEventsForNoteInstruments[giBirshitSongIndex][giSnareNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSnare"), 0, 1, 0, 1

giEventsForNoteInstruments[giBirshitSongIndex][giOrangePadNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitPitchedDownCrash"), 0, 2, 0, 1
giEventsForNoteInstruments[giBirshitSongIndex][giCrashNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitCrash"), 0, 1, 0, 1

giEventsForNoteInstruments[giBirshitSongIndex][giHatClosedNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1
giEventsForNoteInstruments[giBirshitSongIndex][giHatPedalNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitClosedHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giBirshitSongIndex][giHatOpenNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitOpenHat"), 0, 1, 0, 1

giEventsForNoteInstruments[giBirshitSongIndex][giRideNote][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitRide"), 0, 1, 0, 1

giEventsForNoteInstruments[giBirshitSongIndex][giTom1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomLow"), 0, 1, 0, 1
giEventsForNoteInstruments[giBirshitSongIndex][giTom2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("BirdshitTomMid"), 0, 1, 0, 1
giEventsForNoteInstruments[giBirshitSongIndex][giTomPad1Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("Distorted808Kick"), 0, 2, 0, 0.5

giBirdshitGreenNoteFrequency mtof 48
giEventsForNoteInstruments[giBirshitSongIndex][giGreenPadNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSynth"), 0, 2, 0, giBirdshitGreenNoteFrequency
giEventsForNoteInstruments[giBirshitSongIndex][giGreenPadNote][1] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSynth"), 0, 2, 0, giBirdshitGreenNoteFrequency*2

giBirdshitTomPad2Frequency mtof 51
giEventsForNoteInstruments[giBirshitSongIndex][giTomPad2Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("BirdshitSynth"), 0, 2, 0, giBirdshitTomPad2Frequency

; Interrupts
giMidiNoteInterruptList[giBirshitSongIndex][giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("BirdshitOpenHat")
giMidiNoteInterruptList[giBirshitSongIndex][giHatClosedNote] ftgen 0, 0, 0, -2, nstrnum("BirdshitOpenHat")
