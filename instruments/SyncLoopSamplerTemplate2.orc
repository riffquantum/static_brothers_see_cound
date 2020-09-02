instrumentRoute "SyncLoopSamplerTemplate2", "DefaultEffectChain"
alwayson "SyncLoopSamplerTemplate2MixerChannel"

gkSyncLoopSamplerTemplate2EqBass init 1
gkSyncLoopSamplerTemplate2EqMid init 1
gkSyncLoopSamplerTemplate2EqHigh init 1
gkSyncLoopSamplerTemplate2Fader init 1
gkSyncLoopSamplerTemplate2Pan init 50

gSSyncLoopSamplerTemplate2SampleFilePath = "localSamples/gloria4ia.wav"
giSyncLoopSamplerTemplate2NumberOfChannels filenchnls gSSyncLoopSamplerTemplate2SampleFilePath
giSyncLoopSamplerTemplate2SampleLength filelen gSSyncLoopSamplerTemplate2SampleFilePath
giSyncLoopSamplerTemplate2StartTime = 0
giSyncLoopSamplerTemplate2EndTime = giSyncLoopSamplerTemplate2SampleLength - giSyncLoopSamplerTemplate2StartTime
giSyncLoopSamplerTemplate2EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giSyncLoopSamplerTemplate2SampleRate filesr gSSyncLoopSamplerTemplate2SampleFilePath

if giSyncLoopSamplerTemplate2NumberOfChannels == 2 then
  giSyncLoopSamplerTemplate2SampleTableL ftgenonce 0, 0, 0, 1, gSSyncLoopSamplerTemplate2SampleFilePath, giSyncLoopSamplerTemplate2StartTime, 0, 1
  giSyncLoopSamplerTemplate2SampleTableR ftgenonce 0, 0, 0, 1, gSSyncLoopSamplerTemplate2SampleFilePath, giSyncLoopSamplerTemplate2StartTime, 0, 2
else
  giSyncLoopSamplerTemplate2SampleTable ftgenonce 0, 0, 0, 1, gSSyncLoopSamplerTemplate2SampleFilePath, giSyncLoopSamplerTemplate2StartTime, 0, 0
endif

instr SyncLoopSamplerTemplate2
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

  if giSyncLoopSamplerTemplate2NumberOfChannels == 2 then
    aSyncLoopSamplerTemplate2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giSyncLoopSamplerTemplate2StartTime, giSyncLoopSamplerTemplate2EndTime, giSyncLoopSamplerTemplate2SampleTableL, giSyncLoopSamplerTemplate2EnvelopeTable, iMaxOverlaps
    aSyncLoopSamplerTemplate2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giSyncLoopSamplerTemplate2StartTime, giSyncLoopSamplerTemplate2EndTime, giSyncLoopSamplerTemplate2SampleTableR, giSyncLoopSamplerTemplate2EnvelopeTable, iMaxOverlaps

    aSyncLoopSamplerTemplate2L = aSyncLoopSamplerTemplate2L * kAmplitudeEnvelope
    aSyncLoopSamplerTemplate2R = aSyncLoopSamplerTemplate2R * kAmplitudeEnvelope
  else
    aSyncLoopSamplerTemplate2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giSyncLoopSamplerTemplate2StartTime, giSyncLoopSamplerTemplate2EndTime, giSyncLoopSamplerTemplate2SampleTable, giSyncLoopSamplerTemplate2EnvelopeTable, iMaxOverlaps
    aSyncLoopSamplerTemplate2L *= kAmplitudeEnvelope

    aSyncLoopSamplerTemplate2R = aSyncLoopSamplerTemplate2L
  endif

  outleta "OutL", aSyncLoopSamplerTemplate2L
  outleta "OutR", aSyncLoopSamplerTemplate2R
endin

instr SyncLoopSamplerTemplate2BassKnob
  gkSyncLoopSamplerTemplate2EqBass linseg p4, p3, p5
endin

instr SyncLoopSamplerTemplate2MidKnob
  gkSyncLoopSamplerTemplate2EqMid linseg p4, p3, p5
endin

instr SyncLoopSamplerTemplate2HighKnob
  gkSyncLoopSamplerTemplate2EqHigh linseg p4, p3, p5
endin

instr SyncLoopSamplerTemplate2Fader
  gkSyncLoopSamplerTemplate2Fader linseg p4, p3, p5
endin

instr SyncLoopSamplerTemplate2Pan
  gkSyncLoopSamplerTemplate2Pan linseg p4, p3, p5
endin

instr SyncLoopSamplerTemplate2MixerChannel
  aSyncLoopSamplerTemplate2L inleta "InL"
  aSyncLoopSamplerTemplate2R inleta "InR"

  aSyncLoopSamplerTemplate2L, aSyncLoopSamplerTemplate2R mixerChannel aSyncLoopSamplerTemplate2L, aSyncLoopSamplerTemplate2R, gkSyncLoopSamplerTemplate2Fader, gkSyncLoopSamplerTemplate2Pan, gkSyncLoopSamplerTemplate2EqBass, gkSyncLoopSamplerTemplate2EqMid, gkSyncLoopSamplerTemplate2EqHigh

  outleta "OutL", aSyncLoopSamplerTemplate2L
  outleta "OutR", aSyncLoopSamplerTemplate2R
endin
