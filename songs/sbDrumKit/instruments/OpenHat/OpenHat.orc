gSOpenHatName = "OpenHat"
gSOpenHatRoute = "Mixer"
instrumentRoute gSOpenHatName, gSOpenHatRoute

alwayson "OpenHatMixerChannel"

gkOpenHatEqBass init 1.3
gkOpenHatEqMid init 1
gkOpenHatEqHigh init 1
gkOpenHatFader init 1
gkOpenHatPan init 50

gSOpenHatSamplePath ="songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giOpenHatSampleTableLength getTableSizeFromSample gSOpenHatSamplePath
giOpenHatSample ftgen 0, 0, giOpenHatSampleTableLength, 1, gSOpenHatSamplePath, 0, 0, 0

instr OpenHat
  iNoteVelocity = p4
  iAmplitude velocityToAmplitude iNoteVelocity
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aOpenHatSample loscil kAmplitudeEnvelope, 1, giOpenHatSample, 1


  aOpenHat = aOpenHatSample

  outleta "OpenHatOutL", aOpenHat
  outleta "OpenHatOutR", aOpenHat
endin

instr OpenHatBassKnob
  gkOpenHatEqBass linseg p4, p3, p5
endin

instr OpenHatMidKnob
  gkOpenHatEqMid linseg p4, p3, p5
endin

instr OpenHatHighKnob
  gkOpenHatEqHigh linseg p4, p3, p5
endin

instr OpenHatFader
  gkOpenHatFader linseg p4, p3, p5
endin

instr OpenHatPan
  gkOpenHatPan linseg p4, p3, p5
endin

instr OpenHatMixerChannel
  aOpenHatL inleta "OpenHatInL"
  aOpenHatR inleta "OpenHatInR"

  kOpenHatFader = gkOpenHatFader
  kOpenHatPan = gkOpenHatPan
  kOpenHatEqBass = gkOpenHatEqBass
  kOpenHatEqMid = gkOpenHatEqMid
  kOpenHatEqHigh = gkOpenHatEqHigh

  aOpenHatL, aOpenHatR threeBandEqStereo aOpenHatL, aOpenHatR, kOpenHatEqBass, kOpenHatEqMid, kOpenHatEqHigh

  if kOpenHatPan > 100 then
      kOpenHatPan = 100
  elseif kOpenHatPan < 0 then
      kOpenHatPan = 0
  endif

  aOpenHatL = (aOpenHatL * ((100 - kOpenHatPan) * 2 / 100)) * kOpenHatFader
  aOpenHatR = (aOpenHatR * (kOpenHatPan * 2 / 100)) * kOpenHatFader

  outleta "OpenHatOutL", aOpenHatL
  outleta "OpenHatOutR", aOpenHatR
endin
