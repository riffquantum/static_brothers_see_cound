instrumentRoute "JbShoutBreak", "FreezerInput"
alwayson "JbShoutBreakMixerChannel"

gkJbShoutBreakEqBass init 1
gkJbShoutBreakEqMid init 1
gkJbShoutBreakEqHigh init 1
gkJbShoutBreakFader init 1
gkJbShoutBreakPan init 50

gSJbShoutBreakSamplePath = "instruments/breakBeatInstruments/jbShoutBreakClean.wav"
giJbShoutBreakSampleChannels filenchnls gSJbShoutBreakSamplePath
giJbShoutBreakSampleLength filelen gSJbShoutBreakSamplePath

if giJbShoutBreakSampleChannels = 2 then
  giJbShoutBreakSampleL ftgen 0, 0, 0, 1, gSJbShoutBreakSamplePath, 0, 0, 1
  giJbShoutBreakSampleR ftgen 0, 0, 0, 1, gSJbShoutBreakSamplePath, 0, 0, 2
else
  giJbShoutBreakSampleL ftgen 0, 0, 0, 1, gSJbShoutBreakSamplePath, 0, 0, 0
  giJbShoutBreakSampleR = 0
endif

instr JbShoutBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 8

  aJbShoutBreakL, aJbShoutBreakR breakSampler iAmplitude, kPitch, iStartBeat, giJbShoutBreakSampleLength, iSampleLengthInBeats, giJbShoutBreakSampleL, giJbShoutBreakSampleR

  outleta "OutL", aJbShoutBreakL
  outleta "OutR", aJbShoutBreakR
endin

instr JbShoutBreakBassKnob
  gkJbShoutBreakEqBass linseg p4, p3, p5
endin

instr JbShoutBreakMidKnob
  gkJbShoutBreakEqMid linseg p4, p3, p5
endin

instr JbShoutBreakHighKnob
  gkJbShoutBreakEqHigh linseg p4, p3, p5
endin

instr JbShoutBreakFader
  gkJbShoutBreakFader linseg p4, p3, p5
endin

instr JbShoutBreakPan
  gkJbShoutBreakPan linseg p4, p3, p5
endin

instr JbShoutBreakMixerChannel
  aJbShoutBreakL inleta "InL"
  aJbShoutBreakR inleta "InR"

  aJbShoutBreakL, aJbShoutBreakR mixerChannel aJbShoutBreakL, aJbShoutBreakR, gkJbShoutBreakFader, gkJbShoutBreakPan, gkJbShoutBreakEqBass, gkJbShoutBreakEqMid, gkJbShoutBreakEqHigh

  outleta "OutL", aJbShoutBreakL
  outleta "OutR", aJbShoutBreakR
endin

