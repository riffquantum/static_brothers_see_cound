instrumentRoute "DefaultRide", "DefaultDrumKitBus"

alwayson "DefaultRideMixerChannel"

gkDefaultRideEqBass init 1.3
gkDefaultRideEqMid init 1
gkDefaultRideEqHigh init 1
gkDefaultRideFader init 1
gkDefaultRidePan init 35

gSDefaultRideSamplePath = "localSamples/Drums/R8-Drums_Ride_E741.wav"
giDefaultRideSample ftgen 0, 0, 0, 1, gSDefaultRideSamplePath, 0, 0, 0

instr DefaultRide
  aDefaultRideL, aDefaultRideR drumSample giDefaultRideSample, p4, p5

  outleta "OutL", aDefaultRideL
  outleta "OutR", aDefaultRideR
endin

instr DefaultRideBassKnob
  gkDefaultRideEqBass linseg p4, p3, p5
endin

instr DefaultRideMidKnob
  gkDefaultRideEqMid linseg p4, p3, p5
endin

instr DefaultRideHighKnob
  gkDefaultRideEqHigh linseg p4, p3, p5
endin

instr DefaultRideFader
  gkDefaultRideFader linseg p4, p3, p5
endin

instr DefaultRidePan
  gkDefaultRidePan linseg p4, p3, p5
endin

instr DefaultRideMixerChannel
  aDefaultRideL inleta "InL"
  aDefaultRideR inleta "InR"

  aDefaultRideL, aDefaultRideR mixerChannel aDefaultRideL, aDefaultRideR, gkDefaultRideFader, gkDefaultRidePan, gkDefaultRideEqBass, gkDefaultRideEqMid, gkDefaultRideEqHigh

  outleta "OutL", aDefaultRideL
  outleta "OutR", aDefaultRideR
endin
