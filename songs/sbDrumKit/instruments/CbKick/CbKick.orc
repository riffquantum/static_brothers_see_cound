connect "3002", "CbKickOutL", "CbKickMixerChannel", "CbKickInL"
connect "3002", "CbKickOutR", "CbKickMixerChannel", "CbKickInR"

connect "CbKickMixerChannel", "CbKickOutL", "Mixer", "MixerInL"
connect "CbKickMixerChannel", "CbKickOutR", "Mixer", "MixerInR"

alwayson "CbKickMixerChannel"

gkCbKickEqBass init 1.3
gkCbKickEqMid init 1
gkCbKickEqHigh init 1
gkCbKickFader init 1
gkCbKickPan init 50

gSCbKickSamplePath ="songs/sbDrumKit/samples/CB_Kick.wav"
giCbKickSampleTableLength getTableSizeFromSample gSCbKickSamplePath
giCbKickSample ftgen 0, 0, giCbKickSampleTableLength, 1, gSCbKickSamplePath, 0, 0, 0

giCbKickInstrumentNumber = 3002

instr 3002 ;CbKick
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aCbKickSample loscil kAmplitudeEnvelope, 1, giCbKickSample, 1


  aCbKick = aCbKickSample

  outleta "CbKickOutL", aCbKick
  outleta "CbKickOutR", aCbKick
endin

instr CbKickBassKnob
  gkCbKickEqBass linseg p4, p3, p5
endin

instr CbKickMidKnob
  gkCbKickEqMid linseg p4, p3, p5
endin

instr CbKickHighKnob
  gkCbKickEqHigh linseg p4, p3, p5
endin

instr CbKickFader
  gkCbKickFader linseg p4, p3, p5
endin

instr CbKickPan
  gkCbKickPan linseg p4, p3, p5
endin

instr CbKickMixerChannel
  aCbKickL inleta "CbKickInL"
  aCbKickR inleta "CbKickInR"

  kCbKickFader = gkCbKickFader
  kCbKickPan = gkCbKickPan
  kCbKickEqBass = gkCbKickEqBass
  kCbKickEqMid = gkCbKickEqMid
  kCbKickEqHigh = gkCbKickEqHigh

  aCbKickL, aCbKickR threeBandEqStereo aCbKickL, aCbKickR, kCbKickEqBass, kCbKickEqMid, kCbKickEqHigh

  if kCbKickPan > 100 then
      kCbKickPan = 100
  elseif kCbKickPan < 0 then
      kCbKickPan = 0
  endif

  aCbKickL = (aCbKickL * ((100 - kCbKickPan) * 2 / 100)) * kCbKickFader
  aCbKickR = (aCbKickR * (kCbKickPan * 2 / 100)) * kCbKickFader

  outleta "CbKickOutL", aCbKickL
  outleta "CbKickOutR", aCbKickR
endin
