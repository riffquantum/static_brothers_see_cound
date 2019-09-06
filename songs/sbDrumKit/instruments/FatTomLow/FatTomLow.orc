connect "3014", "FatTomLowOutL", "FatTomLowMixerChannel", "FatTomLowInL"
connect "3014", "FatTomLowOutR", "FatTomLowMixerChannel", "FatTomLowInR"

connect "FatTomLowMixerChannel", "FatTomLowOutL", "Mixer", "MixerInL"
connect "FatTomLowMixerChannel", "FatTomLowOutR", "Mixer", "MixerInR"

alwayson "FatTomLowMixerChannel"

gkFatTomLowEqBass init 1.3
gkFatTomLowEqMid init 1
gkFatTomLowEqHigh init 1
gkFatTomLowFader init 1
gkFatTomLowPan init 50

gSFatTomLowSamplePath ="songs/sbDrumKit/samples/EA7847_R8_Crsh.wav"
giFatTomLowSampleTableLength getTableSizeFromSample gSFatTomLowSamplePath
giFatTomLowSample ftgen 0, 0, giFatTomLowSampleTableLength, 1, gSFatTomLowSamplePath, 0, 0, 0

giFatTomLowInstrumentNumber = 3014

instr 3014 ;FatTomLow
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aFatTomLowSample loscil kAmplitudeEnvelope, 1, giFatTomLowSample, 1

  aFatTomLow = aFatTomLowSample

  outleta "FatTomLowOutL", aFatTomLow
  outleta "FatTomLowOutR", aFatTomLow
endin

instr FatTomLowBassKnob
  gkFatTomLowEqBass linseg p4, p3, p5
endin

instr FatTomLowMidKnob
  gkFatTomLowEqMid linseg p4, p3, p5
endin

instr FatTomLowHighKnob
  gkFatTomLowEqHigh linseg p4, p3, p5
endin

instr FatTomLowFader
  gkFatTomLowFader linseg p4, p3, p5
endin

instr FatTomLowPan
  gkFatTomLowPan linseg p4, p3, p5
endin

instr FatTomLowMixerChannel
  aFatTomLowL inleta "FatTomLowInL"
  aFatTomLowR inleta "FatTomLowInR"

  kFatTomLowFader = gkFatTomLowFader
  kFatTomLowPan = gkFatTomLowPan
  kFatTomLowEqBass = gkFatTomLowEqBass
  kFatTomLowEqMid = gkFatTomLowEqMid
  kFatTomLowEqHigh = gkFatTomLowEqHigh

  aFatTomLowL, aFatTomLowR threeBandEqStereo aFatTomLowL, aFatTomLowR, kFatTomLowEqBass, kFatTomLowEqMid, kFatTomLowEqHigh

  if kFatTomLowPan > 100 then
      kFatTomLowPan = 100
  elseif kFatTomLowPan < 0 then
      kFatTomLowPan = 0
  endif

  aFatTomLowL = (aFatTomLowL * ((100 - kFatTomLowPan) * 2 / 100)) * kFatTomLowFader
  aFatTomLowR = (aFatTomLowR * (kFatTomLowPan * 2 / 100)) * kFatTomLowFader

  outleta "FatTomLowOutL", aFatTomLowL
  outleta "FatTomLowOutR", aFatTomLowR
endin
