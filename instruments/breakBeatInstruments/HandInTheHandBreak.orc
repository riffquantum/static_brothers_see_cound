instrumentRoute "HandInTheHandBreak", "FreezerInput"
alwayson "HandInTheHandBreakMixerChannel"

gkHandInTheHandBreakEqBass init 1
gkHandInTheHandBreakEqMid init 1
gkHandInTheHandBreakEqHigh init 1
gkHandInTheHandBreakFader init 1
gkHandInTheHandBreakPan init 50

gSHandInTheHandBreakSamplePath = "instruments/breakBeatInstruments/handInTheHandBreak2.wav"
giHandInTheHandBreakSampleChannels filenchnls gSHandInTheHandBreakSamplePath
giHandInTheHandBreakSampleLength filelen gSHandInTheHandBreakSamplePath

if giHandInTheHandBreakSampleChannels = 2 then
  giHandInTheHandBreakSampleL ftgen 0, 0, 0, 1, gSHandInTheHandBreakSamplePath, 0, 0, 1
  giHandInTheHandBreakSampleR ftgen 0, 0, 0, 1, gSHandInTheHandBreakSamplePath, 0, 0, 2
else
  giHandInTheHandBreakSampleL ftgen 0, 0, 0, 1, gSHandInTheHandBreakSamplePath, 0, 0, 0
  giHandInTheHandBreakSampleR = 0
endif

instr HandInTheHandBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 16

  aHandInTheHandBreakL, aHandInTheHandBreakR breakSampler iAmplitude, kPitch, iStartBeat, giHandInTheHandBreakSampleLength, iSampleLengthInBeats, giHandInTheHandBreakSampleL, giHandInTheHandBreakSampleR

  outleta "OutL", aHandInTheHandBreakL
  outleta "OutR", aHandInTheHandBreakR
endin

instr HandInTheHandBreakBassKnob
  gkHandInTheHandBreakEqBass linseg p4, p3, p5
endin

instr HandInTheHandBreakMidKnob
  gkHandInTheHandBreakEqMid linseg p4, p3, p5
endin

instr HandInTheHandBreakHighKnob
  gkHandInTheHandBreakEqHigh linseg p4, p3, p5
endin

instr HandInTheHandBreakFader
  gkHandInTheHandBreakFader linseg p4, p3, p5
endin

instr HandInTheHandBreakPan
  gkHandInTheHandBreakPan linseg p4, p3, p5
endin

instr HandInTheHandBreakMixerChannel
  aHandInTheHandBreakL inleta "InL"
  aHandInTheHandBreakR inleta "InR"

  aHandInTheHandBreakL, aHandInTheHandBreakR mixerChannel aHandInTheHandBreakL, aHandInTheHandBreakR, gkHandInTheHandBreakFader, gkHandInTheHandBreakPan, gkHandInTheHandBreakEqBass, gkHandInTheHandBreakEqMid, gkHandInTheHandBreakEqHigh

  outleta "OutL", aHandInTheHandBreakL
  outleta "OutR", aHandInTheHandBreakR
endin

