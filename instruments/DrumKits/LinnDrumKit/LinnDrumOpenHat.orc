instrumentRoute "LinnDrumOpenHat", "LinnDrumKitBus"

alwayson "LinnDrumOpenHatMixerChannel"

gkLinnDrumOpenHatEqBass init 1.3
gkLinnDrumOpenHatEqMid init 1
gkLinnDrumOpenHatEqHigh init 1
gkLinnDrumOpenHatFader init 1
gkLinnDrumOpenHatPan init 40

gSLinnDrumOpenHatSamplePath = "localSamples/Drums/Linn-Drum_Open-Hat_1.wav"
giLinnDrumOpenHatSample ftgen 0, 0, 0, 1, gSLinnDrumOpenHatSamplePath, 0, 0, 0

instr LinnDrumOpenHat
  aLinnDrumOpenHatL, aLinnDrumOpenHatR drumSample giLinnDrumOpenHatSample, p4, p5, 1

  outleta "OutL", aLinnDrumOpenHatL
  outleta "OutR", aLinnDrumOpenHatR
endin

instr LinnDrumOpenHatBassKnob
  gkLinnDrumOpenHatEqBass linseg p4, p3, p5
endin

instr LinnDrumOpenHatMidKnob
  gkLinnDrumOpenHatEqMid linseg p4, p3, p5
endin

instr LinnDrumOpenHatHighKnob
  gkLinnDrumOpenHatEqHigh linseg p4, p3, p5
endin

instr LinnDrumOpenHatFader
  gkLinnDrumOpenHatFader linseg p4, p3, p5
endin

instr LinnDrumOpenHatPan
  gkLinnDrumOpenHatPan linseg p4, p3, p5
endin

instr LinnDrumOpenHatMixerChannel
  aLinnDrumOpenHatL inleta "InL"
  aLinnDrumOpenHatR inleta "InR"

  aLinnDrumOpenHatL, aLinnDrumOpenHatR mixerChannel aLinnDrumOpenHatL, aLinnDrumOpenHatR, gkLinnDrumOpenHatFader, gkLinnDrumOpenHatPan, gkLinnDrumOpenHatEqBass, gkLinnDrumOpenHatEqMid, gkLinnDrumOpenHatEqHigh

  outleta "OutL", aLinnDrumOpenHatL
  outleta "OutR", aLinnDrumOpenHatR
endin
