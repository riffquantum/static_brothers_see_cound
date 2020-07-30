instrumentRoute "DefaultOpenHat", "DefaultDrumKitBus"

alwayson "DefaultOpenHatMixerChannel"

gkDefaultOpenHatEqBass init 1.3
gkDefaultOpenHatEqMid init 1
gkDefaultOpenHatEqHigh init 1
gkDefaultOpenHatFader init 1
gkDefaultOpenHatPan init 40

gSDefaultOpenHatSamplePath = "localSamples/Drums/R8-Drums_Open-Hat_E704.wav"
giDefaultOpenHatSample ftgen 0, 0, 0, 1, gSDefaultOpenHatSamplePath, 0, 0, 0

instr DefaultOpenHat
  aDefaultOpenHatL, aDefaultOpenHatR drumSample giDefaultOpenHatSample, p4, p5, 1

  outleta "OutL", aDefaultOpenHatL
  outleta "OutR", aDefaultOpenHatR
endin

instr DefaultOpenHatBassKnob
  gkDefaultOpenHatEqBass linseg p4, p3, p5
endin

instr DefaultOpenHatMidKnob
  gkDefaultOpenHatEqMid linseg p4, p3, p5
endin

instr DefaultOpenHatHighKnob
  gkDefaultOpenHatEqHigh linseg p4, p3, p5
endin

instr DefaultOpenHatFader
  gkDefaultOpenHatFader linseg p4, p3, p5
endin

instr DefaultOpenHatPan
  gkDefaultOpenHatPan linseg p4, p3, p5
endin

instr DefaultOpenHatMixerChannel
  aDefaultOpenHatL inleta "InL"
  aDefaultOpenHatR inleta "InR"

  aDefaultOpenHatL, aDefaultOpenHatR mixerChannel aDefaultOpenHatL, aDefaultOpenHatR, gkDefaultOpenHatFader, gkDefaultOpenHatPan, gkDefaultOpenHatEqBass, gkDefaultOpenHatEqMid, gkDefaultOpenHatEqHigh

  outleta "OutL", aDefaultOpenHatL
  outleta "OutR", aDefaultOpenHatR
endin
