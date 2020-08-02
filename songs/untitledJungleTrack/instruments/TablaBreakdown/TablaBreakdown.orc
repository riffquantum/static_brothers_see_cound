gSTablaBreakdownName = "TablaBreakdown"
gSTablaBreakdownRoute = "Mixer"
instrumentRoute gSTablaBreakdownName, gSTablaBreakdownRoute

alwayson "TablaBreakdownMixerChannel"

gkTablaBreakdownEqBass init 1
gkTablaBreakdownEqMid init 1
gkTablaBreakdownEqHigh init 1
gkTablaBreakdownFader init 1
gkTablaBreakdownPan init 50

instr TablaBreakdown
  kPitchFactor = p4 == 0 ? 1 : p4
  iSkipTimeInBeats = p5

  kPitchFactor *= gkBPM / 153

  STablaBreakdownFilePath init "localSamples/tablabreakdown.wav"
  iWrapAround = 1
  iFormat = 0
  iSkipInit = 0

  aTablaBreakdownL, aTablaBreakdownR diskin STablaBreakdownFilePath, kPitchFactor, iSkipTimeInBeats, iWrapAround, iFormat, iSkipInit


  outleta "OutL", aTablaBreakdownL
  outleta "OutR", aTablaBreakdownR
endin

instr TablaBreakdownBassKnob
  gkTablaBreakdownEqBass linseg p4, p3, p5
endin

instr TablaBreakdownMidKnob
  gkTablaBreakdownEqMid linseg p4, p3, p5
endin

instr TablaBreakdownHighKnob
  gkTablaBreakdownEqHigh linseg p4, p3, p5
endin

instr TablaBreakdownFader
  gkTablaBreakdownFader linseg p4, p3, p5
endin

instr TablaBreakdownPan
  gkTablaBreakdownPan linseg p4, p3, p5
endin

instr TablaBreakdownMixerChannel
  aTablaBreakdownL inleta "InL"
  aTablaBreakdownR inleta "InR"

  aTablaBreakdownL, aTablaBreakdownR mixerChannel aTablaBreakdownL, aTablaBreakdownR, gkTablaBreakdownFader, gkTablaBreakdownPan, gkTablaBreakdownEqBass, gkTablaBreakdownEqMid, gkTablaBreakdownEqHigh

  outleta "OutL", aTablaBreakdownL
  outleta "OutR", aTablaBreakdownR
endin
