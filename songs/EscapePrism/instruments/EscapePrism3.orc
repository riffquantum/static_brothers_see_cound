instrumentRoute "EscapePrism3", "DefaultEffectChain"
alwayson "EscapePrism3MixerChannel"

gkEscapePrism3EqBass init 1
gkEscapePrism3EqMid init 1
gkEscapePrism3EqHigh init 1
gkEscapePrism3Fader init .1
gkEscapePrism3Pan init 50

gSEscapePrism3SampleFilePath = "localSamples/gloria5.wav"
giEscapePrism3NumberOfChannels filenchnls gSEscapePrism3SampleFilePath
giEscapePrism3SampleLength filelen gSEscapePrism3SampleFilePath
giEscapePrism3StartTime = 0
giEscapePrism3EndTime = giEscapePrism3SampleLength - giEscapePrism3StartTime
giEscapePrism3EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giEscapePrism3SampleRate filesr gSEscapePrism3SampleFilePath

if giEscapePrism3NumberOfChannels == 2 then
  giEscapePrism3SampleTableL ftgenonce 0, 0, 0, 1, gSEscapePrism3SampleFilePath, giEscapePrism3StartTime, 0, 1
  giEscapePrism3SampleTableR ftgenonce 0, 0, 0, 1, gSEscapePrism3SampleFilePath, giEscapePrism3StartTime, 0, 2
else
  giEscapePrism3SampleTable ftgenonce 0, 0, 0, 1, gSEscapePrism3SampleFilePath, giEscapePrism3StartTime, 0, 0
endif

instr EscapePrism3
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

  if giEscapePrism3NumberOfChannels == 2 then
    aEscapePrism3L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrism3StartTime, giEscapePrism3EndTime, giEscapePrism3SampleTableL, giEscapePrism3EnvelopeTable, iMaxOverlaps
    aEscapePrism3R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrism3StartTime, giEscapePrism3EndTime, giEscapePrism3SampleTableR, giEscapePrism3EnvelopeTable, iMaxOverlaps

    aEscapePrism3L = aEscapePrism3L * kAmplitudeEnvelope
    aEscapePrism3R = aEscapePrism3R * kAmplitudeEnvelope
  else
    aEscapePrism3L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giEscapePrism3StartTime, giEscapePrism3EndTime, giEscapePrism3SampleTable, giEscapePrism3EnvelopeTable, iMaxOverlaps
    aEscapePrism3L *= kAmplitudeEnvelope

    aEscapePrism3R = aEscapePrism3L
  endif

  outleta "OutL", aEscapePrism3L
  outleta "OutR", aEscapePrism3R
endin

instr EscapePrism3BassKnob
  gkEscapePrism3EqBass linseg p4, p3, p5
endin

instr EscapePrism3MidKnob
  gkEscapePrism3EqMid linseg p4, p3, p5
endin

instr EscapePrism3HighKnob
  gkEscapePrism3EqHigh linseg p4, p3, p5
endin

instr EscapePrism3Fader
  gkEscapePrism3Fader linseg p4, p3, p5
endin

instr EscapePrism3Pan
  gkEscapePrism3Pan linseg p4, p3, p5
endin

instr EscapePrism3MixerChannel
  aEscapePrism3L inleta "InL"
  aEscapePrism3R inleta "InR"

  aEscapePrism3L, aEscapePrism3R mixerChannel aEscapePrism3L, aEscapePrism3R, gkEscapePrism3Fader, gkEscapePrism3Pan, gkEscapePrism3EqBass, gkEscapePrism3EqMid, gkEscapePrism3EqHigh

  outleta "OutL", aEscapePrism3L
  outleta "OutR", aEscapePrism3R
endin
