instrumentRoute "ItsOnlyLoveBreak", "FreezerInput"
alwayson "ItsOnlyLoveBreakMixerChannel"

gkItsOnlyLoveBreakEqBass init 1
gkItsOnlyLoveBreakEqMid init 1
gkItsOnlyLoveBreakEqHigh init 1
gkItsOnlyLoveBreakFader init 1
gkItsOnlyLoveBreakPan init 50

gSItsOnlyLoveBreakSamplePath = "instruments/breakBeatInstruments/itsOnlyLoveBreak.wav"
giItsOnlyLoveBreakSampleChannels filenchnls gSItsOnlyLoveBreakSamplePath
giItsOnlyLoveBreakSampleLength filelen gSItsOnlyLoveBreakSamplePath

if giItsOnlyLoveBreakSampleChannels = 2 then
  giItsOnlyLoveBreakSampleL ftgen 0, 0, 0, 1, gSItsOnlyLoveBreakSamplePath, 0, 0, 1
  giItsOnlyLoveBreakSampleR ftgen 0, 0, 0, 1, gSItsOnlyLoveBreakSamplePath, 0, 0, 2
else
  giItsOnlyLoveBreakSampleL ftgen 0, 0, 0, 1, gSItsOnlyLoveBreakSamplePath, 0, 0, 0
  giItsOnlyLoveBreakSampleR = 0
endif

instr ItsOnlyLoveBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 8

  aItsOnlyLoveBreakL, aItsOnlyLoveBreakR breakSampler iAmplitude, kPitch, iStartBeat, giItsOnlyLoveBreakSampleLength, iSampleLengthInBeats, giItsOnlyLoveBreakSampleL, giItsOnlyLoveBreakSampleR

  outleta "OutL", aItsOnlyLoveBreakL
  outleta "OutR", aItsOnlyLoveBreakR
endin

instr ItsOnlyLoveBreakBassKnob
  gkItsOnlyLoveBreakEqBass linseg p4, p3, p5
endin

instr ItsOnlyLoveBreakMidKnob
  gkItsOnlyLoveBreakEqMid linseg p4, p3, p5
endin

instr ItsOnlyLoveBreakHighKnob
  gkItsOnlyLoveBreakEqHigh linseg p4, p3, p5
endin

instr ItsOnlyLoveBreakFader
  gkItsOnlyLoveBreakFader linseg p4, p3, p5
endin

instr ItsOnlyLoveBreakPan
  gkItsOnlyLoveBreakPan linseg p4, p3, p5
endin

instr ItsOnlyLoveBreakMixerChannel
  aItsOnlyLoveBreakL inleta "InL"
  aItsOnlyLoveBreakR inleta "InR"

  aItsOnlyLoveBreakL, aItsOnlyLoveBreakR mixerChannel aItsOnlyLoveBreakL, aItsOnlyLoveBreakR, gkItsOnlyLoveBreakFader, gkItsOnlyLoveBreakPan, gkItsOnlyLoveBreakEqBass, gkItsOnlyLoveBreakEqMid, gkItsOnlyLoveBreakEqHigh

  outleta "OutL", aItsOnlyLoveBreakL
  outleta "OutR", aItsOnlyLoveBreakR
endin

