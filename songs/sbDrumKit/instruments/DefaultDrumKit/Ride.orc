gSRideName = "Ride"
gSRideRoute = "DrumKitBus"
instrumentRoute gSRideName, gSRideRoute

alwayson "RideMixerChannel"

gkRideEqBass init 1.3
gkRideEqMid init 1
gkRideEqHigh init 1
gkRideFader init 1
gkRidePan init 50

gSRideSamplePath ="songs/sbDrumKit/samples/EA7810_R8_Ride.wav"
giRideSampleTableLength getTableSizeFromSample gSRideSamplePath
giRideSample ftgen 0, 0, giRideSampleTableLength, 1, gSRideSamplePath, 0, 0, 0

instr Ride
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aRideSample loscil kAmplitudeEnvelope, 1, giRideSample, 1


  aRide = aRideSample

  outleta "OutL", aRide
  outleta "OutR", aRide
endin

instr RideBassKnob
  gkRideEqBass linseg p4, p3, p5
endin

instr RideMidKnob
  gkRideEqMid linseg p4, p3, p5
endin

instr RideHighKnob
  gkRideEqHigh linseg p4, p3, p5
endin

instr RideFader
  gkRideFader linseg p4, p3, p5
endin

instr RidePan
  gkRidePan linseg p4, p3, p5
endin

instr RideMixerChannel
  aRideL inleta "InL"
  aRideR inleta "InR"

  kRideFader = gkRideFader
  kRidePan = gkRidePan
  kRideEqBass = gkRideEqBass
  kRideEqMid = gkRideEqMid
  kRideEqHigh = gkRideEqHigh

  aRideL, aRideR threeBandEqStereo aRideL, aRideR, kRideEqBass, kRideEqMid, kRideEqHigh

  if kRidePan > 100 then
      kRidePan = 100
  elseif kRidePan < 0 then
      kRidePan = 0
  endif

  aRideL = (aRideL * ((100 - kRidePan) * 2 / 100)) * kRideFader
  aRideR = (aRideR * (kRidePan * 2 / 100)) * kRideFader

  outleta "OutL", aRideL
  outleta "OutR", aRideR
endin
