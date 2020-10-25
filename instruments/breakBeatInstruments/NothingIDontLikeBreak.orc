instrumentRoute "NothingIDontLikeBreak", "FreezerInput"
alwayson "NothingIDontLikeBreakMixerChannel"

gkNothingIDontLikeBreakEqBass init 1
gkNothingIDontLikeBreakEqMid init 1
gkNothingIDontLikeBreakEqHigh init 1
gkNothingIDontLikeBreakFader init 1
gkNothingIDontLikeBreakPan init 50

gkNothingIDontLikeBreakPitch init 1

gSNothingIDontLikeBreakSamplePath = "instruments/breakBeatInstruments/nothingIDontLikeBreakMono.wav"
giNothingIDontLikeBreakSampleChannels filenchnls gSNothingIDontLikeBreakSamplePath
giNothingIDontLikeBreakSampleLength filelen gSNothingIDontLikeBreakSamplePath

if giNothingIDontLikeBreakSampleChannels = 2 then
  giNothingIDontLikeBreakSampleL ftgen 0, 0, 0, 1, gSNothingIDontLikeBreakSamplePath, 0, 0, 1
  giNothingIDontLikeBreakSampleR ftgen 0, 0, 0, 1, gSNothingIDontLikeBreakSamplePath, 0, 0, 2
else
  giNothingIDontLikeBreakSampleL ftgen 0, 0, 0, 1, gSNothingIDontLikeBreakSamplePath, 0, 0, 0
  giNothingIDontLikeBreakSampleR = 0
endif

instr NothingIDontLikeBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5 * gkNothingIDontLikeBreakPitch
  iStartBeat = p6

  iSampleLengthInBeats = 8

  aNothingIDontLikeBreakL, aNothingIDontLikeBreakR breakSampler iAmplitude, kPitch, iStartBeat, giNothingIDontLikeBreakSampleLength, iSampleLengthInBeats, giNothingIDontLikeBreakSampleL, giNothingIDontLikeBreakSampleR

  outleta "OutL", aNothingIDontLikeBreakL
  outleta "OutR", aNothingIDontLikeBreakR
endin

instr NothingIDontLikeBreakBassKnob
  gkNothingIDontLikeBreakEqBass linseg p4, p3, p5
endin

instr NothingIDontLikeBreakMidKnob
  gkNothingIDontLikeBreakEqMid linseg p4, p3, p5
endin

instr NothingIDontLikeBreakHighKnob
  gkNothingIDontLikeBreakEqHigh linseg p4, p3, p5
endin

instr NothingIDontLikeBreakFader
  gkNothingIDontLikeBreakFader linseg p4, p3, p5
endin

instr NothingIDontLikeBreakPan
  gkNothingIDontLikeBreakPan linseg p4, p3, p5
endin

instr NothingIDontLikeBreakMixerChannel
  aNothingIDontLikeBreakL inleta "InL"
  aNothingIDontLikeBreakR inleta "InR"

  aNothingIDontLikeBreakL, aNothingIDontLikeBreakR mixerChannel aNothingIDontLikeBreakL, aNothingIDontLikeBreakR, gkNothingIDontLikeBreakFader, gkNothingIDontLikeBreakPan, gkNothingIDontLikeBreakEqBass, gkNothingIDontLikeBreakEqMid, gkNothingIDontLikeBreakEqHigh

  outleta "OutL", aNothingIDontLikeBreakL
  outleta "OutR", aNothingIDontLikeBreakR
endin

