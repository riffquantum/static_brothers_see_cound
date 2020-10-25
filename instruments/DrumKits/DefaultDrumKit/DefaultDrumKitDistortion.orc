bypassRoute "DefaultDrumKitDistortion", "DefaultDrumKitFreezerInput", "DefaultDrumKitFreezerInput"

alwayson "DefaultDrumKitDistortionInput"
alwayson "DefaultDrumKitDistortionMixerChannel"

gkDefaultDrumKitDistortionEqBass init 1
gkDefaultDrumKitDistortionEqMid init 1
gkDefaultDrumKitDistortionEqHigh init 1
gkDefaultDrumKitDistortionFader init 1
gkDefaultDrumKitDistortionPan init 50

gkDefaultDrumKitDistortionDryAmount init 0
gkDefaultDrumKitDistortionWetAmount init 1

gkDefaultDrumKitDistortionPreGain init 10
gkDefaultDrumKitDistortionPostGain init 1
gkDefaultDrumKitDistortionDutyOffset init .01
gkDefaultDrumKitDistortionSlopeShift init .01
giDefaultDrumKitDistortionStage2ClipLevel init 0dbfs/2
giDefaultDrumKitDistortionFinalGainAmount init .25

instr DefaultDrumKitDistortionInput
  aDefaultDrumKitDistortionInL inleta "InL"
  aDefaultDrumKitDistortionInR inleta "InR"

  aDefaultDrumKitDistortionOutWetL, aDefaultDrumKitDistortionOutWetR, aDefaultDrumKitDistortionOutDryL, aDefaultDrumKitDistortionOutDryR bypassSwitch aDefaultDrumKitDistortionInL, aDefaultDrumKitDistortionInR, gkDefaultDrumKitDistortionDryAmount, gkDefaultDrumKitDistortionWetAmount, "DefaultDrumKitDistortion"

  outleta "OutWetL", aDefaultDrumKitDistortionOutWetL
  outleta "OutWetR", aDefaultDrumKitDistortionOutWetR

  outleta "OutDryL", aDefaultDrumKitDistortionOutDryL
  outleta "OutDryR", aDefaultDrumKitDistortionOutDryR
endin


instr DefaultDrumKitDistortion
  aDefaultDrumKitDistortionInL inleta "InL"
  aDefaultDrumKitDistortionInR inleta "InR"

  iPreGainInstanceModifier = p4
  iPostGainInstanceModifier = p5
  iDutyOffsetModifier = p6
  iSlopeShiftOffsetModifier = p7
  iStage2ClipLevelInstanceModifier = p8

  aDefaultDrumKitDistortionOutL = aDefaultDrumKitDistortionInL
  aDefaultDrumKitDistortionOutR = aDefaultDrumKitDistortionInR

  iDistortionTable ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  kPreGain = (gkDefaultDrumKitDistortionPreGain + iPreGainInstanceModifier) * (oscil(.1, .333) + 1)
  kPostGain = gkDefaultDrumKitDistortionPostGain + iPostGainInstanceModifier
  kDutyOffset = (gkDefaultDrumKitDistortionDutyOffset + iDutyOffsetModifier) * (oscil(9.9, .25) + .1)
  kSlopeShift = (gkDefaultDrumKitDistortionSlopeShift + iSlopeShiftOffsetModifier) * (oscil(9.9, .25) + .1)

  kDeclick madsr .005, .01, 1, .01

  aDefaultDrumKitDistortionOutL hansDistortion aDefaultDrumKitDistortionInL, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable
  aDefaultDrumKitDistortionOutR hansDistortion aDefaultDrumKitDistortionInR, kPreGain, kPostGain, kDutyOffset, kSlopeShift, iDistortionTable

  aDefaultDrumKitDistortionOutL butterlp aDefaultDrumKitDistortionOutL, 1000
  aDefaultDrumKitDistortionOutR butterlp aDefaultDrumKitDistortionOutR, 1000

  iStage2ClipLevel = giDefaultDrumKitDistortionStage2ClipLevel + iStage2ClipLevelInstanceModifier

  aDefaultDrumKitDistortionOutR clip aDefaultDrumKitDistortionOutR, 1, iStage2ClipLevel
  aDefaultDrumKitDistortionOutL clip aDefaultDrumKitDistortionOutL, 1, iStage2ClipLevel


  aDefaultDrumKitDistortionOutL butterlp aDefaultDrumKitDistortionOutL, 5000
  aDefaultDrumKitDistortionOutR butterlp aDefaultDrumKitDistortionOutR, 5000

  aDefaultDrumKitDistortionOutL *= giDefaultDrumKitDistortionFinalGainAmount
  aDefaultDrumKitDistortionOutR *= giDefaultDrumKitDistortionFinalGainAmount

  aDefaultDrumKitDistortionOutL *= kDeclick
  aDefaultDrumKitDistortionOutR *= kDeclick

  outleta "OutL", aDefaultDrumKitDistortionOutL
  outleta "OutR", aDefaultDrumKitDistortionOutR
endin

instr DefaultDrumKitDistortionBassKnob
  gkDefaultDrumKitDistortionEqBass linseg p4, p3, p5
endin

instr DefaultDrumKitDistortionMidKnob
  gkDefaultDrumKitDistortionEqMid linseg p4, p3, p5
endin

instr DefaultDrumKitDistortionHighKnob
  gkDefaultDrumKitDistortionEqHigh linseg p4, p3, p5
endin

instr DefaultDrumKitDistortionFader
  gkDefaultDrumKitDistortionFader linseg p4, p3, p5
endin

instr DefaultDrumKitDistortionPan
  gkDefaultDrumKitDistortionPan linseg p4, p3, p5
endin

instr DefaultDrumKitDistortionMixerChannel
  aDefaultDrumKitDistortionL inleta "InL"
  aDefaultDrumKitDistortionR inleta "InR"

  aDefaultDrumKitDistortionL, aDefaultDrumKitDistortionR mixerChannel aDefaultDrumKitDistortionL, aDefaultDrumKitDistortionR, gkDefaultDrumKitDistortionFader, gkDefaultDrumKitDistortionPan, gkDefaultDrumKitDistortionEqBass, gkDefaultDrumKitDistortionEqMid, gkDefaultDrumKitDistortionEqHigh

  outleta "OutL", aDefaultDrumKitDistortionL
  outleta "OutR", aDefaultDrumKitDistortionR
endin
