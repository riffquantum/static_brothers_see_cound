bypassRoute "MultiStageDistortion", "Mixer", "Mixer"

alwayson "MultiStageDistortionInput"
alwayson "MultiStageDistortionMixerChannel"

gkMultiStageDistortionEqBass init 1
gkMultiStageDistortionEqMid init 1
gkMultiStageDistortionEqHigh init 1
gkMultiStageDistortionFader init 1
gkMultiStageDistortionPan init 50

gkMultiStageDistortionDryAmount init 0
gkMultiStageDistortionWetAmount init 1

instr MultiStageDistortionInput
  aMultiStageDistortionInL inleta "InL"
  aMultiStageDistortionInR inleta "InR"

  aMultiStageDistortionOutWetL, aMultiStageDistortionOutWetR, aMultiStageDistortionOutDryL, aMultiStageDistortionOutDryR bypassSwitch aMultiStageDistortionInL, aMultiStageDistortionInR, gkMultiStageDistortionDryAmount, gkMultiStageDistortionWetAmount, "MultiStageDistortion"

  outleta "OutWetL", aMultiStageDistortionOutWetL
  outleta "OutWetR", aMultiStageDistortionOutWetR

  outleta "OutDryL", aMultiStageDistortionOutDryL
  outleta "OutDryR", aMultiStageDistortionOutDryR
endin


instr MultiStageDistortion
  aMultiStageDistortionInL inleta "InL"
  aMultiStageDistortionInR inleta "InR"

  iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
  iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  aMultiStageDistortionOutL = aMultiStageDistortionInL
  aMultiStageDistortionOutR = aMultiStageDistortionInR

  aMultiStageDistortionOutL += hansDistortion(aMultiStageDistortionOutL, 1.3, .7, .1, .1, iTableLight)
  aMultiStageDistortionOutR += hansDistortion(aMultiStageDistortionOutR, 1.3, .7, .1, .1, iTableLight)

  aMultiStageDistortionOutL = clip(aMultiStageDistortionOutL * 1.3, 1, 1, 0)
  aMultiStageDistortionOutR = clip(aMultiStageDistortionOutL * 1.3, 1, 1, 0)

  aMultiStageDistortionOutL = butterlp(aMultiStageDistortionOutL, 5000)
  aMultiStageDistortionOutR = butterlp(aMultiStageDistortionOutR, 5000)

  outleta "OutL", aMultiStageDistortionOutL
  outleta "OutR", aMultiStageDistortionOutR
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
  aMultiStageDistortionL inleta "InL"
  aMultiStageDistortionR inleta "InR"

  aMultiStageDistortionL, aMultiStageDistortionR mixerChannel aMultiStageDistortionL, aMultiStageDistortionR, gkMultiStageDistortionFader, gkMultiStageDistortionPan, gkMultiStageDistortionEqBass, gkMultiStageDistortionEqMid, gkMultiStageDistortionEqHigh

  outleta "OutL", aMultiStageDistortionL
  outleta "OutR", aMultiStageDistortionR
endin
