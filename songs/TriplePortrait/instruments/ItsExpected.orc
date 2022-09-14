instrumentRoute "ItsExpected", "Mixer"
alwayson "ItsExpectedMixerChannel"

gkItsExpectedEqBass init 1
gkItsExpectedEqMid init 1
gkItsExpectedEqHigh init 1
gkItsExpectedFader init 1
gkItsExpectedPan init 50

gkItsExpectedTimeStretch init 1
gkItsExpectedGrainSizeAdjustment init 1
gkItsExpectedGrainFrequencyAdjustment init 1
gkItsExpectedPitchAdjustment init 1
gkItsExpectedGrainOverlapPercentageAdjustment init 1

gSItsExpectedSampleFilePath = "localSamples/itsExpectedBreak.wav"
giItsExpectedNumberOfChannels filenchnls gSItsExpectedSampleFilePath
giItsExpectedSampleLength filelen gSItsExpectedSampleFilePath
giItsExpectedStartTime = 2.2
giItsExpectedEndTime = giItsExpectedSampleLength - giItsExpectedStartTime
giItsExpectedEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giItsExpectedSampleRate filesr gSItsExpectedSampleFilePath

if giItsExpectedNumberOfChannels == 2 then
  giItsExpectedSampleTableL ftgenonce 0, 0, 0, 1, gSItsExpectedSampleFilePath, giItsExpectedStartTime, 0, 1
  giItsExpectedSampleTableR ftgenonce 0, 0, 0, 1, gSItsExpectedSampleFilePath, giItsExpectedStartTime, 0, 2
else
  giItsExpectedSampleTable ftgenonce 0, 0, 0, 1, gSItsExpectedSampleFilePath, giItsExpectedStartTime, 0, 0
endif

instr ItsExpected
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = .5
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude


  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  ;Grain Parameter Adjustments
  kTimeStretch = 1 + poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = 1 + poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 1 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1; + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)

  kTimeStretch *= gkItsExpectedTimeStretch
  kGrainSizeAdjustment *= gkItsExpectedGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkItsExpectedGrainFrequencyAdjustment
  kPitchAdjustment *= gkItsExpectedPitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkItsExpectedGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giItsExpectedNumberOfChannels == 2 then
    aItsExpectedL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsExpectedStartTime, giItsExpectedEndTime, giItsExpectedSampleTableL, giItsExpectedEnvelopeTable, iMaxOverlaps
    aItsExpectedR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsExpectedStartTime, giItsExpectedEndTime, giItsExpectedSampleTableR, giItsExpectedEnvelopeTable, iMaxOverlaps

    aItsExpectedL = aItsExpectedL * kAmplitudeEnvelope
    aItsExpectedR = aItsExpectedR * kAmplitudeEnvelope
  else
    aItsExpectedL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsExpectedStartTime, giItsExpectedEndTime, giItsExpectedSampleTable, giItsExpectedEnvelopeTable, iMaxOverlaps
    aItsExpectedL *= kAmplitudeEnvelope

    aItsExpectedR = aItsExpectedL
  endif

  outleta "OutL", aItsExpectedL
  outleta "OutR", aItsExpectedR
endin

instr ItsExpectedBassKnob
  gkItsExpectedEqBass linseg p4, p3, p5
endin

instr ItsExpectedMidKnob
  gkItsExpectedEqMid linseg p4, p3, p5
endin

instr ItsExpectedHighKnob
  gkItsExpectedEqHigh linseg p4, p3, p5
endin

instr ItsExpectedFader
  gkItsExpectedFader linseg p4, p3, p5
endin

instr ItsExpectedPan
  gkItsExpectedPan linseg p4, p3, p5
endin

instr ItsExpectedMixerChannel
  aItsExpectedL inleta "InL"
  aItsExpectedR inleta "InR"

  aItsExpectedL, aItsExpectedR mixerChannel aItsExpectedL, aItsExpectedR, gkItsExpectedFader, gkItsExpectedPan, gkItsExpectedEqBass, gkItsExpectedEqMid, gkItsExpectedEqHigh

  outleta "OutL", aItsExpectedL
  outleta "OutR", aItsExpectedR
endin
