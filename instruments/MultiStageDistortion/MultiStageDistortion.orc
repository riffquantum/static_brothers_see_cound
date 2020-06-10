bypassRoute "MultiStageDistortion"
stereoRoute "MultiStageDistortionMixerChannel", "Mixer"

alwayson "MultiStageDistortionInput"
alwayson "MultiStageDistortionMixerChannel"

gkMultiStageDistortionEqBass init 1
gkMultiStageDistortionEqMid init 1
gkMultiStageDistortionEqHigh init 1
gkMultiStageDistortionFader init 1
gkMultiStageDistortionPan init 50

gkMultiStageDistortionDryAmmount init 0
gkMultiStageDistortionWetAmmount init 1

instr MultiStageDistortionInput
  aMultiStageDistortionInL inleta "InL"
  aMultiStageDistortionInR inleta "InR"

  aMultiStageDistortionOutWetL, aMultiStageDistortionOutWetR, aMultiStageDistortionOutDryL, aMultiStageDistortionOutDryR bypassSwitch aMultiStageDistortionInL, aMultiStageDistortionInR, gkMultiStageDistortionDryAmmount, gkMultiStageDistortionWetAmmount, "MultiStageDistortion"

  outleta "OutWetL", aMultiStageDistortionOutWetL
  outleta "OutWetR", aMultiStageDistortionOutWetR

  outleta "OutDryL", aMultiStageDistortionOutDryL
  outleta "OutDryR", aMultiStageDistortionOutDryR
endin


instr MultiStageDistortion
  aMultiStageDistortionInL inleta "InL"
  aMultiStageDistortionInR inleta "InR"

  aMultiStageDistortionOutL = aMultiStageDistortionInL
  aMultiStageDistortionOutR = aMultiStageDistortionInR

  aMultiStageDistortionOutL += distortion(aMultiStageDistortionOutL, 1.3, .7, .1, .1)
  aMultiStageDistortionOutR += distortion(aMultiStageDistortionOutR, 1.3, .7, .1, .1)

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
