gSTablaRassaRanga2Name = "TablaRassaRanga2"
gSTablaRassaRanga2Route = "Mixer"
instrumentRoute gSTablaRassaRanga2Name, gSTablaRassaRanga2Route

alwayson "TablaRassaRanga2MixerChannel"

gkTablaRassaRanga2EqBass init 1
gkTablaRassaRanga2EqMid init 1
gkTablaRassaRanga2EqHigh init 1
gkTablaRassaRanga2Fader init 1
gkTablaRassaRanga2Pan init 50

instr TablaRassaRanga2
  kPitchFactor = p4 == 0 ? 1 : p4
  iSkipTimeInBeats = p5

  kPitchFactor *= gkBPM / 146


  STablaRassaRanga2FilePath init "songs/untitledJungleTrack/instruments/TablaRassaRanga2/tablarasaranga2.wav"
  iWrapAround = 1
  iFormat = 0
  iSkipInit = 0

  aTablaRassaRanga2L, aTablaRassaRanga2R diskin STablaRassaRanga2FilePath, kPitchFactor, iSkipTimeInBeats, iWrapAround, iFormat, iSkipInit


  outleta "OutL", aTablaRassaRanga2L
  outleta "OutR", aTablaRassaRanga2R
endin

instr TablaRassaRanga2BassKnob
  gkTablaRassaRanga2EqBass linseg p4, p3, p5
endin

instr TablaRassaRanga2MidKnob
  gkTablaRassaRanga2EqMid linseg p4, p3, p5
endin

instr TablaRassaRanga2HighKnob
  gkTablaRassaRanga2EqHigh linseg p4, p3, p5
endin

instr TablaRassaRanga2Fader
  gkTablaRassaRanga2Fader linseg p4, p3, p5
endin

instr TablaRassaRanga2Pan
  gkTablaRassaRanga2Pan linseg p4, p3, p5
endin

instr TablaRassaRanga2MixerChannel
  aTablaRassaRanga2L inleta "InL"
  aTablaRassaRanga2R inleta "InR"

  aTablaRassaRanga2L, aTablaRassaRanga2R mixerChannel aTablaRassaRanga2L, aTablaRassaRanga2R, gkTablaRassaRanga2Fader, gkTablaRassaRanga2Pan, gkTablaRassaRanga2EqBass, gkTablaRassaRanga2EqMid, gkTablaRassaRanga2EqHigh

  outleta "OutL", aTablaRassaRanga2L
  outleta "OutR", aTablaRassaRanga2R
endin
