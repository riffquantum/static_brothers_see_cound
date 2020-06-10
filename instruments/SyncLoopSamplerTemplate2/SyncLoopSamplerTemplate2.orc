instrumentRoute "SyncLoopSamplerTemplate2", "Mixer"
alwayson "SyncLoopSamplerTemplate2MixerChannel"

gkSyncLoopSamplerTemplate2EqBass init 1
gkSyncLoopSamplerTemplate2EqMid init 1
gkSyncLoopSamplerTemplate2EqHigh init 1
gkSyncLoopSamplerTemplate2Fader init 1
gkSyncLoopSamplerTemplate2Pan init 50

gSSyncLoopSamplerTemplate2SampleFilePath = "localSamples/Drums/Beatbox-Drums_Kick_EA7508.wav"
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

/* MIDI Config Values */
massign giSyncLoopSamplerTemplate2MidiChannel, "SyncLoopSamplerTemplate2"

instr SyncLoopSamplerTemplate2
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  kPitch = flexiblePitchInput(p5) / 261.6

  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = iAmplitude
  iRelease = .5
  kAmplitudeEnvelope madsr iAttack, iDecay, iSustain, iRelease

  ;Grain Parameter Adjustments
  kTimeStretch = 1
  kGrainSizeAdjustment = .4  + poscil(.005, .01)
  kGrainFrequencyAdjustment = 1 + poscil(.1, .01)
  kPitchAdjustment = 1 + poscil(.1, .1)
  kGrainOverlapPercentageAdjustment = 1

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giSyncLoopSamplerTemplate2NumberOfChannels == 2 then
    aSyncLoopSamplerTemplate2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giSyncLoopSamplerTemplate2EndTime, giSyncLoopSamplerTemplate2SampleTableL, giSyncLoopSamplerTemplate2EnvelopeTable, iMaxOverlaps

    aSyncLoopSamplerTemplate2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giSyncLoopSamplerTemplate2EndTime, giSyncLoopSamplerTemplate2SampleTableR, giSyncLoopSamplerTemplate2EnvelopeTable, iMaxOverlaps

    aSyncLoopSamplerTemplate2L = aSyncLoopSamplerTemplate2L * kAmplitudeEnvelope
    aSyncLoopSamplerTemplate2R = aSyncLoopSamplerTemplate2R * kAmplitudeEnvelope
  else
    aSyncLoopSamplerTemplate2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giSyncLoopSamplerTemplate2EndTime, giSyncLoopSamplerTemplate2SampleTable, giSyncLoopSamplerTemplate2EnvelopeTable, iMaxOverlaps

    aSyncLoopSamplerTemplate2R = aSyncLoopSamplerTemplate2R * kAmplitudeEnvelope

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
