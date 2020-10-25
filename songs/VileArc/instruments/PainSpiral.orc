instrumentRoute "PainSpiral", "GlobalReverbInput"
alwayson "PainSpiralMixerChannel"

gkPainSpiralEqBass init 1
gkPainSpiralEqMid init 1
gkPainSpiralEqHigh init 1
gkPainSpiralFader init 1
gkPainSpiralPan init 50

gSPainSpiralSampleFilePath = "localSamples/gloria4ia.wav"
giPainSpiralNumberOfChannels filenchnls gSPainSpiralSampleFilePath
giPainSpiralSampleLength filelen gSPainSpiralSampleFilePath
giPainSpiralStartTime = 0
giPainSpiralEndTime = giPainSpiralSampleLength - giPainSpiralStartTime
giPainSpiralEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giPainSpiralSampleRate filesr gSPainSpiralSampleFilePath

if giPainSpiralNumberOfChannels == 2 then
  giPainSpiralSampleTableL ftgenonce 0, 0, 0, 1, gSPainSpiralSampleFilePath, giPainSpiralStartTime, 0, 1
  giPainSpiralSampleTableR ftgenonce 0, 0, 0, 1, gSPainSpiralSampleFilePath, giPainSpiralStartTime, 0, 2
else
  giPainSpiralSampleTable ftgenonce 0, 0, 0, 1, gSPainSpiralSampleFilePath, giPainSpiralStartTime, 0, 0
endif

instr PainSpiral
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
  kGrainFrequencyAdjustment *= 1 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= .99 ;+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giPainSpiralNumberOfChannels == 2 then
    aPainSpiralL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giPainSpiralStartTime, giPainSpiralEndTime, giPainSpiralSampleTableL, giPainSpiralEnvelopeTable, iMaxOverlaps
    aPainSpiralR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giPainSpiralStartTime, giPainSpiralEndTime, giPainSpiralSampleTableR, giPainSpiralEnvelopeTable, iMaxOverlaps

    aPainSpiralL = aPainSpiralL * kAmplitudeEnvelope
    aPainSpiralR = aPainSpiralR * kAmplitudeEnvelope
  else
    aPainSpiralL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giPainSpiralStartTime, giPainSpiralEndTime, giPainSpiralSampleTable, giPainSpiralEnvelopeTable, iMaxOverlaps
    aPainSpiralL *= kAmplitudeEnvelope

    aPainSpiralR = aPainSpiralL
  endif

  outleta "OutL", aPainSpiralL
  outleta "OutR", aPainSpiralR
endin

instr PainSpiralBassKnob
  gkPainSpiralEqBass linseg p4, p3, p5
endin

instr PainSpiralMidKnob
  gkPainSpiralEqMid linseg p4, p3, p5
endin

instr PainSpiralHighKnob
  gkPainSpiralEqHigh linseg p4, p3, p5
endin

instr PainSpiralFader
  gkPainSpiralFader linseg p4, p3, p5
endin

instr PainSpiralPan
  gkPainSpiralPan linseg p4, p3, p5
endin

instr PainSpiralMixerChannel
  aPainSpiralL inleta "InL"
  aPainSpiralR inleta "InR"

  aPainSpiralL, aPainSpiralR mixerChannel aPainSpiralL, aPainSpiralR, gkPainSpiralFader, gkPainSpiralPan, gkPainSpiralEqBass, gkPainSpiralEqMid, gkPainSpiralEqHigh

  outleta "OutL", aPainSpiralL
  outleta "OutR", aPainSpiralR
endin
