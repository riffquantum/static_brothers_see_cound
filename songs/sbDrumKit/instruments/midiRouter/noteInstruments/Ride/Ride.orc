gSMidiNoteSampleList[giRideNote] = "songs/sbDrumKit/samples/EA7811_R8_Ride.wav"
giMidiNoteDurationList[giRideNote] filelen gSMidiNoteSampleList[giRideNote]
giMidiNoteInterruptList[giRideNote] = 0

connect "2049", "RideOutL", "RideMixerChannel", "RideInL"
connect "2049", "RideOutR", "RideMixerChannel", "RideInR"

alwayson "RideMixerChannel"

gkRideEqBass init 1
gkRideEqMid init 1
gkRideEqHigh init 1
gkRideFader init 1
gkRidePan init 50

gSRideSample1Path = gSMidiNoteSampleList[giRideNote]
giRideSample1TableLength getTableSizeFromSample gSRideSample1Path
giRideSample1 ftgen 0, 0, giRideSample1TableLength, 1, gSRideSample1Path, 0, 0, 0

instr 2049 ;Ride, PadA13,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aRide loscil kAmplitudeEnvelope, kPitch, giRideSample1, 1

  outleta "RideOutL", aRide
  outleta "RideOutR", aRide
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
  aRideL inleta "RideInL"
  aRideR inleta "RideInR"

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

  outleta "RideOutL", aRideL
  outleta "RideOutR", aRideR

endin

