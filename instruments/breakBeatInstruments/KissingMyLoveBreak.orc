instrumentRoute "KissingMyLoveBreak", "FreezerInput"
alwayson "KissingMyLoveBreakMixerChannel"

gkKissingMyLoveBreakEqBass init 1
gkKissingMyLoveBreakEqMid init 1
gkKissingMyLoveBreakEqHigh init 1
gkKissingMyLoveBreakFader init 1
gkKissingMyLoveBreakPan init 50

gSKissingMyLoveBreakSamplePath = "instruments/breakBeatInstruments/kissingMyLoveBreak1.wav"
giKissingMyLoveBreakSampleChannels filenchnls gSKissingMyLoveBreakSamplePath
giKissingMyLoveBreakSampleLength filelen gSKissingMyLoveBreakSamplePath

if giKissingMyLoveBreakSampleChannels = 2 then
  giKissingMyLoveBreakSampleL ftgen 0, 0, 0, 1, gSKissingMyLoveBreakSamplePath, 0, 0, 1
  giKissingMyLoveBreakSampleR ftgen 0, 0, 0, 1, gSKissingMyLoveBreakSamplePath, 0, 0, 2
else
  giKissingMyLoveBreakSampleL ftgen 0, 0, 0, 1, gSKissingMyLoveBreakSamplePath, 0, 0, 0
  giKissingMyLoveBreakSampleR = 0
endif

instr KissingMyLoveBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 8

  aKissingMyLoveBreakL, aKissingMyLoveBreakR breakSampler iAmplitude, kPitch, iStartBeat, giKissingMyLoveBreakSampleLength, iSampleLengthInBeats, giKissingMyLoveBreakSampleL, giKissingMyLoveBreakSampleR

  outleta "OutL", aKissingMyLoveBreakL
  outleta "OutR", aKissingMyLoveBreakR
endin

instr KissingMyLoveBreakBassKnob
  gkKissingMyLoveBreakEqBass linseg p4, p3, p5
endin

instr KissingMyLoveBreakMidKnob
  gkKissingMyLoveBreakEqMid linseg p4, p3, p5
endin

instr KissingMyLoveBreakHighKnob
  gkKissingMyLoveBreakEqHigh linseg p4, p3, p5
endin

instr KissingMyLoveBreakFader
  gkKissingMyLoveBreakFader linseg p4, p3, p5
endin

instr KissingMyLoveBreakPan
  gkKissingMyLoveBreakPan linseg p4, p3, p5
endin

instr KissingMyLoveBreakMixerChannel
  aKissingMyLoveBreakL inleta "InL"
  aKissingMyLoveBreakR inleta "InR"

  aKissingMyLoveBreakL, aKissingMyLoveBreakR mixerChannel aKissingMyLoveBreakL, aKissingMyLoveBreakR, gkKissingMyLoveBreakFader, gkKissingMyLoveBreakPan, gkKissingMyLoveBreakEqBass, gkKissingMyLoveBreakEqMid, gkKissingMyLoveBreakEqHigh

  outleta "OutL", aKissingMyLoveBreakL
  outleta "OutR", aKissingMyLoveBreakR
endin

