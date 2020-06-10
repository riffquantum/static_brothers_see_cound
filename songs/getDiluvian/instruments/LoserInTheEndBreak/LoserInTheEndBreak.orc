gSLoserInTheEndBreakName = "LoserInTheEndBreak"
gSLoserInTheEndBreakRoute = "Mixer"
instrumentRoute gSLoserInTheEndBreakName, gSLoserInTheEndBreakRoute

alwayson "LoserInTheEndBreakMixerChannel"

gkLoserInTheEndBreakEqBass init 1
gkLoserInTheEndBreakEqMid init 1
gkLoserInTheEndBreakEqHigh init 1
gkLoserInTheEndBreakFader init 1
gkLoserInTheEndBreakPan init 50

instr LoserInTheEndBreak
  kpitchFactor = p5
  iSkipTimeInBeats = p4

  SLoserInTheEndBreakFilePath init "songs/getDiluvian/instruments/LoserInTheEndBreak/loserInTheEndBreak.wav"
  aLoserInTheEndBreakL, aLoserInTheEndBreakR breakSamplerDiskin SLoserInTheEndBreakFilePath, 16, iSkipTimeInBeats, kpitchFactor

  aLoserInTheEndBreak = aLoserInTheEndBreakL

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

