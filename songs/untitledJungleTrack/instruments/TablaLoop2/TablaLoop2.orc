gSTablaLoop2Name = "TablaLoop2"
gSTablaLoop2Route = "Mixer"
instrumentRoute gSTablaLoop2Name, gSTablaLoop2Route

alwayson "TablaLoop2MixerChannel"

gkTablaLoop2EqBass init 1
gkTablaLoop2EqMid init 1
gkTablaLoop2EqHigh init 1
gkTablaLoop2Fader init 1
gkTablaLoop2Pan init 50

instr TablaLoop2
  kPitchFactor = p4 == 0 ? 1 : p4
  iSkipTimeInBeats = p5

  kPitchFactor *= gkBPM / 146


  STablaLoop2FilePath init "localSamples/Ravi Shankar - Tabla Rassa Ranga/tablaloop2.wav"
  iWrapAround = 1
  iFormat = 0
  iSkipInit = 0

  aTablaLoop2L, aTablaLoop2R diskin STablaLoop2FilePath, kPitchFactor, iSkipTimeInBeats, iWrapAround, iFormat, iSkipInit


  outleta "OutL", aTablaLoop2L
  outleta "OutR", aTablaLoop2R
endin

instr TablaLoop2BassKnob
  gkTablaLoop2EqBass linseg p4, p3, p5
endin

instr TablaLoop2MidKnob
  gkTablaLoop2EqMid linseg p4, p3, p5
endin

instr TablaLoop2HighKnob
  gkTablaLoop2EqHigh linseg p4, p3, p5
endin

instr TablaLoop2Fader
  gkTablaLoop2Fader linseg p4, p3, p5
endin

instr TablaLoop2Pan
  gkTablaLoop2Pan linseg p4, p3, p5
endin

instr TablaLoop2MixerChannel
  aTablaLoop2L inleta "InL"
  aTablaLoop2R inleta "InR"

  aTablaLoop2L, aTablaLoop2R mixerChannel aTablaLoop2L, aTablaLoop2R, gkTablaLoop2Fader, gkTablaLoop2Pan, gkTablaLoop2EqBass, gkTablaLoop2EqMid, gkTablaLoop2EqHigh

  outleta "OutL", aTablaLoop2L
  outleta "OutR", aTablaLoop2R
endin
