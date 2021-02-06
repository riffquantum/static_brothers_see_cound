instrumentRoute "MachineSickness", "DefaultEffectChain"
alwayson "MachineSicknessMixerChannel"

gkMachineSicknessEqBass init 1
gkMachineSicknessEqMid init 1
gkMachineSicknessEqHigh init 1
gkMachineSicknessFader init 1
gkMachineSicknessPan init 50

gSMachineSicknessSampleFilePath = "localSamples/gloria8.wav"
giMachineSicknessNumberOfChannels filenchnls gSMachineSicknessSampleFilePath
giMachineSicknessSampleLength filelen gSMachineSicknessSampleFilePath
giMachineSicknessStartTime = 0
giMachineSicknessEndTime = giMachineSicknessSampleLength - giMachineSicknessStartTime
giMachineSicknessEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giMachineSicknessSampleRate filesr gSMachineSicknessSampleFilePath

if giMachineSicknessNumberOfChannels == 2 then
  giMachineSicknessSampleTableL ftgenonce 0, 0, 0, 1, gSMachineSicknessSampleFilePath, giMachineSicknessStartTime, 0, 1
  giMachineSicknessSampleTableR ftgenonce 0, 0, 0, 1, gSMachineSicknessSampleFilePath, giMachineSicknessStartTime, 0, 2
else
  giMachineSicknessSampleTable ftgenonce 0, 0, 0, 1, gSMachineSicknessSampleFilePath, giMachineSicknessStartTime, 0, 0
endif

gkMachineSicknessTimeStretch init 1
gkMachineSicknessGrainSizeAdjustment init 1
gkMachineSicknessGrainFrequencyAdjustment init 1
gkMachineSicknessPitchAdjustment init 1
gkMachineSicknessGrainOverlapPercentageAdjustment init 1

instr MachineSickness
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.626

  ;Amplitude Envelope
  iAttack = .2
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
  kTimeStretch *= gkMachineSicknessTimeStretch
  kGrainSizeAdjustment *= gkMachineSicknessGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkMachineSicknessGrainFrequencyAdjustment
  kPitchAdjustment *= gkMachineSicknessPitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkMachineSicknessGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giMachineSicknessNumberOfChannels == 2 then
    aMachineSicknessL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giMachineSicknessStartTime, giMachineSicknessEndTime, giMachineSicknessSampleTableL, giMachineSicknessEnvelopeTable, iMaxOverlaps
    aMachineSicknessR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giMachineSicknessStartTime, giMachineSicknessEndTime, giMachineSicknessSampleTableR, giMachineSicknessEnvelopeTable, iMaxOverlaps

    aMachineSicknessL = aMachineSicknessL * kAmplitudeEnvelope
    aMachineSicknessR = aMachineSicknessR * kAmplitudeEnvelope
  else
    aMachineSicknessL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giMachineSicknessStartTime, giMachineSicknessEndTime, giMachineSicknessSampleTable, giMachineSicknessEnvelopeTable, iMaxOverlaps
    aMachineSicknessL *= kAmplitudeEnvelope

    aMachineSicknessR = aMachineSicknessL
  endif

  outleta "OutL", aMachineSicknessL
  outleta "OutR", aMachineSicknessR
endin

instr MachineSicknessBassKnob
  gkMachineSicknessEqBass linseg p4, p3, p5
endin

instr MachineSicknessMidKnob
  gkMachineSicknessEqMid linseg p4, p3, p5
endin

instr MachineSicknessHighKnob
  gkMachineSicknessEqHigh linseg p4, p3, p5
endin

instr MachineSicknessFader
  gkMachineSicknessFader linseg p4, p3, p5
endin

instr MachineSicknessPan
  gkMachineSicknessPan linseg p4, p3, p5
endin

instr MachineSicknessMixerChannel
  aMachineSicknessL inleta "InL"
  aMachineSicknessR inleta "InR"

  aMachineSicknessL, aMachineSicknessR mixerChannel aMachineSicknessL, aMachineSicknessR, gkMachineSicknessFader, gkMachineSicknessPan, gkMachineSicknessEqBass, gkMachineSicknessEqMid, gkMachineSicknessEqHigh

  outleta "OutL", aMachineSicknessL
  outleta "OutR", aMachineSicknessR
endin
