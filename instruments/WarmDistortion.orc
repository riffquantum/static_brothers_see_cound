bypassRoute "WarmDistortion", "Mixer", "Mixer"

alwayson "WarmDistortionInput"
alwayson "WarmDistortionMixerChannel"

gkWarmDistortionEqBass init 1
gkWarmDistortionEqMid init 1
gkWarmDistortionEqHigh init 1
gkWarmDistortionFader init 1
gkWarmDistortionPan init 50

gkWarmDistortionDryAmount init 0
gkWarmDistortionWetAmount init 1

gkWarmDistortionPreGain init 10
gkWarmDistortionPostGain init 1
gkWarmDistortionDutyOffset init .01
gkWarmDistortionSlopeShift init .01
giWarmDistortionStage2ClipLevel init 0dbfs/2
giWarmDistortionFinalGainAmount init .25

instr WarmDistortionInput
  aWarmDistortionInL inleta "InL"
  aWarmDistortionInR inleta "InR"

  aWarmDistortionOutWetL, aWarmDistortionOutWetR, aWarmDistortionOutDryL, aWarmDistortionOutDryR bypassSwitch aWarmDistortionInL, aWarmDistortionInR, gkWarmDistortionDryAmount, gkWarmDistortionWetAmount, "WarmDistortion"

  outleta "OutWetL", aWarmDistortionOutWetL
  outleta "OutWetR", aWarmDistortionOutWetR

  outleta "OutDryL", aWarmDistortionOutDryL
  outleta "OutDryR", aWarmDistortionOutDryR
endin


instr WarmDistortion
  aWarmDistortionInL inleta "InL"
  aWarmDistortionInR inleta "InR"

  iPreGainInstanceModifier = p4
  iPostGainInstanceModifier = p5
  iDutyOffsetModifier = p6
  iSlopeShiftOffsetModifier = p7
  iStage2ClipLevelInstanceModifier = p8

  aWarmDistortionOutL = aWarmDistortionInL
  aWarmDistortionOutR = aWarmDistortionInR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkWarmDistortionPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkWarmDistortionPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkWarmDistortionDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkWarmDistortionSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aWarmDistortionOutL hansDistortion aWarmDistortionInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aWarmDistortionOutR hansDistortion aWarmDistortionInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aWarmDistortionOutL butterlp aWarmDistortionOutL, 1000
  aWarmDistortionOutR butterlp aWarmDistortionOutR, 1000

  iStage2ClipLevel = giWarmDistortionStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aWarmDistortionOutR clip aWarmDistortionOutR, 1, iStage2ClipLevel
  aWarmDistortionOutL clip aWarmDistortionOutL, 1, iStage2ClipLevel


  aWarmDistortionOutL butterlp aWarmDistortionOutL, 5000
  aWarmDistortionOutR butterlp aWarmDistortionOutR, 5000

  aWarmDistortionOutL *= giWarmDistortionFinalGainAmount
  aWarmDistortionOutR *= giWarmDistortionFinalGainAmount

  aWarmDistortionOutL *= kDeclick
  aWarmDistortionOutR *= kDeclick

  outleta "OutL", aWarmDistortionOutL
  outleta "OutR", aWarmDistortionOutR
endin

instr WarmDistortionBassKnob
  gkWarmDistortionEqBass linseg p4, p3, p5
endin

instr WarmDistortionMidKnob
  gkWarmDistortionEqMid linseg p4, p3, p5
endin

instr WarmDistortionHighKnob
  gkWarmDistortionEqHigh linseg p4, p3, p5
endin

instr WarmDistortionFader
  gkWarmDistortionFader linseg p4, p3, p5
endin

instr WarmDistortionPan
  gkWarmDistortionPan linseg p4, p3, p5
endin

instr WarmDistortionMixerChannel
  aWarmDistortionL inleta "InL"
  aWarmDistortionR inleta "InR"

  aWarmDistortionL, aWarmDistortionR mixerChannel aWarmDistortionL, aWarmDistortionR, gkWarmDistortionFader, gkWarmDistortionPan, gkWarmDistortionEqBass, gkWarmDistortionEqMid, gkWarmDistortionEqHigh

  outleta "OutL", aWarmDistortionL
  outleta "OutR", aWarmDistortionR
endin
