instrumentRoute "EscapePrism2", "DefaultEffectChain"
alwayson "EscapePrism2MixerChannel"

gkEscapePrism2EqBass init 1
gkEscapePrism2EqMid init 1
gkEscapePrism2EqHigh init 1
gkEscapePrism2Fader init .1
gkEscapePrism2Pan init 50

gSEscapePrism2SampleFilePath = "localSamples/gloria4ia.wav"
giEscapePrism2NumberOfChannels filenchnls gSEscapePrism2SampleFilePath
giEscapePrism2SampleLength filelen gSEscapePrism2SampleFilePath
giEscapePrism2StartTime = 4
giEscapePrism2EndTime = giEscapePrism2SampleLength - giEscapePrism2StartTime
giEscapePrism2EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giEscapePrism2SampleRate filesr gSEscapePrism2SampleFilePath

if giEscapePrism2NumberOfChannels == 2 then
  giEscapePrism2SampleTableL ftgenonce 0, 0, 0, 1, gSEscapePrism2SampleFilePath, giEscapePrism2StartTime, 0, 1
  giEscapePrism2SampleTableR ftgenonce 0, 0, 0, 1, gSEscapePrism2SampleFilePath, giEscapePrism2StartTime, 0, 2
else
  giEscapePrism2SampleTable ftgenonce 0, 0, 0, 1, gSEscapePrism2SampleFilePath, giEscapePrism2StartTime, 0, 0
endif

instr EscapePrism2
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

  if giEscapePrism2NumberOfChannels == 2 then
    aEscapePrism2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrism2StartTime, giEscapePrism2EndTime, giEscapePrism2SampleTableL, giEscapePrism2EnvelopeTable, iMaxOverlaps
    aEscapePrism2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrism2StartTime, giEscapePrism2EndTime, giEscapePrism2SampleTableR, giEscapePrism2EnvelopeTable, iMaxOverlaps

    aEscapePrism2L = aEscapePrism2L * kAmplitudeEnvelope
    aEscapePrism2R = aEscapePrism2R * kAmplitudeEnvelope
  else
    aEscapePrism2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrism2StartTime, giEscapePrism2EndTime, giEscapePrism2SampleTable, giEscapePrism2EnvelopeTable, iMaxOverlaps
    aEscapePrism2L *= kAmplitudeEnvelope

    aEscapePrism2R = aEscapePrism2L
  endif

  outleta "OutL", aEscapePrism2L
  outleta "OutR", aEscapePrism2R
endin

instr EscapePrism2BassKnob
  gkEscapePrism2EqBass linseg p4, p3, p5
endin

instr EscapePrism2MidKnob
  gkEscapePrism2EqMid linseg p4, p3, p5
endin

instr EscapePrism2HighKnob
  gkEscapePrism2EqHigh linseg p4, p3, p5
endin

instr EscapePrism2Fader
  gkEscapePrism2Fader linseg p4, p3, p5
endin

instr EscapePrism2Pan
  gkEscapePrism2Pan linseg p4, p3, p5
endin

instr EscapePrism2MixerChannel
  aEscapePrism2L inleta "InL"
  aEscapePrism2R inleta "InR"

  aEscapePrism2L, aEscapePrism2R mixerChannel aEscapePrism2L, aEscapePrism2R, gkEscapePrism2Fader, gkEscapePrism2Pan, gkEscapePrism2EqBass, gkEscapePrism2EqMid, gkEscapePrism2EqHigh

  outleta "OutL", aEscapePrism2L
  outleta "OutR", aEscapePrism2R
endin
