bypassRoute "DefaultEffectChainMultiStageDistortion", "DefaultEffectChainWarmDistortionInput", "DefaultEffectChainWarmDistortionInput"

alwayson "DefaultEffectChainMultiStageDistortionInput"
alwayson "DefaultEffectChainMultiStageDistortionMixerChannel"

gkDefaultEffectChainMultiStageDistortionEqBass init 1
gkDefaultEffectChainMultiStageDistortionEqMid init 1
gkDefaultEffectChainMultiStageDistortionEqHigh init 1
gkDefaultEffectChainMultiStageDistortionFader init 1
gkDefaultEffectChainMultiStageDistortionPan init 50

gkDefaultEffectChainMultiStageDistortionDryAmount init 0
gkDefaultEffectChainMultiStageDistortionWetAmount init 1

instr DefaultEffectChainMultiStageDistortionInput
  aDefaultEffectChainMultiStageDistortionInL inleta "InL"
  aDefaultEffectChainMultiStageDistortionInR inleta "InR"

  aDefaultEffectChainMultiStageDistortionOutWetL, aDefaultEffectChainMultiStageDistortionOutWetR, aDefaultEffectChainMultiStageDistortionOutDryL, aDefaultEffectChainMultiStageDistortionOutDryR bypassSwitch aDefaultEffectChainMultiStageDistortionInL, aDefaultEffectChainMultiStageDistortionInR, gkDefaultEffectChainMultiStageDistortionDryAmount, gkDefaultEffectChainMultiStageDistortionWetAmount, "DefaultEffectChainMultiStageDistortion"

  outleta "OutWetL", aDefaultEffectChainMultiStageDistortionOutWetL
  outleta "OutWetR", aDefaultEffectChainMultiStageDistortionOutWetR

  outleta "OutDryL", aDefaultEffectChainMultiStageDistortionOutDryL
  outleta "OutDryR", aDefaultEffectChainMultiStageDistortionOutDryR
endin


instr DefaultEffectChainMultiStageDistortion
  aDefaultEffectChainMultiStageDistortionInL inleta "InL"
  aDefaultEffectChainMultiStageDistortionInR inleta "InR"

  iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
  iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  aDefaultEffectChainMultiStageDistortionOutL = aDefaultEffectChainMultiStageDistortionInL
  aDefaultEffectChainMultiStageDistortionOutR = aDefaultEffectChainMultiStageDistortionInR

  aDefaultEffectChainMultiStageDistortionOutL += hansDistortion(aDefaultEffectChainMultiStageDistortionOutL, 1.3, .7, .1, .1, iTableLight)
  aDefaultEffectChainMultiStageDistortionOutR += hansDistortion(aDefaultEffectChainMultiStageDistortionOutR, 1.3, .7, .1, .1, iTableLight)

  aDefaultEffectChainMultiStageDistortionOutL = clip(aDefaultEffectChainMultiStageDistortionOutL * 1.3, 1, 1, 0)
  aDefaultEffectChainMultiStageDistortionOutR = clip(aDefaultEffectChainMultiStageDistortionOutL * 1.3, 1, 1, 0)

  aDefaultEffectChainMultiStageDistortionOutL = butterlp(aDefaultEffectChainMultiStageDistortionOutL, 5000)
  aDefaultEffectChainMultiStageDistortionOutR = butterlp(aDefaultEffectChainMultiStageDistortionOutR, 5000)

  outleta "OutL", aDefaultEffectChainMultiStageDistortionOutL
  outleta "OutR", aDefaultEffectChainMultiStageDistortionOutR
endin

instr DefaultEffectChainMultiStageDistortionBassKnob
  gkDefaultEffectChainMultiStageDistortionEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainMultiStageDistortionMidKnob
  gkDefaultEffectChainMultiStageDistortionEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainMultiStageDistortionHighKnob
  gkDefaultEffectChainMultiStageDistortionEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainMultiStageDistortionFader
  gkDefaultEffectChainMultiStageDistortionFader linseg p4, p3, p5
endin

instr DefaultEffectChainMultiStageDistortionPan
  gkDefaultEffectChainMultiStageDistortionPan linseg p4, p3, p5
endin

instr DefaultEffectChainMultiStageDistortionMixerChannel
  aDefaultEffectChainMultiStageDistortionL inleta "InL"
  aDefaultEffectChainMultiStageDistortionR inleta "InR"

  aDefaultEffectChainMultiStageDistortionL, aDefaultEffectChainMultiStageDistortionR mixerChannel aDefaultEffectChainMultiStageDistortionL, aDefaultEffectChainMultiStageDistortionR, gkDefaultEffectChainMultiStageDistortionFader, gkDefaultEffectChainMultiStageDistortionPan, gkDefaultEffectChainMultiStageDistortionEqBass, gkDefaultEffectChainMultiStageDistortionEqMid, gkDefaultEffectChainMultiStageDistortionEqHigh

  outleta "OutL", aDefaultEffectChainMultiStageDistortionL
  outleta "OutR", aDefaultEffectChainMultiStageDistortionR
endin
