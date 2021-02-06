instrumentRoute "Voidlessness", "DefaultEffectChain"
alwayson "VoidlessnessMixerChannel"

gkVoidlessnessEqBass init 1
gkVoidlessnessEqMid init 1
gkVoidlessnessEqHigh init 1
gkVoidlessnessFader init 1
gkVoidlessnessPan init 50

gSVoidlessnessSampleFilePath = "localSamples/windDemonStab1.wav"
giVoidlessnessNumberOfChannels filenchnls gSVoidlessnessSampleFilePath
giVoidlessnessSampleLength filelen gSVoidlessnessSampleFilePath
giVoidlessnessStartTime = 0
giVoidlessnessEndTime = giVoidlessnessSampleLength - giVoidlessnessStartTime
giVoidlessnessEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giVoidlessnessSampleRate filesr gSVoidlessnessSampleFilePath

if giVoidlessnessNumberOfChannels == 2 then
  giVoidlessnessSampleTableL ftgenonce 0, 0, 0, 1, gSVoidlessnessSampleFilePath, giVoidlessnessStartTime, 0, 1
  giVoidlessnessSampleTableR ftgenonce 0, 0, 0, 1, gSVoidlessnessSampleFilePath, giVoidlessnessStartTime, 0, 2
else
  giVoidlessnessSampleTable ftgenonce 0, 0, 0, 1, gSVoidlessnessSampleFilePath, giVoidlessnessStartTime, 0, 0
endif

gkVoidlessnessTimeStretch init 1
gkVoidlessnessGrainSizeAdjustment init 1
gkVoidlessnessGrainFrequencyAdjustment init 1
gkVoidlessnessPitchAdjustment init 1
gkVoidlessnessGrainOverlapPercentageAdjustment init 1

instr Voidlessness
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
  kTimeStretch *= .1 - poscil(10, .25) + poscil(.2, .3)
  kGrainSizeAdjustment *= 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment *= 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 ;+ poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= 1 ; + poscil(.04, .87) + poscil(.2, .3)

  ;Global Variables for K Rate Changes
  kTimeStretch *= gkVoidlessnessTimeStretch
  kGrainSizeAdjustment *= gkVoidlessnessGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkVoidlessnessGrainFrequencyAdjustment
  kPitchAdjustment *= gkVoidlessnessPitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkVoidlessnessGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giVoidlessnessNumberOfChannels == 2 then
    aVoidlessnessL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giVoidlessnessStartTime, giVoidlessnessEndTime, giVoidlessnessSampleTableL, giVoidlessnessEnvelopeTable, iMaxOverlaps
    aVoidlessnessR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giVoidlessnessStartTime, giVoidlessnessEndTime, giVoidlessnessSampleTableR, giVoidlessnessEnvelopeTable, iMaxOverlaps

    aVoidlessnessL = aVoidlessnessL * kAmplitudeEnvelope
    aVoidlessnessR = aVoidlessnessR * kAmplitudeEnvelope
  else
    aVoidlessnessL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giVoidlessnessStartTime, giVoidlessnessEndTime, giVoidlessnessSampleTable, giVoidlessnessEnvelopeTable, iMaxOverlaps
    aVoidlessnessL *= kAmplitudeEnvelope

    aVoidlessnessR = aVoidlessnessL
  endif

  outleta "OutL", aVoidlessnessL
  outleta "OutR", aVoidlessnessR
endin

instr VoidlessnessBassKnob
  gkVoidlessnessEqBass linseg p4, p3, p5
endin

instr VoidlessnessMidKnob
  gkVoidlessnessEqMid linseg p4, p3, p5
endin

instr VoidlessnessHighKnob
  gkVoidlessnessEqHigh linseg p4, p3, p5
endin

instr VoidlessnessFader
  gkVoidlessnessFader linseg p4, p3, p5
endin

instr VoidlessnessPan
  gkVoidlessnessPan linseg p4, p3, p5
endin

instr VoidlessnessMixerChannel
  aVoidlessnessL inleta "InL"
  aVoidlessnessR inleta "InR"

  aVoidlessnessL, aVoidlessnessR mixerChannel aVoidlessnessL, aVoidlessnessR, gkVoidlessnessFader, gkVoidlessnessPan, gkVoidlessnessEqBass, gkVoidlessnessEqMid, gkVoidlessnessEqHigh

  outleta "OutL", aVoidlessnessL
  outleta "OutR", aVoidlessnessR
endin
