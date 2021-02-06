instrumentRoute "BreezeNudge", "DefaultEffectChain"
alwayson "BreezeNudgeMixerChannel"

gkBreezeNudgeEqBass init 1
gkBreezeNudgeEqMid init 1
gkBreezeNudgeEqHigh init 1
gkBreezeNudgeFader init 1
gkBreezeNudgePan init 50

gSBreezeNudgeSampleFilePath = "localSamples/windDemonStab1.wav"
giBreezeNudgeNumberOfChannels filenchnls gSBreezeNudgeSampleFilePath
giBreezeNudgeSampleLength filelen gSBreezeNudgeSampleFilePath
giBreezeNudgeStartTime = 0
giBreezeNudgeEndTime = giBreezeNudgeSampleLength - giBreezeNudgeStartTime
giBreezeNudgeEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giBreezeNudgeSampleRate filesr gSBreezeNudgeSampleFilePath

if giBreezeNudgeNumberOfChannels == 2 then
  giBreezeNudgeSampleTableL ftgenonce 0, 0, 0, 1, gSBreezeNudgeSampleFilePath, giBreezeNudgeStartTime, 0, 1
  giBreezeNudgeSampleTableR ftgenonce 0, 0, 0, 1, gSBreezeNudgeSampleFilePath, giBreezeNudgeStartTime, 0, 2
else
  giBreezeNudgeSampleTable ftgenonce 0, 0, 0, 1, gSBreezeNudgeSampleFilePath, giBreezeNudgeStartTime, 0, 0
endif

gkBreezeNudgeTimeStretch init 1
gkBreezeNudgeGrainSizeAdjustment init 1
gkBreezeNudgeGrainFrequencyAdjustment init 1
gkBreezeNudgePitchAdjustment init 1
gkBreezeNudgeGrainOverlapPercentageAdjustment init 1

instr BreezeNudge
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.626

  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = .1
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

  kTimeStretch = p6 == 0 ? 1 : p6
  kGrainSizeAdjustment = p8 == 0 ? 1 : p8
  kGrainFrequencyAdjustment = p9 == 0 ? 1 : p9
  kPitchAdjustment = p10 == 0 ? 1 : p10
  kGrainOverlapPercentageAdjustment = p11 == 0 ? 1 : p11

  kPitchBend = 0
  midipitchbend kPitchBend, 0, 100

  ;Grain Parameter Adjustments - Set these all to 1 for basic functionality
  kTimeStretch *= .1 ;- poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment *= 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment *= 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 ;+ poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= 1 ; + poscil(.04, .87) + poscil(.2, .3)

  ;Global Variables for K Rate Changes
  kTimeStretch *= gkBreezeNudgeTimeStretch
  kGrainSizeAdjustment *= gkBreezeNudgeGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkBreezeNudgeGrainFrequencyAdjustment
  kPitchAdjustment *= gkBreezeNudgePitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkBreezeNudgeGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giBreezeNudgeNumberOfChannels == 2 then
    aBreezeNudgeL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giBreezeNudgeStartTime, giBreezeNudgeEndTime, giBreezeNudgeSampleTableL, giBreezeNudgeEnvelopeTable, iMaxOverlaps
    aBreezeNudgeR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giBreezeNudgeStartTime, giBreezeNudgeEndTime, giBreezeNudgeSampleTableR, giBreezeNudgeEnvelopeTable, iMaxOverlaps

    aBreezeNudgeL = aBreezeNudgeL * kAmplitudeEnvelope
    aBreezeNudgeR = aBreezeNudgeR * kAmplitudeEnvelope
  else
    aBreezeNudgeL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giBreezeNudgeStartTime, giBreezeNudgeEndTime, giBreezeNudgeSampleTable, giBreezeNudgeEnvelopeTable, iMaxOverlaps
    aBreezeNudgeL *= kAmplitudeEnvelope

    aBreezeNudgeR = aBreezeNudgeL
  endif

  outleta "OutL", aBreezeNudgeL
  outleta "OutR", aBreezeNudgeR
endin

instr BreezeNudgeBassKnob
  gkBreezeNudgeEqBass linseg p4, p3, p5
endin

instr BreezeNudgeMidKnob
  gkBreezeNudgeEqMid linseg p4, p3, p5
endin

instr BreezeNudgeHighKnob
  gkBreezeNudgeEqHigh linseg p4, p3, p5
endin

instr BreezeNudgeFader
  gkBreezeNudgeFader linseg p4, p3, p5
endin

instr BreezeNudgePan
  gkBreezeNudgePan linseg p4, p3, p5
endin

instr BreezeNudgeMixerChannel
  aBreezeNudgeL inleta "InL"
  aBreezeNudgeR inleta "InR"

  aBreezeNudgeL, aBreezeNudgeR mixerChannel aBreezeNudgeL, aBreezeNudgeR, gkBreezeNudgeFader, gkBreezeNudgePan, gkBreezeNudgeEqBass, gkBreezeNudgeEqMid, gkBreezeNudgeEqHigh

  outleta "OutL", aBreezeNudgeL
  outleta "OutR", aBreezeNudgeR
endin
