giMetronomeIsOn = 1
giMetronomeCount = 1
giMetronomeBeatsPerMeasure = 4
giMetronomeAccents[] fillarray 1
giMetronomeToneSample ftgen 0, 0, 0, 1, "instruments/Metronome/Dance-Kit_Clv_EA8116.wav", 0, 0, 0

connect "MetronomeTone", "MetronomeOutL", "MetronomeMixerChannel", "MetronomeInL"
connect "MetronomeTone", "MetronomeOutR", "MetronomeMixerChannel", "MetronomeInR"

alwayson "MetronomeMixerChannel"

gkMetronomeEqBass init 1
gkMetronomeEqMid init 1
gkMetronomeEqHigh init .1
gkMetronomeFader init .8
gkMetronomePan init 50

instr MetronomeTone
  iToneAmplitude = 0dbfs/3


  if giMetronomeIsOn == 1 then
    if arrayContains(giMetronomeAccents, giMetronomeCount) == 1 then
      aTone loscil iToneAmplitude, 1.1, giMetronomeToneSample, 1
    else
      aTone loscil iToneAmplitude, 1, giMetronomeToneSample, 1
    endif
  endif

  outleta "MetronomeOutL", aTone
  outleta "MetronomeOutR", aTone
endin

instr Metronome
    kTrigger  metro  gkBPM/60

    if giMetronomeIsOn == 1 then
      schedkwhen    kTrigger, 0, 0, "MetronomeTone", 0, gkBPM/60
      schedkwhen    kTrigger, 0, 0, "MetronomeCounter", 0, .1
    endif
endin

instr MetronomeSwitch
  if giMetronomeIsOn == 1 then
    giMetronomeIsOn = 0
    printsBlock "Metronome is Off"
  else
    giMetronomeIsOn = 1
    printsBlock "Metronome is On"
  endif

  giMetronomeCount = 1
endin

instr MetronomeCounter
  giMetronomeCount = giMetronomeCount + 1

  if giMetronomeCount > giMetronomeBeatsPerMeasure then
    giMetronomeCount = 1
  endif
endin

instr MetronomeBassKnob
  gkMetronomeEqBass linseg p4, p3, p5
endin

instr MetronomeMidKnob

  gkMetronomeEqMid linseg p4, p3, p5
endin

instr MetronomeHighKnob
  gkMetronomeEqHigh linseg p4, p3, p5
endin

instr MetronomeFader
  gkMetronomeFader linseg p4, p3, p5
endin

instr MetronomePan
  gkMetronomePan linseg p4, p3, p5
endin

instr MetronomeMixerChannel
  aMetronomeL inleta "MetronomeInL"
  aMetronomeR inleta "MetronomeInR"

  aMetronomeL, aMetronomeR mixerChannel aMetronomeL, aMetronomeR, gkMetronomeFader, gkMetronomePan, gkMetronomeEqBass, gkMetronomeEqMid, gkMetronomeEqHigh

  out aMetronomeL, aMetronomeR
endin

