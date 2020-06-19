instrumentRoute "ItsExpectedBreak", "FreezerInput"
alwayson "ItsExpectedBreakMixerChannel"

gkItsExpectedBreakEqBass init 1
gkItsExpectedBreakEqMid init 1
gkItsExpectedBreakEqHigh init 1
gkItsExpectedBreakFader init 1
gkItsExpectedBreakPan init 50

gSItsExpectedBreakSamplePath = "instruments/breakBeatInstruments/itsExpectedBreak.wav"
giItsExpectedBreakSampleChannels filenchnls gSItsExpectedBreakSamplePath
giItsExpectedBreakSampleLength filelen gSItsExpectedBreakSamplePath

if giItsExpectedBreakSampleChannels = 2 then
  giItsExpectedBreakSampleL ftgen 0, 0, 0, 1, gSItsExpectedBreakSamplePath, 0, 0, 1
  giItsExpectedBreakSampleR ftgen 0, 0, 0, 1, gSItsExpectedBreakSamplePath, 0, 0, 2
else
  giItsExpectedBreakSampleL ftgen 0, 0, 0, 1, gSItsExpectedBreakSamplePath, 0, 0, 0
  giItsExpectedBreakSampleR = 0
endif

instr ItsExpectedBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 16

  aItsExpectedBreakL, aItsExpectedBreakR breakSampler iAmplitude, kPitch, iStartBeat, giItsExpectedBreakSampleLength, iSampleLengthInBeats, giItsExpectedBreakSampleL, giItsExpectedBreakSampleR

  outleta "OutL", aItsExpectedBreakL
  outleta "OutR", aItsExpectedBreakR
endin

instr ItsExpectedBreakBassKnob
  gkItsExpectedBreakEqBass linseg p4, p3, p5
endin

instr ItsExpectedBreakMidKnob
  gkItsExpectedBreakEqMid linseg p4, p3, p5
endin

instr ItsExpectedBreakHighKnob
  gkItsExpectedBreakEqHigh linseg p4, p3, p5
endin

instr ItsExpectedBreakFader
  gkItsExpectedBreakFader linseg p4, p3, p5
endin

instr ItsExpectedBreakPan
  gkItsExpectedBreakPan linseg p4, p3, p5
endin

instr ItsExpectedBreakMixerChannel
  aItsExpectedBreakL inleta "InL"
  aItsExpectedBreakR inleta "InR"

  aItsExpectedBreakL, aItsExpectedBreakR mixerChannel aItsExpectedBreakL, aItsExpectedBreakR, gkItsExpectedBreakFader, gkItsExpectedBreakPan, gkItsExpectedBreakEqBass, gkItsExpectedBreakEqMid, gkItsExpectedBreakEqHigh

  outleta "OutL", aItsExpectedBreakL
  outleta "OutR", aItsExpectedBreakR
endin

