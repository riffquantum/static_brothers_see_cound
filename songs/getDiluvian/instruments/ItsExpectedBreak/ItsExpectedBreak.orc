gSItsExpectedBreakName = "ItsExpectedBreak"
gSItsExpectedBreakRoute = "Mixer"
instrumentRoute gSItsExpectedBreakName, gSItsExpectedBreakRoute

alwayson "ItsExpectedBreakMixerChannel"

gkItsExpectedBreakEqBass init 1
gkItsExpectedBreakEqMid init 1
gkItsExpectedBreakEqHigh init 1
gkItsExpectedBreakFader init 1
gkItsExpectedBreakPan init 50

instr ItsExpectedBreak
  kpitchFactor = p5
  iSkipTimeInBeats = p4
  SItsExpectedBreakFilePath init "songs/getDiluvian/instruments/ItsExpectedBreak/ItsExpectedBreak.wav"

  aItsExpectedBreakL, aItsExpectedBreakR breakSamplerDiskin SItsExpectedBreakFilePath, 16, iSkipTimeInBeats, kpitchFactor

  aItsExpectedBreak = aItsExpectedBreakL

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

