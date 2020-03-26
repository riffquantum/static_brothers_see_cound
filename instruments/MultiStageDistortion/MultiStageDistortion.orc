alwayson "MultiStageDistortion"
alwayson "MultiStageDistortionMixerChannel"

gkMultiStageDistortionEqBass init 1
gkMultiStageDistortionEqMid init 1
gkMultiStageDistortionEqHigh init 1
gkMultiStageDistortionFader init 1
gkMultiStageDistortionPan init 50
gSMultiStageDistortionName = "MultiStageDistortion"
gSMultiStageDistortionRoute = "Mixer"
instrumentRoute gSMultiStageDistortionName, gSMultiStageDistortionRoute

instr MultiStageDistortion
  midiMonitor
  aMultiStageDistortionInL inleta "MultiStageDistortionInL"
  aMultiStageDistortionInR inleta "MultiStageDistortionInR"

  aMultiStageDistortionOutL = aMultiStageDistortionInL
  aMultiStageDistortionOutR = aMultiStageDistortionInR

  aMultiStageDistortionOutL += distortion(aMultiStageDistortionOutL, 1.3, .7, .1, .1)
  aMultiStageDistortionOutR += distortion(aMultiStageDistortionOutR, 1.3, .7, .1, .1)

  aMultiStageDistortionOutL = clip(aMultiStageDistortionOutL * 1.3, 1, 1, 0)
  aMultiStageDistortionOutR = clip(aMultiStageDistortionOutL * 1.3, 1, 1, 0)

  aMultiStageDistortionOutL = butterlp(aMultiStageDistortionOutL, 5000)
  aMultiStageDistortionOutR = butterlp(aMultiStageDistortionOutR, 5000)

  outleta "MultiStageDistortionOutL", aMultiStageDistortionOutL
  outleta "MultiStageDistortionOutR", aMultiStageDistortionOutR
endin

instr MultiStageDistortionBassKnob
  gkMultiStageDistortionEqBass linseg p4, p3, p5
endin

instr MultiStageDistortionMidKnob
  gkMultiStageDistortionEqMid linseg p4, p3, p5
endin

instr MultiStageDistortionHighKnob
  gkMultiStageDistortionEqHigh linseg p4, p3, p5
endin

instr MultiStageDistortionFader
  gkMultiStageDistortionFader linseg p4, p3, p5
endin

instr MultiStageDistortionPan
  gkMultiStageDistortionPan linseg p4, p3, p5
endin

instr MultiStageDistortionMixerChannel
  aMultiStageDistortionL inleta "MultiStageDistortionInL"
  aMultiStageDistortionR inleta "MultiStageDistortionInR"

  kMultiStageDistortionFader = gkMultiStageDistortionFader
  kMultiStageDistortionPan = gkMultiStageDistortionPan
  kMultiStageDistortionEqBass = gkMultiStageDistortionEqBass
  kMultiStageDistortionEqMid = gkMultiStageDistortionEqMid
  kMultiStageDistortionEqHigh = gkMultiStageDistortionEqHigh

  aMultiStageDistortionL, aMultiStageDistortionR threeBandEqStereo aMultiStageDistortionL, aMultiStageDistortionR, kMultiStageDistortionEqBass, kMultiStageDistortionEqMid, kMultiStageDistortionEqHigh

  if kMultiStageDistortionPan > 100 then
      kMultiStageDistortionPan = 100
  elseif kMultiStageDistortionPan < 0 then
      kMultiStageDistortionPan = 0
  endif

  aMultiStageDistortionL = (aMultiStageDistortionL * ((100 - kMultiStageDistortionPan) * 2 / 100)) * kMultiStageDistortionFader
  aMultiStageDistortionR = (aMultiStageDistortionR * (kMultiStageDistortionPan * 2 / 100)) * kMultiStageDistortionFader

  outleta "MultiStageDistortionOutL", aMultiStageDistortionL
  outleta "MultiStageDistortionOutR", aMultiStageDistortionR
endin
