instrumentRoute "FunkyDrummerBreak", "FreezerInput"
alwayson "FunkyDrummerBreakMixerChannel"

gkFunkyDrummerBreakEqBass init 1
gkFunkyDrummerBreakEqMid init 1
gkFunkyDrummerBreakEqHigh init 1
gkFunkyDrummerBreakFader init 1
gkFunkyDrummerBreakPan init 50

gSFunkyDrummerBreakSamplePath = "instruments/breakBeatInstruments/funkyDrummerBreak.wav"
giFunkyDrummerBreakSampleChannels filenchnls gSFunkyDrummerBreakSamplePath
giFunkyDrummerBreakSampleLength filelen gSFunkyDrummerBreakSamplePath

if giFunkyDrummerBreakSampleChannels = 2 then
  giFunkyDrummerBreakSampleL ftgen 0, 0, 0, 1, gSFunkyDrummerBreakSamplePath, 0, 0, 1
  giFunkyDrummerBreakSampleR ftgen 0, 0, 0, 1, gSFunkyDrummerBreakSamplePath, 0, 0, 2
else
  giFunkyDrummerBreakSampleL ftgen 0, 0, 0, 1, gSFunkyDrummerBreakSamplePath, 0, 0, 0
  giFunkyDrummerBreakSampleR = 0
endif

instr FunkyDrummerBreak
  iAmplitude = velocityToAmplitude(p4)
  kPitch = p5
  iStartBeat = p6

  iSampleLengthInBeats = 32

  aFunkyDrummerBreakL, aFunkyDrummerBreakR breakSampler iAmplitude, kPitch, iStartBeat, giFunkyDrummerBreakSampleLength, iSampleLengthInBeats, giFunkyDrummerBreakSampleL, giFunkyDrummerBreakSampleR

  outleta "OutL", aFunkyDrummerBreakL
  outleta "OutR", aFunkyDrummerBreakR
endin

instr FunkyDrummerBreakBassKnob
  gkFunkyDrummerBreakEqBass linseg p4, p3, p5
endin

instr FunkyDrummerBreakMidKnob
  gkFunkyDrummerBreakEqMid linseg p4, p3, p5
endin

instr FunkyDrummerBreakHighKnob
  gkFunkyDrummerBreakEqHigh linseg p4, p3, p5
endin

instr FunkyDrummerBreakFader
  gkFunkyDrummerBreakFader linseg p4, p3, p5
endin

instr FunkyDrummerBreakPan
  gkFunkyDrummerBreakPan linseg p4, p3, p5
endin

instr FunkyDrummerBreakMixerChannel
  aFunkyDrummerBreakL inleta "InL"
  aFunkyDrummerBreakR inleta "InR"

  aFunkyDrummerBreakL, aFunkyDrummerBreakR mixerChannel aFunkyDrummerBreakL, aFunkyDrummerBreakR, gkFunkyDrummerBreakFader, gkFunkyDrummerBreakPan, gkFunkyDrummerBreakEqBass, gkFunkyDrummerBreakEqMid, gkFunkyDrummerBreakEqHigh

  outleta "OutL", aFunkyDrummerBreakL
  outleta "OutR", aFunkyDrummerBreakR
endin

