gSFunkyDrummerBreakName = "FunkyDrummerBreak"
gSFunkyDrummerBreakRoute = "Mixer"
instrumentRoute gSFunkyDrummerBreakName, gSFunkyDrummerBreakRoute

alwayson "FunkyDrummerBreakMixerChannel"

gkFunkyDrummerBreakEqBass init 1
gkFunkyDrummerBreakEqMid init 1
gkFunkyDrummerBreakEqHigh init 1
gkFunkyDrummerBreakFader init 1
gkFunkyDrummerBreakPan init 50

instr FunkyDrummerBreak
  iSkipTimeInBeats = p4
  kpitchFactor = p5

  SFunkyDrummerBreakFilePath init "songs/IAmCattle/instruments/FunkyDrummerBreak/funkydrummerbreak.wav"
  aFunkyDrummerBreakL, aFunkyDrummerBreakR breakSamplerDiskin SFunkyDrummerBreakFilePath, 16, iSkipTimeInBeats, kpitchFactor

  aFunkyDrummerBreak = aFunkyDrummerBreakL

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

  kFunkyDrummerBreakFader = gkFunkyDrummerBreakFader
  kFunkyDrummerBreakPan = gkFunkyDrummerBreakPan
  kFunkyDrummerBreakEqBass = gkFunkyDrummerBreakEqBass
  kFunkyDrummerBreakEqMid = gkFunkyDrummerBreakEqMid
  kFunkyDrummerBreakEqHigh = gkFunkyDrummerBreakEqHigh

  aFunkyDrummerBreakL, aFunkyDrummerBreakR threeBandEqStereo aFunkyDrummerBreakL, aFunkyDrummerBreakR, kFunkyDrummerBreakEqBass, kFunkyDrummerBreakEqMid, kFunkyDrummerBreakEqHigh

  if kFunkyDrummerBreakPan > 100 then
      kFunkyDrummerBreakPan = 100
  elseif kFunkyDrummerBreakPan < 0 then
      kFunkyDrummerBreakPan = 0
  endif

  aFunkyDrummerBreakL = (aFunkyDrummerBreakL * ((100 - kFunkyDrummerBreakPan) * 2 / 100)) * kFunkyDrummerBreakFader
  aFunkyDrummerBreakR = (aFunkyDrummerBreakR * (kFunkyDrummerBreakPan * 2 / 100)) * kFunkyDrummerBreakFader

  outleta "OutL", aFunkyDrummerBreakL
  outleta "OutR", aFunkyDrummerBreakR
endin

