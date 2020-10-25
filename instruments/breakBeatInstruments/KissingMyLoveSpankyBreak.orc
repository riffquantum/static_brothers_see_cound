instrumentRoute "KissingMyLoveSpankyBreak", "DefaultEffectChain"
alwayson "KissingMyLoveSpankyBreakMixerChannel"

gkKissingMyLoveSpankyBreakEqBass init 1
gkKissingMyLoveSpankyBreakEqMid init 1
gkKissingMyLoveSpankyBreakEqHigh init 1
gkKissingMyLoveSpankyBreakFader init 1
gkKissingMyLoveSpankyBreakPan init 50

gSKissingMyLoveSpankyBreakSamplePath = "instruments/breakBeatInstruments/kissingMyLoveSpankyBreak.wav"
giKissingMyLoveSpankyBreakSampleChannels filenchnls gSKissingMyLoveSpankyBreakSamplePath
giKissingMyLoveSpankyBreakSampleLength filelen gSKissingMyLoveSpankyBreakSamplePath

if giKissingMyLoveSpankyBreakSampleChannels = 2 then
  giKissingMyLoveSpankyBreakSampleL ftgen 0, 0, 0, 1, gSKissingMyLoveSpankyBreakSamplePath, 0, 0, 1
  giKissingMyLoveSpankyBreakSampleR ftgen 0, 0, 0, 1, gSKissingMyLoveSpankyBreakSamplePath, 0, 0, 2
else
  giKissingMyLoveSpankyBreakSampleL ftgen 0, 0, 0, 1, gSKissingMyLoveSpankyBreakSamplePath, 0, 0, 0
  giKissingMyLoveSpankyBreakSampleR = 0
endif

instr KissingMyLoveSpankyBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 16

  aKissingMyLoveSpankyBreakL, aKissingMyLoveSpankyBreakR breakSampler iAmplitude, kPitch, iStartBeat, giKissingMyLoveSpankyBreakSampleLength, iSampleLengthInBeats, giKissingMyLoveSpankyBreakSampleL, giKissingMyLoveSpankyBreakSampleR

  outleta "OutL", aKissingMyLoveSpankyBreakL
  outleta "OutR", aKissingMyLoveSpankyBreakR
endin

instr KissingMyLoveSpankyBreakBassKnob
  gkKissingMyLoveSpankyBreakEqBass linseg p4, p3, p5
endin

instr KissingMyLoveSpankyBreakMidKnob
  gkKissingMyLoveSpankyBreakEqMid linseg p4, p3, p5
endin

instr KissingMyLoveSpankyBreakHighKnob
  gkKissingMyLoveSpankyBreakEqHigh linseg p4, p3, p5
endin

instr KissingMyLoveSpankyBreakFader
  gkKissingMyLoveSpankyBreakFader linseg p4, p3, p5
endin

instr KissingMyLoveSpankyBreakPan
  gkKissingMyLoveSpankyBreakPan linseg p4, p3, p5
endin

instr KissingMyLoveSpankyBreakMixerChannel
  aKissingMyLoveSpankyBreakL inleta "InL"
  aKissingMyLoveSpankyBreakR inleta "InR"

  aKissingMyLoveSpankyBreakL, aKissingMyLoveSpankyBreakR mixerChannel aKissingMyLoveSpankyBreakL, aKissingMyLoveSpankyBreakR, gkKissingMyLoveSpankyBreakFader, gkKissingMyLoveSpankyBreakPan, gkKissingMyLoveSpankyBreakEqBass, gkKissingMyLoveSpankyBreakEqMid, gkKissingMyLoveSpankyBreakEqHigh

  outleta "OutL", aKissingMyLoveSpankyBreakL
  outleta "OutR", aKissingMyLoveSpankyBreakR
endin

