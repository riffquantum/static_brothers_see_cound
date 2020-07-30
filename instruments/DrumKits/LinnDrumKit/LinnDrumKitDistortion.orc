bypassRoute "LinnDrumKitDistortion", "LinnDrumKitRverb", "LinnDrumKitRverb"

alwayson "LinnDrumKitDistortionInput"
alwayson "LinnDrumKitDistortionMixerChannel"

gkLinnDrumKitDistortionEqBass init 1
gkLinnDrumKitDistortionEqMid init 1
gkLinnDrumKitDistortionEqHigh init 1
gkLinnDrumKitDistortionFader init 1
gkLinnDrumKitDistortionPan init 50

gkLinnDrumKitDistortionDryAmmount init 0
gkLinnDrumKitDistortionWetAmmount init 1

gkLinnDrumKitDistortionPreGain init 10
gkLinnDrumKitDistortionPostGain init 1
gkLinnDrumKitDistortionDutyOffset init .01
gkLinnDrumKitDistortionSlopeShift init .01
giLinnDrumKitDistortionStage2ClipLevel init 0dbfs/2
giLinnDrumKitDistortionFinalGainAmmount init .25

instr LinnDrumKitDistortionInput
  aLinnDrumKitDistortionInL inleta "InL"
  aLinnDrumKitDistortionInR inleta "InR"

  aLinnDrumKitDistortionOutWetL, aLinnDrumKitDistortionOutWetR, aLinnDrumKitDistortionOutDryL, aLinnDrumKitDistortionOutDryR bypassSwitch aLinnDrumKitDistortionInL, aLinnDrumKitDistortionInR, gkLinnDrumKitDistortionDryAmmount, gkLinnDrumKitDistortionWetAmmount, "LinnDrumKitDistortion"

  outleta "OutWetL", aLinnDrumKitDistortionOutWetL
  outleta "OutWetR", aLinnDrumKitDistortionOutWetR

  outleta "OutDryL", aLinnDrumKitDistortionOutDryL
  outleta "OutDryR", aLinnDrumKitDistortionOutDryR
endin


instr LinnDrumKitDistortion
  aLinnDrumKitDistortionInL inleta "InL"
  aLinnDrumKitDistortionInR inleta "InR"

  iPreGainInstanceModifier = p4
  iPostGainInstanceModifier = p5
  iDutyOffsetModifier = p6
  iSlopeShiftOffsetModifier = p7
  iStage2ClipLevelInstanceModifier = p8

  aLinnDrumKitDistortionOutL = aLinnDrumKitDistortionInL
  aLinnDrumKitDistortionOutR = aLinnDrumKitDistortionInR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkLinnDrumKitDistortionPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkLinnDrumKitDistortionPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkLinnDrumKitDistortionDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkLinnDrumKitDistortionSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aLinnDrumKitDistortionOutL hansDistortion aLinnDrumKitDistortionInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aLinnDrumKitDistortionOutR hansDistortion aLinnDrumKitDistortionInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aLinnDrumKitDistortionOutL butterlp aLinnDrumKitDistortionOutL, 1000
  aLinnDrumKitDistortionOutR butterlp aLinnDrumKitDistortionOutR, 1000

  iStage2ClipLevel = giLinnDrumKitDistortionStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aLinnDrumKitDistortionOutR clip aLinnDrumKitDistortionOutR, 1, iStage2ClipLevel
  aLinnDrumKitDistortionOutL clip aLinnDrumKitDistortionOutL, 1, iStage2ClipLevel


  aLinnDrumKitDistortionOutL butterlp aLinnDrumKitDistortionOutL, 5000
  aLinnDrumKitDistortionOutR butterlp aLinnDrumKitDistortionOutR, 5000

  aLinnDrumKitDistortionOutL *= giLinnDrumKitDistortionFinalGainAmmount
  aLinnDrumKitDistortionOutR *= giLinnDrumKitDistortionFinalGainAmmount

  aLinnDrumKitDistortionOutL *= kDeclick
  aLinnDrumKitDistortionOutR *= kDeclick

  outleta "OutL", aLinnDrumKitDistortionOutL
  outleta "OutR", aLinnDrumKitDistortionOutR
endin

instr LinnDrumKitDistortionBassKnob
  gkLinnDrumKitDistortionEqBass linseg p4, p3, p5
endin

instr LinnDrumKitDistortionMidKnob
  gkLinnDrumKitDistortionEqMid linseg p4, p3, p5
endin

instr LinnDrumKitDistortionHighKnob
  gkLinnDrumKitDistortionEqHigh linseg p4, p3, p5
endin

instr LinnDrumKitDistortionFader
  gkLinnDrumKitDistortionFader linseg p4, p3, p5
endin

instr LinnDrumKitDistortionPan
  gkLinnDrumKitDistortionPan linseg p4, p3, p5
endin

instr LinnDrumKitDistortionMixerChannel
  aLinnDrumKitDistortionL inleta "InL"
  aLinnDrumKitDistortionR inleta "InR"

  aLinnDrumKitDistortionL, aLinnDrumKitDistortionR mixerChannel aLinnDrumKitDistortionL, aLinnDrumKitDistortionR, gkLinnDrumKitDistortionFader, gkLinnDrumKitDistortionPan, gkLinnDrumKitDistortionEqBass, gkLinnDrumKitDistortionEqMid, gkLinnDrumKitDistortionEqHigh

  outleta "OutL", aLinnDrumKitDistortionL
  outleta "OutR", aLinnDrumKitDistortionR
endin
