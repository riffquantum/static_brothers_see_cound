instrumentRoute "GettinHappyBreak", "FreezerInput"
alwayson "GettinHappyBreakMixerChannel"

gkGettinHappyBreakEqBass init 1
gkGettinHappyBreakEqMid init 1
gkGettinHappyBreakEqHigh init 1
gkGettinHappyBreakFader init 1
gkGettinHappyBreakPan init 50

gSGettinHappyBreakSamplePath = "instruments/breakBeatInstruments/gettinHappyBreak0.wav"
giGettinHappyBreakSampleChannels filenchnls gSGettinHappyBreakSamplePath
giGettinHappyBreakSampleLength filelen gSGettinHappyBreakSamplePath

if giGettinHappyBreakSampleChannels = 2 then
  giGettinHappyBreakSampleL ftgen 0, 0, 0, 1, gSGettinHappyBreakSamplePath, 0, 0, 1
  giGettinHappyBreakSampleR ftgen 0, 0, 0, 1, gSGettinHappyBreakSamplePath, 0, 0, 2
else
  giGettinHappyBreakSampleL ftgen 0, 0, 0, 1, gSGettinHappyBreakSamplePath, 0, 0, 0
  giGettinHappyBreakSampleR = 0
endif

instr GettinHappyBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 16

  aGettinHappyBreakL, aGettinHappyBreakR breakSampler iAmplitude, kPitch, iStartBeat, giGettinHappyBreakSampleLength, iSampleLengthInBeats, giGettinHappyBreakSampleL, giGettinHappyBreakSampleR

  outleta "OutL", aGettinHappyBreakL
  outleta "OutR", aGettinHappyBreakR
endin

instr GettinHappyBreakBassKnob
  gkGettinHappyBreakEqBass linseg p4, p3, p5
endin

instr GettinHappyBreakMidKnob
  gkGettinHappyBreakEqMid linseg p4, p3, p5
endin

instr GettinHappyBreakHighKnob
  gkGettinHappyBreakEqHigh linseg p4, p3, p5
endin

instr GettinHappyBreakFader
  gkGettinHappyBreakFader linseg p4, p3, p5
endin

instr GettinHappyBreakPan
  gkGettinHappyBreakPan linseg p4, p3, p5
endin

instr GettinHappyBreakMixerChannel
  aGettinHappyBreakL inleta "InL"
  aGettinHappyBreakR inleta "InR"

  aGettinHappyBreakL, aGettinHappyBreakR mixerChannel aGettinHappyBreakL, aGettinHappyBreakR, gkGettinHappyBreakFader, gkGettinHappyBreakPan, gkGettinHappyBreakEqBass, gkGettinHappyBreakEqMid, gkGettinHappyBreakEqHigh

  outleta "OutL", aGettinHappyBreakL
  outleta "OutR", aGettinHappyBreakR
endin

