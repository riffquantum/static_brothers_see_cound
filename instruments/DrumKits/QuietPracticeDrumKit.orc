;Kicks
$DRUM_SAMPLE_V1(QuietPracticeCbKick'QuietPracticeKickBus'localSamples/CB_Kick.wav'1'1)
$DRUM_SAMPLE_V1(QuietPracticeLongDeepKick'QuietPracticeKickBus'localSamples/Drums/R8-Drums_Kick_EA7604.wav'1'1)

$DRUM_SAMPLE_V1(QuietPracticeSharpKick'QuietPracticeReverbForSharpKick'localSamples/Drums/R8-Drums_Kick_EA7614.wav'1'1)

$BREAK_SAMPLE(LoseControl'Mixer'localSamples/loseControlTighter.wav'4)


instr QuietPracticeConfig

endin

stereoRoute "QuietPracticeReverbForSharpKick", "QuietPracticeKickBus"

gkQuietPracticeReverbForSharpKickWetAmount init .2
gkQuietPracticeReverbForSharpKickDry init 1
gkQuietPracticeReverbForSharpKickDelay init .9
gkQuietPracticeReverbForSharpKickCutoff init sr/2-100
gkQuietPracticePitchedDownCrashTuning init .5

instr QuietPracticeReverbForSharpKick
  aSignalL inleta "InL"
  aSignalR inleta "InR"

  aSignalWetL, aSignalWetR reverbsc aSignalL, aSignalR, gkQuietPracticeReverbForSharpKickDelay, gkQuietPracticeReverbForSharpKickCutoff

  kHighFrequencyDampening = .1
  aSignalWetL, aSignalWetR freeverb aSignalWetL, aSignalWetR, gkQuietPracticeReverbForSharpKickDelay, kHighFrequencyDampening

  aSignalOutL = (aSignalWetL * gkQuietPracticeReverbForSharpKickWetAmount) + (aSignalL * gkQuietPracticeReverbForSharpKickDry)
  aSignalOutR = (aSignalWetR * gkQuietPracticeReverbForSharpKickWetAmount) + (aSignalR * gkQuietPracticeReverbForSharpKickDry)

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr QuietPracticeKick
  event_i "i", "QuietPracticeCbKick", 0, p3, p4, p5
  event_i "i", "QuietPracticeLongDeepKick", 0, p3, p4, p5
  event_i "i", "QuietPracticeSharpKick", 0, p3, p4, p5
endin

$BUS(QuietPracticeKickBus'Mixer)

;Snares
$DRUM_SAMPLE_V1(QuietPracticeSnare'QuietPracticeSnareBus'localSamples/Drums/R8-Drums_Snare_EA7741.wav'1'1)
$DRUM_SAMPLE_V1(QuietPracticeSharpSnare'QuietPracticeSnareBus'localSamples/Drums/R8-Drums_Snare_EA7739.wav'1'1)

instr QuietPracticeSnare
  event_i "i", "Snare", 0, p3, p4, p5

  if p4 > 100 then
    event_i "i", "SharpSnare", 0, p3, p4, p5
  endif
endin

$BUS(QuietPracticeSnareBus'QuietPracticeBus)

;Other Drums
$DRUM_SAMPLE_V1(QuietPracticeCrash'QuietPracticeBus'localSamples/Drums/R8-Drums_Crash_EA7847.wav'1'1) ; missing from localsamples

$DRUM_SAMPLE_V1(QuietPracticePitchedDownCrash'QuietPracticeBus'localSamples/Drums/R8-Drums_Crash_EA7847.wav'1'1)


$DRUM_SAMPLE_V1(QuietPracticeClosedHat'QuietPracticeBus'localSamples/Drums/R8-Drums_Closed-Hat_EA7803.wav'1'1)
$DRUM_SAMPLE_V1(QuietPracticeOpenHat'QuietPracticeBus'localSamples/Drums/R8-Drums_Open-Hat_EA7804.wav'1'1)
$DRUM_SAMPLE_V1(QuietPracticeRide'QuietPracticeBus'localSamples/Drums/R8-Drums_Ride_EA7810.wav'1'1)
$DRUM_SAMPLE_V1(QuietPracticeTomLow'QuietPracticeBus'localSamples/Drums/R8-Drums_Tom_E7661.wav'0'1)
$DRUM_SAMPLE_V1(QuietPracticeTomMid'QuietPracticeBus'localSamples/Drums/R8-Drums_Tom_E7662.wav'0'1)

;Final Bus
$BUS(QuietPracticeBus'QuietPracticeFxMainReverbInput)
$FT_CONV_REVERB(QuietPracticeFxMainReverb'QuietPracticePostFxBus'QuietPracticePostFxBus'./localSamples/IMreverbs/Narrow Bumpy Space.wav)
$BUS(QuietPracticePostFxBus'Mixer)


giHatClutchIsOpen = 1
giHatPedalEngaged = 1
instr ToggleHatClutch
  if giHatClutchIsOpen == 1 && giHatPedalEngaged == 1 then
    giHatClutchIsOpen = 0
    giHatPedalEngaged = 0
    printsBlock "Hi Hat Pedal Off and Clutch Closed"
  elseif giHatClutchIsOpen == 0 then
    giHatClutchIsOpen = 1
    giHatPedalEngaged = 0
    printsBlock "Hi Hat Pedal Off and Clutch Open"
  else
    giHatClutchIsOpen = 1
    giHatPedalEngaged = 1
    printsBlock "Hi Hat Pedal On"
  endif
endin

giDoubleKickOn = 1
instr ToggleDoubleKick
  if giDoubleKickOn == 1 then
    giDoubleKickOn = 0
    printsBlock "Double Kick Off"
  else
    giDoubleKickOn = 1
    printsBlock "Double Kick On"
  endif
endin

instr QuietPracticeHatPedal
  if giHatPedalEngaged == 1 then
    turnoff2 nstrnum("QuietPracticeOpenHat"), 0, 1
    interruptThenTrigger nstrnum("QuietPracticeClosedHat"), 0, p3, p4, p5
  endif

  if giDoubleKickOn == 1 then
    event_i "i", "QuietPracticeKick", 0, p3, p4, p5
  endif
endin

instr QuietPracticeOpenHatPad
  if giHatClutchIsOpen == 1 then
    event_i "i", "QuietPracticeOpenHat", 0, p3, p4, p5
  else
    interruptThenTrigger nstrnum("QuietPracticeClosedHat"), 0, p3, p4, p5
  endif
endin

instr QuietPracticeClosedHatPad
  if giHatPedalEngaged == 0 && giHatClutchIsOpen == 1 then
    event_i "i", "QuietPracticeOpenHat", 0, p3, p4, p5
  else
    interruptThenTrigger nstrnum("QuietPracticeClosedHat"), 0, p3, p4, p5
  endif
endin


; Midi Controller Setup
giQuietPracticeSongIndex init 4
giEventsForNoteInstruments[giQuietPracticeSongIndex][giKickNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeKick"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giHatPedalNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeHatPedal"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giSnareNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeSnare"), 0, 1, 0, 1
giEventsForNoteInstruments[giQuietPracticeSongIndex][giTomPad1Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeSnare"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giSpd30Pad4Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("QuietPracticePitchedDownCrash"), 0, 2, 0, 1
giEventsForNoteInstruments[giQuietPracticeSongIndex][giSpd30Pad1Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeCrash"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giHatClosedNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeClosedHatPad"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giHatOpenNote][0] ftgen 0, 0, 0, -2, 0, nstrnum("QuietPracticeOpenHatPad"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giSpd30Pad4Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("QuietPracticeRide"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giSpd30Pad8Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("QuietPracticeTomLow"), 0, 1, 0, 1
giEventsForNoteInstruments[giQuietPracticeSongIndex][giSpd30Pad7Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("QuietPracticeTomMid"), 0, 1, 0, 1

giEventsForNoteInstruments[giQuietPracticeSongIndex][giSpd30Pad2Note][0] ftgen 0, 0, 0, -2, 1, nstrnum("LoseControl"), 0, bts(4/1.125), 0, 1.075, 0

; Hat Pedal Controls
giEventsForNoteInstruments[giQuietPracticeSongIndex][giPadC2Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("ToggleHatClutch"), 0, 1/sr
giEventsForNoteInstruments[giQuietPracticeSongIndex][giPadC3Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("ToggleDoubleKick"), 0, 1/sr


; Interrupts
; giMidiNoteInterruptList[giQuietPracticeSongIndex][giHatPedalNote] ftgen 0, 0, 0, -2, nstrnum("QuietPracticeOpenHat")
; giMidiNoteInterruptList[giQuietPracticeSongIndex][giHatClosedNote] ftgen 0, 0, 0, -2, nstrnum("QuietPracticeOpenHat")

giMidiNoteInterruptList[giQuietPracticeSongIndex][giKickNote] ftgen 0, 0, 0, -2, nstrnum("QuietPracticeCbKick"), nstrnum("QuietPracticeLongDeepKick"), nstrnum("QuietPracticeSharpKick")


instr QuietPracticeInit
  iOnOff = p6

  if iOnOff == 1 then
    prints "%n%n Initializing QuietPractice %n%n"
    giCurrentSong = giQuietPracticeSongIndex
    event_i "i", "QuietPracticeConfig", 0, -1
    event_i "i", "QuietPracticeReverbForSharpKick", 0, -1
    event_i "i", "QuietPracticeFxMainReverb", 0, -1
    gkBPM = 100
    giMetronomeCount = 0
    giMetronomeBeatsPerMeasure = 4
    giMetronomeAccents[] init 1
    giMetronomeAccents fillarray 1
  else
    turnoff2 "QuietPracticeConfig", 0, 1
    turnoff2 "QuietPracticeReverbForSharpKick", 0, 1
    turnoff2 "QuietPracticeFxMainReverb", 0, 1
  endif
endin
