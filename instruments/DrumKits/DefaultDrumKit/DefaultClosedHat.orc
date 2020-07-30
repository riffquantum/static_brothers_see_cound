instrumentRoute "DefaultClosedHat", "DefaultDrumKitBus"

alwayson "DefaultClosedHatMixerChannel"

gkDefaultClosedHatEqBass init 1.3
gkDefaultClosedHatEqMid init 1
gkDefaultClosedHatEqHigh init 1
gkDefaultClosedHatFader init 1
gkDefaultClosedHatPan init 50

gSDefaultClosedHatSamplePath = "localSamples/Drums/R8-Drums_Closed-Hat_E703.wav"
giDefaultClosedHatSample ftgen 0, 0, 0, 1, gSDefaultClosedHatSamplePath, 0, 0, 0

instr DefaultClosedHat
  aDefaultClosedHatL, aDefaultClosedHatR drumSample giDefaultClosedHatSample, p4, p5

  outleta "OutL", aDefaultClosedHatL
  outleta "OutR", aDefaultClosedHatR
endin

instr DefaultClosedHatBassKnob
  gkDefaultClosedHatEqBass linseg p4, p3, p5
endin

instr DefaultClosedHatMidKnob
  gkDefaultClosedHatEqMid linseg p4, p3, p5
endin

instr DefaultClosedHatHighKnob
  gkDefaultClosedHatEqHigh linseg p4, p3, p5
endin

instr DefaultClosedHatFader
  gkDefaultClosedHatFader linseg p4, p3, p5
endin

instr DefaultClosedHatPan
  gkDefaultClosedHatPan linseg p4, p3, p5
endin

instr DefaultClosedHatMixerChannel
  aDefaultClosedHatL inleta "InL"
  aDefaultClosedHatR inleta "InR"

  aDefaultClosedHatL, aDefaultClosedHatR mixerChannel aDefaultClosedHatL, aDefaultClosedHatR, gkDefaultClosedHatFader, gkDefaultClosedHatPan, gkDefaultClosedHatEqBass, gkDefaultClosedHatEqMid, gkDefaultClosedHatEqHigh

  outleta "OutL", aDefaultClosedHatL
  outleta "OutR", aDefaultClosedHatR
endin
