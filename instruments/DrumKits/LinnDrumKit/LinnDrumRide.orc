instrumentRoute "LinnDrumRide", "LinnDrumKitBus"

alwayson "LinnDrumRideMixerChannel"

gkLinnDrumRideEqBass init 1.3
gkLinnDrumRideEqMid init 1
gkLinnDrumRideEqHigh init 1
gkLinnDrumRideFader init 1
gkLinnDrumRidePan init 35

gSLinnDrumRideSamplePath = "localSamples/Drums/Linn-Drum_Ride_1.wav"
giLinnDrumRideSample ftgen 0, 0, 0, 1, gSLinnDrumRideSamplePath, 0, 0, 0

instr LinnDrumRide
  aLinnDrumRideL, aLinnDrumRideR drumSample giLinnDrumRideSample, p4, p5

  outleta "OutL", aLinnDrumRideL
  outleta "OutR", aLinnDrumRideR
endin

instr LinnDrumRideBassKnob
  gkLinnDrumRideEqBass linseg p4, p3, p5
endin

instr LinnDrumRideMidKnob
  gkLinnDrumRideEqMid linseg p4, p3, p5
endin

instr LinnDrumRideHighKnob
  gkLinnDrumRideEqHigh linseg p4, p3, p5
endin

instr LinnDrumRideFader
  gkLinnDrumRideFader linseg p4, p3, p5
endin

instr LinnDrumRidePan
  gkLinnDrumRidePan linseg p4, p3, p5
endin

instr LinnDrumRideMixerChannel
  aLinnDrumRideL inleta "InL"
  aLinnDrumRideR inleta "InR"

  aLinnDrumRideL, aLinnDrumRideR mixerChannel aLinnDrumRideL, aLinnDrumRideR, gkLinnDrumRideFader, gkLinnDrumRidePan, gkLinnDrumRideEqBass, gkLinnDrumRideEqMid, gkLinnDrumRideEqHigh

  outleta "OutL", aLinnDrumRideL
  outleta "OutR", aLinnDrumRideR
endin
