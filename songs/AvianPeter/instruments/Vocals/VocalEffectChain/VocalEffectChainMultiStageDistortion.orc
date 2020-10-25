bypassRoute "VocalEffectChainMultiStageDistortion", "VocalEffectChainWarmDistortionInput", "VocalEffectChainWarmDistortionInput"

alwayson "VocalEffectChainMultiStageDistortionInput"
alwayson "VocalEffectChainMultiStageDistortionMixerChannel"

gkVocalEffectChainMultiStageDistortionEqBass init 1
gkVocalEffectChainMultiStageDistortionEqMid init 1
gkVocalEffectChainMultiStageDistortionEqHigh init 1
gkVocalEffectChainMultiStageDistortionFader init 1
gkVocalEffectChainMultiStageDistortionPan init 50

gkVocalEffectChainMultiStageDistortionDryAmount init 0
gkVocalEffectChainMultiStageDistortionWetAmount init 1

instr VocalEffectChainMultiStageDistortionInput
  aVocalEffectChainMultiStageDistortionInL inleta "InL"
  aVocalEffectChainMultiStageDistortionInR inleta "InR"

  aVocalEffectChainMultiStageDistortionOutWetL, aVocalEffectChainMultiStageDistortionOutWetR, aVocalEffectChainMultiStageDistortionOutDryL, aVocalEffectChainMultiStageDistortionOutDryR bypassSwitch aVocalEffectChainMultiStageDistortionInL, aVocalEffectChainMultiStageDistortionInR, gkVocalEffectChainMultiStageDistortionDryAmount, gkVocalEffectChainMultiStageDistortionWetAmount, "VocalEffectChainMultiStageDistortion"

  outleta "OutWetL", aVocalEffectChainMultiStageDistortionOutWetL
  outleta "OutWetR", aVocalEffectChainMultiStageDistortionOutWetR

  outleta "OutDryL", aVocalEffectChainMultiStageDistortionOutDryL
  outleta "OutDryR", aVocalEffectChainMultiStageDistortionOutDryR
endin


instr VocalEffectChainMultiStageDistortion
  aVocalEffectChainMultiStageDistortionInL inleta "InL"
  aVocalEffectChainMultiStageDistortionInR inleta "InR"

  iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
  iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  aVocalEffectChainMultiStageDistortionOutL = aVocalEffectChainMultiStageDistortionInL
  aVocalEffectChainMultiStageDistortionOutR = aVocalEffectChainMultiStageDistortionInR

  aVocalEffectChainMultiStageDistortionOutL += hansDistortion(aVocalEffectChainMultiStageDistortionOutL, 1.3, .7, .1, .1, iTableLight)
  aVocalEffectChainMultiStageDistortionOutR += hansDistortion(aVocalEffectChainMultiStageDistortionOutR, 1.3, .7, .1, .1, iTableLight)

  aVocalEffectChainMultiStageDistortionOutL = clip(aVocalEffectChainMultiStageDistortionOutL * 1.3, 1, 1, 0)
  aVocalEffectChainMultiStageDistortionOutR = clip(aVocalEffectChainMultiStageDistortionOutL * 1.3, 1, 1, 0)

  aVocalEffectChainMultiStageDistortionOutL = butterlp(aVocalEffectChainMultiStageDistortionOutL, 5000)
  aVocalEffectChainMultiStageDistortionOutR = butterlp(aVocalEffectChainMultiStageDistortionOutR, 5000)

  outleta "OutL", aVocalEffectChainMultiStageDistortionOutL
  outleta "OutR", aVocalEffectChainMultiStageDistortionOutR
endin

instr VocalEffectChainMultiStageDistortionBassKnob
  gkVocalEffectChainMultiStageDistortionEqBass linseg p4, p3, p5
endin

instr VocalEffectChainMultiStageDistortionMidKnob
  gkVocalEffectChainMultiStageDistortionEqMid linseg p4, p3, p5
endin

instr VocalEffectChainMultiStageDistortionHighKnob
  gkVocalEffectChainMultiStageDistortionEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainMultiStageDistortionFader
  gkVocalEffectChainMultiStageDistortionFader linseg p4, p3, p5
endin

instr VocalEffectChainMultiStageDistortionPan
  gkVocalEffectChainMultiStageDistortionPan linseg p4, p3, p5
endin

instr VocalEffectChainMultiStageDistortionMixerChannel
  aVocalEffectChainMultiStageDistortionL inleta "InL"
  aVocalEffectChainMultiStageDistortionR inleta "InR"

  aVocalEffectChainMultiStageDistortionL, aVocalEffectChainMultiStageDistortionR mixerChannel aVocalEffectChainMultiStageDistortionL, aVocalEffectChainMultiStageDistortionR, gkVocalEffectChainMultiStageDistortionFader, gkVocalEffectChainMultiStageDistortionPan, gkVocalEffectChainMultiStageDistortionEqBass, gkVocalEffectChainMultiStageDistortionEqMid, gkVocalEffectChainMultiStageDistortionEqHigh

  outleta "OutL", aVocalEffectChainMultiStageDistortionL
  outleta "OutR", aVocalEffectChainMultiStageDistortionR
endin
