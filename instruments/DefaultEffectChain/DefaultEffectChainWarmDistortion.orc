bypassRoute "DefaultEffectChainWarmDistortion", "DefaultEffectChainRingModInput", "DefaultEffectChainRingModInput"

alwayson "DefaultEffectChainWarmDistortionInput"
alwayson "DefaultEffectChainWarmDistortionMixerChannel"

gkDefaultEffectChainWarmDistortionEqBass init 1
gkDefaultEffectChainWarmDistortionEqMid init 1
gkDefaultEffectChainWarmDistortionEqHigh init 1
gkDefaultEffectChainWarmDistortionFader init 1
gkDefaultEffectChainWarmDistortionPan init 50

gkDefaultEffectChainWarmDistortionDryAmount init 0
gkDefaultEffectChainWarmDistortionWetAmount init 1

gkDefaultEffectChainWarmDistortionPreGain init 10
gkDefaultEffectChainWarmDistortionPostGain init 1
gkDefaultEffectChainWarmDistortionDutyOffset init .01
gkDefaultEffectChainWarmDistortionSlopeShift init .01
giDefaultEffectChainWarmDistortionStage2ClipLevel init 0dbfs/2
giDefaultEffectChainWarmDistortionFinalGainAmount init .25

instr DefaultEffectChainWarmDistortionInput
  aDefaultEffectChainWarmDistortionInL inleta "InL"
  aDefaultEffectChainWarmDistortionInR inleta "InR"

  aDefaultEffectChainWarmDistortionOutWetL, aDefaultEffectChainWarmDistortionOutWetR, aDefaultEffectChainWarmDistortionOutDryL, aDefaultEffectChainWarmDistortionOutDryR bypassSwitch aDefaultEffectChainWarmDistortionInL, aDefaultEffectChainWarmDistortionInR, gkDefaultEffectChainWarmDistortionDryAmount, gkDefaultEffectChainWarmDistortionWetAmount, "DefaultEffectChainWarmDistortion"

  outleta "OutWetL", aDefaultEffectChainWarmDistortionOutWetL
  outleta "OutWetR", aDefaultEffectChainWarmDistortionOutWetR

  outleta "OutDryL", aDefaultEffectChainWarmDistortionOutDryL
  outleta "OutDryR", aDefaultEffectChainWarmDistortionOutDryR
endin


instr DefaultEffectChainWarmDistortion
  aDefaultEffectChainWarmDistortionInL inleta "InL"
  aDefaultEffectChainWarmDistortionInR inleta "InR"

  iPreGainInstanceModifier = p4
  iPostGainInstanceModifier = p5
  iDutyOffsetModifier = p6
  iSlopeShiftOffsetModifier = p7
  iStage2ClipLevelInstanceModifier = p8

  aDefaultEffectChainWarmDistortionOutL = aDefaultEffectChainWarmDistortionInL
  aDefaultEffectChainWarmDistortionOutR = aDefaultEffectChainWarmDistortionInR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkDefaultEffectChainWarmDistortionPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkDefaultEffectChainWarmDistortionPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkDefaultEffectChainWarmDistortionDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkDefaultEffectChainWarmDistortionSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aDefaultEffectChainWarmDistortionOutL hansDistortion aDefaultEffectChainWarmDistortionInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aDefaultEffectChainWarmDistortionOutR hansDistortion aDefaultEffectChainWarmDistortionInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aDefaultEffectChainWarmDistortionOutL butterlp aDefaultEffectChainWarmDistortionOutL, 1000
  aDefaultEffectChainWarmDistortionOutR butterlp aDefaultEffectChainWarmDistortionOutR, 1000

  iStage2ClipLevel = giDefaultEffectChainWarmDistortionStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aDefaultEffectChainWarmDistortionOutR clip aDefaultEffectChainWarmDistortionOutR, 1, iStage2ClipLevel
  aDefaultEffectChainWarmDistortionOutL clip aDefaultEffectChainWarmDistortionOutL, 1, iStage2ClipLevel


  aDefaultEffectChainWarmDistortionOutL butterlp aDefaultEffectChainWarmDistortionOutL, 5000
  aDefaultEffectChainWarmDistortionOutR butterlp aDefaultEffectChainWarmDistortionOutR, 5000

  aDefaultEffectChainWarmDistortionOutL *= giDefaultEffectChainWarmDistortionFinalGainAmount
  aDefaultEffectChainWarmDistortionOutR *= giDefaultEffectChainWarmDistortionFinalGainAmount

  aDefaultEffectChainWarmDistortionOutL *= kDeclick
  aDefaultEffectChainWarmDistortionOutR *= kDeclick

  outleta "OutL", aDefaultEffectChainWarmDistortionOutL
  outleta "OutR", aDefaultEffectChainWarmDistortionOutR
endin

instr DefaultEffectChainWarmDistortionBassKnob
  gkDefaultEffectChainWarmDistortionEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainWarmDistortionMidKnob
  gkDefaultEffectChainWarmDistortionEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainWarmDistortionHighKnob
  gkDefaultEffectChainWarmDistortionEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainWarmDistortionFader
  gkDefaultEffectChainWarmDistortionFader linseg p4, p3, p5
endin

instr DefaultEffectChainWarmDistortionPan
  gkDefaultEffectChainWarmDistortionPan linseg p4, p3, p5
endin

instr DefaultEffectChainWarmDistortionMixerChannel
  aDefaultEffectChainWarmDistortionL inleta "InL"
  aDefaultEffectChainWarmDistortionR inleta "InR"

  aDefaultEffectChainWarmDistortionL, aDefaultEffectChainWarmDistortionR mixerChannel aDefaultEffectChainWarmDistortionL, aDefaultEffectChainWarmDistortionR, gkDefaultEffectChainWarmDistortionFader, gkDefaultEffectChainWarmDistortionPan, gkDefaultEffectChainWarmDistortionEqBass, gkDefaultEffectChainWarmDistortionEqMid, gkDefaultEffectChainWarmDistortionEqHigh

  outleta "OutL", aDefaultEffectChainWarmDistortionL
  outleta "OutR", aDefaultEffectChainWarmDistortionR
endin
