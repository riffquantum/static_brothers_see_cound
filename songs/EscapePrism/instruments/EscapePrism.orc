instrumentRoute "EscapePrism", "DefaultEffectChain"
alwayson "EscapePrismMixerChannel"

gkEscapePrismEqBass init 1
gkEscapePrismEqMid init 1
gkEscapePrismEqHigh init 1
gkEscapePrismFader init 1
gkEscapePrismPan init 50

gSEscapePrismSampleFilePath = "localSamples/gloria4ia.wav"
giEscapePrismNumberOfChannels filenchnls gSEscapePrismSampleFilePath
giEscapePrismSampleLength filelen gSEscapePrismSampleFilePath
giEscapePrismStartTime = 0
giEscapePrismEndTime = giEscapePrismSampleLength - giEscapePrismStartTime
giEscapePrismEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giEscapePrismSampleRate filesr gSEscapePrismSampleFilePath

if giEscapePrismNumberOfChannels == 2 then
  giEscapePrismSampleTableL ftgenonce 0, 0, 0, 1, gSEscapePrismSampleFilePath, giEscapePrismStartTime, 0, 1
  giEscapePrismSampleTableR ftgenonce 0, 0, 0, 1, gSEscapePrismSampleFilePath, giEscapePrismStartTime, 0, 2
else
  giEscapePrismSampleTable ftgenonce 0, 0, 0, 1, gSEscapePrismSampleFilePath, giEscapePrismStartTime, 0, 0
endif

instr EscapePrism
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
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

  ;Grain Parameter Adjustments
  kTimeStretch *= .3 * (1 + kPitchBend) ; - poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment *= .3 + poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment *= 10 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= .99 ;+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giEscapePrismNumberOfChannels == 2 then
    aEscapePrismL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrismStartTime, giEscapePrismEndTime, giEscapePrismSampleTableL, giEscapePrismEnvelopeTable, iMaxOverlaps
    aEscapePrismR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrismStartTime, giEscapePrismEndTime, giEscapePrismSampleTableR, giEscapePrismEnvelopeTable, iMaxOverlaps

    aEscapePrismL = aEscapePrismL * kAmplitudeEnvelope
    aEscapePrismR = aEscapePrismR * kAmplitudeEnvelope
  else
    aEscapePrismL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrismStartTime, giEscapePrismEndTime, giEscapePrismSampleTable, giEscapePrismEnvelopeTable, iMaxOverlaps
    aEscapePrismL *= kAmplitudeEnvelope

    aEscapePrismR = aEscapePrismL
  endif

  outleta "OutL", aEscapePrismL
  outleta "OutR", aEscapePrismR
endin

instr EscapePrismBassKnob
  gkEscapePrismEqBass linseg p4, p3, p5
endin

instr EscapePrismMidKnob
  gkEscapePrismEqMid linseg p4, p3, p5
endin

instr EscapePrismHighKnob
  gkEscapePrismEqHigh linseg p4, p3, p5
endin

instr EscapePrismFader
  gkEscapePrismFader linseg p4, p3, p5
endin

instr EscapePrismPan
  gkEscapePrismPan linseg p4, p3, p5
endin

instr EscapePrismMixerChannel
  aEscapePrismL inleta "InL"
  aEscapePrismR inleta "InR"

  aEscapePrismL, aEscapePrismR mixerChannel aEscapePrismL, aEscapePrismR, gkEscapePrismFader, gkEscapePrismPan, gkEscapePrismEqBass, gkEscapePrismEqMid, gkEscapePrismEqHigh

  outleta "OutL", aEscapePrismL
  outleta "OutR", aEscapePrismR
endin
