bypassRoute "TR606KitDistortion", "TR606KitRverb", "TR606KitRverb"

alwayson "TR606KitDistortionInput"
alwayson "TR606KitDistortionMixerChannel"

gkTR606KitDistortionEqBass init 1
gkTR606KitDistortionEqMid init 1
gkTR606KitDistortionEqHigh init 1
gkTR606KitDistortionFader init 1
gkTR606KitDistortionPan init 50

gkTR606KitDistortionDryAmmount init 0
gkTR606KitDistortionWetAmmount init 1

gkTR606KitDistortionPreGain init 10
gkTR606KitDistortionPostGain init 1
gkTR606KitDistortionDutyOffset init .01
gkTR606KitDistortionSlopeShift init .01
giTR606KitDistortionStage2ClipLevel init 0dbfs/2
giTR606KitDistortionFinalGainAmmount init .25

instr TR606KitDistortionInput
  aTR606KitDistortionInL inleta "InL"
  aTR606KitDistortionInR inleta "InR"

  aTR606KitDistortionOutWetL, aTR606KitDistortionOutWetR, aTR606KitDistortionOutDryL, aTR606KitDistortionOutDryR bypassSwitch aTR606KitDistortionInL, aTR606KitDistortionInR, gkTR606KitDistortionDryAmmount, gkTR606KitDistortionWetAmmount, "TR606KitDistortion"

  outleta "OutWetL", aTR606KitDistortionOutWetL
  outleta "OutWetR", aTR606KitDistortionOutWetR

  outleta "OutDryL", aTR606KitDistortionOutDryL
  outleta "OutDryR", aTR606KitDistortionOutDryR
endin


instr TR606KitDistortion
  aTR606KitDistortionInL inleta "InL"
  aTR606KitDistortionInR inleta "InR"

  iPreGainInstanceModifier = p4
  iPostGainInstanceModifier = p5
  iDutyOffsetModifier = p6
  iSlopeShiftOffsetModifier = p7
  iStage2ClipLevelInstanceModifier = p8

  aTR606KitDistortionOutL = aTR606KitDistortionInL
  aTR606KitDistortionOutR = aTR606KitDistortionInR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkTR606KitDistortionPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkTR606KitDistortionPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkTR606KitDistortionDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkTR606KitDistortionSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aTR606KitDistortionOutL hansDistortion aTR606KitDistortionInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aTR606KitDistortionOutR hansDistortion aTR606KitDistortionInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aTR606KitDistortionOutL butterlp aTR606KitDistortionOutL, 1000
  aTR606KitDistortionOutR butterlp aTR606KitDistortionOutR, 1000

  iStage2ClipLevel = giTR606KitDistortionStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aTR606KitDistortionOutR clip aTR606KitDistortionOutR, 1, iStage2ClipLevel
  aTR606KitDistortionOutL clip aTR606KitDistortionOutL, 1, iStage2ClipLevel


  aTR606KitDistortionOutL butterlp aTR606KitDistortionOutL, 5000
  aTR606KitDistortionOutR butterlp aTR606KitDistortionOutR, 5000

  aTR606KitDistortionOutL *= giTR606KitDistortionFinalGainAmmount
  aTR606KitDistortionOutR *= giTR606KitDistortionFinalGainAmmount

  aTR606KitDistortionOutL *= kDeclick
  aTR606KitDistortionOutR *= kDeclick

  outleta "OutL", aTR606KitDistortionOutL
  outleta "OutR", aTR606KitDistortionOutR
endin

instr TR606KitDistortionBassKnob
  gkTR606KitDistortionEqBass linseg p4, p3, p5
endin

instr TR606KitDistortionMidKnob
  gkTR606KitDistortionEqMid linseg p4, p3, p5
endin

instr TR606KitDistortionHighKnob
  gkTR606KitDistortionEqHigh linseg p4, p3, p5
endin

instr TR606KitDistortionFader
  gkTR606KitDistortionFader linseg p4, p3, p5
endin

instr TR606KitDistortionPan
  gkTR606KitDistortionPan linseg p4, p3, p5
endin

instr TR606KitDistortionMixerChannel
  aTR606KitDistortionL inleta "InL"
  aTR606KitDistortionR inleta "InR"

  aTR606KitDistortionL, aTR606KitDistortionR mixerChannel aTR606KitDistortionL, aTR606KitDistortionR, gkTR606KitDistortionFader, gkTR606KitDistortionPan, gkTR606KitDistortionEqBass, gkTR606KitDistortionEqMid, gkTR606KitDistortionEqHigh

  outleta "OutL", aTR606KitDistortionL
  outleta "OutR", aTR606KitDistortionR
endin
