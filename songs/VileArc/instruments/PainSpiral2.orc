instrumentRoute "PainSpiral2", "GlobalReverbInput"
alwayson "PainSpiral2MixerChannel"

gkPainSpiral2EqBass init 1
gkPainSpiral2EqMid init 1
gkPainSpiral2EqHigh init 1
gkPainSpiral2Fader init 1
gkPainSpiral2Pan init 50

gSPainSpiral2SampleFilePath = "localSamples/gloria5.wav"
giPainSpiral2NumberOfChannels filenchnls gSPainSpiral2SampleFilePath
giPainSpiral2SampleLength filelen gSPainSpiral2SampleFilePath
giPainSpiral2StartTime = 2
giPainSpiral2EndTime = giPainSpiral2SampleLength - giPainSpiral2StartTime
giPainSpiral2EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giPainSpiral2SampleRate filesr gSPainSpiral2SampleFilePath

if giPainSpiral2NumberOfChannels == 2 then
  giPainSpiral2SampleTableL ftgenonce 0, 0, 0, 1, gSPainSpiral2SampleFilePath, giPainSpiral2StartTime, 0, 1
  giPainSpiral2SampleTableR ftgenonce 0, 0, 0, 1, gSPainSpiral2SampleFilePath, giPainSpiral2StartTime, 0, 2
else
  giPainSpiral2SampleTable ftgenonce 0, 0, 0, 1, gSPainSpiral2SampleFilePath, giPainSpiral2StartTime, 0, 0
endif

instr PainSpiral2
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
  kGrainSizeAdjustment *= .3 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment *= 1 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 ;+ poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= .99 ;+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giPainSpiral2NumberOfChannels == 2 then
    aPainSpiral2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giPainSpiral2StartTime, giPainSpiral2EndTime, giPainSpiral2SampleTableL, giPainSpiral2EnvelopeTable, iMaxOverlaps
    aPainSpiral2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giPainSpiral2StartTime, giPainSpiral2EndTime, giPainSpiral2SampleTableR, giPainSpiral2EnvelopeTable, iMaxOverlaps

    aPainSpiral2L = aPainSpiral2L * kAmplitudeEnvelope
    aPainSpiral2R = aPainSpiral2R * kAmplitudeEnvelope
  else
    aPainSpiral2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giPainSpiral2StartTime, giPainSpiral2EndTime, giPainSpiral2SampleTable, giPainSpiral2EnvelopeTable, iMaxOverlaps
    aPainSpiral2L *= kAmplitudeEnvelope

    aPainSpiral2R = aPainSpiral2L
  endif

  outleta "OutL", aPainSpiral2L
  outleta "OutR", aPainSpiral2R
endin

instr PainSpiral2BassKnob
  gkPainSpiral2EqBass linseg p4, p3, p5
endin

instr PainSpiral2MidKnob
  gkPainSpiral2EqMid linseg p4, p3, p5
endin

instr PainSpiral2HighKnob
  gkPainSpiral2EqHigh linseg p4, p3, p5
endin

instr PainSpiral2Fader
  gkPainSpiral2Fader linseg p4, p3, p5
endin

instr PainSpiral2Pan
  gkPainSpiral2Pan linseg p4, p3, p5
endin

instr PainSpiral2MixerChannel
  aPainSpiral2L inleta "InL"
  aPainSpiral2R inleta "InR"

  aPainSpiral2L, aPainSpiral2R mixerChannel aPainSpiral2L, aPainSpiral2R, gkPainSpiral2Fader, gkPainSpiral2Pan, gkPainSpiral2EqBass, gkPainSpiral2EqMid, gkPainSpiral2EqHigh

  outleta "OutL", aPainSpiral2L
  outleta "OutR", aPainSpiral2R
endin
