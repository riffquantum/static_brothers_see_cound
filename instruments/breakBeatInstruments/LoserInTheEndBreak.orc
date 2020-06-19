instrumentRoute "LoserInTheEndBreak", "FreezerInput"
alwayson "LoserInTheEndBreakMixerChannel"

gkLoserInTheEndBreakEqBass init 1
gkLoserInTheEndBreakEqMid init 1
gkLoserInTheEndBreakEqHigh init 1
gkLoserInTheEndBreakFader init 1
gkLoserInTheEndBreakPan init 50

gSLoserInTheEndBreakSamplePath = "instruments/breakBeatInstruments/loserInTheEndBreak.wav"
giLoserInTheEndBreakSampleChannels filenchnls gSLoserInTheEndBreakSamplePath
giLoserInTheEndBreakSampleLength filelen gSLoserInTheEndBreakSamplePath

if giLoserInTheEndBreakSampleChannels = 2 then
  giLoserInTheEndBreakSampleL ftgen 0, 0, 0, 1, gSLoserInTheEndBreakSamplePath, 0, 0, 1
  giLoserInTheEndBreakSampleR ftgen 0, 0, 0, 1, gSLoserInTheEndBreakSamplePath, 0, 0, 2
else
  giLoserInTheEndBreakSampleL ftgen 0, 0, 0, 1, gSLoserInTheEndBreakSamplePath, 0, 0, 0
  giLoserInTheEndBreakSampleR = 0
endif

instr LoserInTheEndBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 16

  aLoserInTheEndBreakL, aLoserInTheEndBreakR breakSampler iAmplitude, kPitch, iStartBeat, giLoserInTheEndBreakSampleLength, iSampleLengthInBeats, giLoserInTheEndBreakSampleL, giLoserInTheEndBreakSampleR

  outleta "OutL", aLoserInTheEndBreakL
  outleta "OutR", aLoserInTheEndBreakR
endin

instr LoserInTheEndBreakBassKnob
  gkLoserInTheEndBreakEqBass linseg p4, p3, p5
endin

instr LoserInTheEndBreakMidKnob
  gkLoserInTheEndBreakEqMid linseg p4, p3, p5
endin

instr LoserInTheEndBreakHighKnob
  gkLoserInTheEndBreakEqHigh linseg p4, p3, p5
endin

instr LoserInTheEndBreakFader
  gkLoserInTheEndBreakFader linseg p4, p3, p5
endin

instr LoserInTheEndBreakPan
  gkLoserInTheEndBreakPan linseg p4, p3, p5
endin

instr LoserInTheEndBreakMixerChannel
  aLoserInTheEndBreakL inleta "InL"
  aLoserInTheEndBreakR inleta "InR"

  aLoserInTheEndBreakL, aLoserInTheEndBreakR mixerChannel aLoserInTheEndBreakL, aLoserInTheEndBreakR, gkLoserInTheEndBreakFader, gkLoserInTheEndBreakPan, gkLoserInTheEndBreakEqBass, gkLoserInTheEndBreakEqMid, gkLoserInTheEndBreakEqHigh

  outleta "OutL", aLoserInTheEndBreakL
  outleta "OutR", aLoserInTheEndBreakR
endin

