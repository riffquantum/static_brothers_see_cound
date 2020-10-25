bypassRoute "VocalEffectChainWarmDistortion", "VocalEffectChainRingModInput", "VocalEffectChainRingModInput"

alwayson "VocalEffectChainWarmDistortionInput"
alwayson "VocalEffectChainWarmDistortionMixerChannel"

gkVocalEffectChainWarmDistortionEqBass init 1
gkVocalEffectChainWarmDistortionEqMid init 1
gkVocalEffectChainWarmDistortionEqHigh init 1
gkVocalEffectChainWarmDistortionFader init 1
gkVocalEffectChainWarmDistortionPan init 50

gkVocalEffectChainWarmDistortionDryAmount init 0
gkVocalEffectChainWarmDistortionWetAmount init 1

gkVocalEffectChainWarmDistortionPreGain init 10
gkVocalEffectChainWarmDistortionPostGain init 1
gkVocalEffectChainWarmDistortionDutyOffset init .01
gkVocalEffectChainWarmDistortionSlopeShift init .01
giVocalEffectChainWarmDistortionStage2ClipLevel init 0dbfs/2
giVocalEffectChainWarmDistortionFinalGainAmount init .25

instr VocalEffectChainWarmDistortionInput
  aVocalEffectChainWarmDistortionInL inleta "InL"
  aVocalEffectChainWarmDistortionInR inleta "InR"

  aVocalEffectChainWarmDistortionOutWetL, aVocalEffectChainWarmDistortionOutWetR, aVocalEffectChainWarmDistortionOutDryL, aVocalEffectChainWarmDistortionOutDryR bypassSwitch aVocalEffectChainWarmDistortionInL, aVocalEffectChainWarmDistortionInR, gkVocalEffectChainWarmDistortionDryAmount, gkVocalEffectChainWarmDistortionWetAmount, "VocalEffectChainWarmDistortion"

  outleta "OutWetL", aVocalEffectChainWarmDistortionOutWetL
  outleta "OutWetR", aVocalEffectChainWarmDistortionOutWetR

  outleta "OutDryL", aVocalEffectChainWarmDistortionOutDryL
  outleta "OutDryR", aVocalEffectChainWarmDistortionOutDryR
endin


instr VocalEffectChainWarmDistortion
  aVocalEffectChainWarmDistortionInL inleta "InL"
  aVocalEffectChainWarmDistortionInR inleta "InR"

  iPreGainInstanceModifier = p4
  iPostGainInstanceModifier = p5
  iDutyOffsetModifier = p6
  iSlopeShiftOffsetModifier = p7
  iStage2ClipLevelInstanceModifier = p8

  aVocalEffectChainWarmDistortionOutL = aVocalEffectChainWarmDistortionInL
  aVocalEffectChainWarmDistortionOutR = aVocalEffectChainWarmDistortionInR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkVocalEffectChainWarmDistortionPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkVocalEffectChainWarmDistortionPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkVocalEffectChainWarmDistortionDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkVocalEffectChainWarmDistortionSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aVocalEffectChainWarmDistortionOutL hansDistortion aVocalEffectChainWarmDistortionInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aVocalEffectChainWarmDistortionOutR hansDistortion aVocalEffectChainWarmDistortionInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aVocalEffectChainWarmDistortionOutL butterlp aVocalEffectChainWarmDistortionOutL, 1000
  aVocalEffectChainWarmDistortionOutR butterlp aVocalEffectChainWarmDistortionOutR, 1000

  iStage2ClipLevel = giVocalEffectChainWarmDistortionStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aVocalEffectChainWarmDistortionOutR clip aVocalEffectChainWarmDistortionOutR, 1, iStage2ClipLevel
  aVocalEffectChainWarmDistortionOutL clip aVocalEffectChainWarmDistortionOutL, 1, iStage2ClipLevel


  aVocalEffectChainWarmDistortionOutL butterlp aVocalEffectChainWarmDistortionOutL, 5000
  aVocalEffectChainWarmDistortionOutR butterlp aVocalEffectChainWarmDistortionOutR, 5000

  aVocalEffectChainWarmDistortionOutL *= giVocalEffectChainWarmDistortionFinalGainAmount
  aVocalEffectChainWarmDistortionOutR *= giVocalEffectChainWarmDistortionFinalGainAmount

  aVocalEffectChainWarmDistortionOutL *= kDeclick
  aVocalEffectChainWarmDistortionOutR *= kDeclick

  outleta "OutL", aVocalEffectChainWarmDistortionOutL
  outleta "OutR", aVocalEffectChainWarmDistortionOutR
endin

instr VocalEffectChainWarmDistortionBassKnob
  gkVocalEffectChainWarmDistortionEqBass linseg p4, p3, p5
endin

instr VocalEffectChainWarmDistortionMidKnob
  gkVocalEffectChainWarmDistortionEqMid linseg p4, p3, p5
endin

instr VocalEffectChainWarmDistortionHighKnob
  gkVocalEffectChainWarmDistortionEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainWarmDistortionFader
  gkVocalEffectChainWarmDistortionFader linseg p4, p3, p5
endin

instr VocalEffectChainWarmDistortionPan
  gkVocalEffectChainWarmDistortionPan linseg p4, p3, p5
endin

instr VocalEffectChainWarmDistortionMixerChannel
  aVocalEffectChainWarmDistortionL inleta "InL"
  aVocalEffectChainWarmDistortionR inleta "InR"

  aVocalEffectChainWarmDistortionL, aVocalEffectChainWarmDistortionR mixerChannel aVocalEffectChainWarmDistortionL, aVocalEffectChainWarmDistortionR, gkVocalEffectChainWarmDistortionFader, gkVocalEffectChainWarmDistortionPan, gkVocalEffectChainWarmDistortionEqBass, gkVocalEffectChainWarmDistortionEqMid, gkVocalEffectChainWarmDistortionEqHigh

  outleta "OutL", aVocalEffectChainWarmDistortionL
  outleta "OutR", aVocalEffectChainWarmDistortionR
endin
