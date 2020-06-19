instrumentRoute "JohnnyTheFoxBreak", "FreezerInput"
alwayson "JohnnyTheFoxBreakMixerChannel"

gkJohnnyTheFoxBreakEqBass init 1
gkJohnnyTheFoxBreakEqMid init 1
gkJohnnyTheFoxBreakEqHigh init 1
gkJohnnyTheFoxBreakFader init 1
gkJohnnyTheFoxBreakPan init 50

gSJohnnyTheFoxBreakSamplePath = "instruments/breakBeatInstruments/johnnyTheFoxBreak.wav"
giJohnnyTheFoxBreakSampleChannels filenchnls gSJohnnyTheFoxBreakSamplePath
giJohnnyTheFoxBreakSampleLength filelen gSJohnnyTheFoxBreakSamplePath

if giJohnnyTheFoxBreakSampleChannels = 2 then
  giJohnnyTheFoxBreakSampleL ftgen 0, 0, 0, 1, gSJohnnyTheFoxBreakSamplePath, 0, 0, 1
  giJohnnyTheFoxBreakSampleR ftgen 0, 0, 0, 1, gSJohnnyTheFoxBreakSamplePath, 0, 0, 2
else
  giJohnnyTheFoxBreakSampleL ftgen 0, 0, 0, 1, gSJohnnyTheFoxBreakSamplePath, 0, 0, 0
  giJohnnyTheFoxBreakSampleR = 0
endif

instr JohnnyTheFoxBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 12.5

  aJohnnyTheFoxBreakL, aJohnnyTheFoxBreakR breakSampler iAmplitude, kPitch, iStartBeat, giJohnnyTheFoxBreakSampleLength, iSampleLengthInBeats, giJohnnyTheFoxBreakSampleL, giJohnnyTheFoxBreakSampleR

  outleta "OutL", aJohnnyTheFoxBreakL
  outleta "OutR", aJohnnyTheFoxBreakR
endin

instr JohnnyTheFoxBreakBassKnob
  gkJohnnyTheFoxBreakEqBass linseg p4, p3, p5
endin

instr JohnnyTheFoxBreakMidKnob
  gkJohnnyTheFoxBreakEqMid linseg p4, p3, p5
endin

instr JohnnyTheFoxBreakHighKnob
  gkJohnnyTheFoxBreakEqHigh linseg p4, p3, p5
endin

instr JohnnyTheFoxBreakFader
  gkJohnnyTheFoxBreakFader linseg p4, p3, p5
endin

instr JohnnyTheFoxBreakPan
  gkJohnnyTheFoxBreakPan linseg p4, p3, p5
endin

instr JohnnyTheFoxBreakMixerChannel
  aJohnnyTheFoxBreakL inleta "InL"
  aJohnnyTheFoxBreakR inleta "InR"

  aJohnnyTheFoxBreakL, aJohnnyTheFoxBreakR mixerChannel aJohnnyTheFoxBreakL, aJohnnyTheFoxBreakR, gkJohnnyTheFoxBreakFader, gkJohnnyTheFoxBreakPan, gkJohnnyTheFoxBreakEqBass, gkJohnnyTheFoxBreakEqMid, gkJohnnyTheFoxBreakEqHigh

  outleta "OutL", aJohnnyTheFoxBreakL
  outleta "OutR", aJohnnyTheFoxBreakR
endin

