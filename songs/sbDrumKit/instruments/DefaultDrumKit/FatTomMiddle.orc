gSFatTomMiddleName = "FatTomMiddle"
gSFatTomMiddleRoute = "DrumKitBus"
instrumentRoute gSFatTomMiddleName, gSFatTomMiddleRoute

alwayson "FatTomMiddleMixerChannel"

gkFatTomMiddleEqBass init 1.3
gkFatTomMiddleEqMid init 1
gkFatTomMiddleEqHigh init 1
gkFatTomMiddleFader init 1
gkFatTomMiddlePan init 50

gSFatTomMiddleSamplePath ="songs/sbDrumKit/samples/EA7650_R8_Tom.wav"
giFatTomMiddleSampleTableLength getTableSizeFromSample gSFatTomMiddleSamplePath
giFatTomMiddleSample ftgen 0, 0, giFatTomMiddleSampleTableLength, 1, gSFatTomMiddleSamplePath, 0, 0, 0

instr FatTomMiddle
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aFatTomMiddleSample loscil kAmplitudeEnvelope, 1, giFatTomMiddleSample, 1

  aFatTomMiddle = aFatTomMiddleSample

  outleta "OutL", aFatTomMiddle
  outleta "OutR", aFatTomMiddle
endin

instr FatTomMiddleBassKnob
  gkFatTomMiddleEqBass linseg p4, p3, p5
endin

instr FatTomMiddleMidKnob
  gkFatTomMiddleEqMid linseg p4, p3, p5
endin

instr FatTomMiddleHighKnob
  gkFatTomMiddleEqHigh linseg p4, p3, p5
endin

instr FatTomMiddleFader
  gkFatTomMiddleFader linseg p4, p3, p5
endin

instr FatTomMiddlePan
  gkFatTomMiddlePan linseg p4, p3, p5
endin

instr FatTomMiddleMixerChannel
  aFatTomMiddleL inleta "InL"
  aFatTomMiddleR inleta "InR"

  kFatTomMiddleFader = gkFatTomMiddleFader
  kFatTomMiddlePan = gkFatTomMiddlePan
  kFatTomMiddleEqBass = gkFatTomMiddleEqBass
  kFatTomMiddleEqMid = gkFatTomMiddleEqMid
  kFatTomMiddleEqHigh = gkFatTomMiddleEqHigh

  aFatTomMiddleL, aFatTomMiddleR threeBandEqStereo aFatTomMiddleL, aFatTomMiddleR, kFatTomMiddleEqBass, kFatTomMiddleEqMid, kFatTomMiddleEqHigh

  if kFatTomMiddlePan > 100 then
      kFatTomMiddlePan = 100
  elseif kFatTomMiddlePan < 0 then
      kFatTomMiddlePan = 0
  endif

  aFatTomMiddleL = (aFatTomMiddleL * ((100 - kFatTomMiddlePan) * 2 / 100)) * kFatTomMiddleFader
  aFatTomMiddleR = (aFatTomMiddleR * (kFatTomMiddlePan * 2 / 100)) * kFatTomMiddleFader

  outleta "OutL", aFatTomMiddleL
  outleta "OutR", aFatTomMiddleR
endin
