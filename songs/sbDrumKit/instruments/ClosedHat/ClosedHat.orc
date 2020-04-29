gSClosedHatName = "ClosedHat"
gSClosedHatRoute = "Mixer"
instrumentRoute gSClosedHatName, gSClosedHatRoute

alwayson "ClosedHatMixerChannel"

gkClosedHatEqBass init 1.3
gkClosedHatEqMid init 1
gkClosedHatEqHigh init 1
gkClosedHatFader init 1
gkClosedHatPan init 50

gSClosedHatSamplePath ="songs/sbDrumKit/samples/EA7803_R8_Hh.wav"
giClosedHatSampleTableLength getTableSizeFromSample gSClosedHatSamplePath
giClosedHatSample ftgen 0, 0, giClosedHatSampleTableLength, 1, gSClosedHatSamplePath, 0, 0, 0

instr ClosedHat
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aClosedHatSample loscil kAmplitudeEnvelope, 1, giClosedHatSample, 1

  aClosedHat = aClosedHatSample

  outleta "ClosedHatOutL", aClosedHat
  outleta "ClosedHatOutR", aClosedHat
endin

instr ClosedHatBassKnob
  gkClosedHatEqBass linseg p4, p3, p5
endin

instr ClosedHatMidKnob
  gkClosedHatEqMid linseg p4, p3, p5
endin

instr ClosedHatHighKnob
  gkClosedHatEqHigh linseg p4, p3, p5
endin

instr ClosedHatFader
  gkClosedHatFader linseg p4, p3, p5
endin

instr ClosedHatPan
  gkClosedHatPan linseg p4, p3, p5
endin

instr ClosedHatMixerChannel
  aClosedHatL inleta "ClosedHatInL"
  aClosedHatR inleta "ClosedHatInR"

  kClosedHatFader = gkClosedHatFader
  kClosedHatPan = gkClosedHatPan
  kClosedHatEqBass = gkClosedHatEqBass
  kClosedHatEqMid = gkClosedHatEqMid
  kClosedHatEqHigh = gkClosedHatEqHigh

  aClosedHatL, aClosedHatR threeBandEqStereo aClosedHatL, aClosedHatR, kClosedHatEqBass, kClosedHatEqMid, kClosedHatEqHigh

  if kClosedHatPan > 100 then
      kClosedHatPan = 100
  elseif kClosedHatPan < 0 then
      kClosedHatPan = 0
  endif

  aClosedHatL = (aClosedHatL * ((100 - kClosedHatPan) * 2 / 100)) * kClosedHatFader
  aClosedHatR = (aClosedHatR * (kClosedHatPan * 2 / 100)) * kClosedHatFader

  outleta "ClosedHatOutL", aClosedHatL
  outleta "ClosedHatOutR", aClosedHatR
endin
