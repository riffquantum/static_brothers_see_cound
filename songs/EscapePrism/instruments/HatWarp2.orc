instrumentRoute "HatWarp2", "DefaultEffectChainReverbInput"
alwayson "HatWarp2MixerChannel"

gkHatWarp2EqBass init 1
gkHatWarp2EqMid init 1
gkHatWarp2EqHigh init 1
gkHatWarp2Fader init 1
gkHatWarp2Pan init 50

gSHatWarp2SampleFilePath = "localSamples/Drums/Beatbox-Drums_Closed-Hat_EA7544.wav"
giHatWarp2NumberOfChannels filenchnls gSHatWarp2SampleFilePath
giHatWarp2SampleLength filelen gSHatWarp2SampleFilePath
giHatWarp2StartTime = 0
giHatWarp2EndTime = giHatWarp2SampleLength - giHatWarp2StartTime
giHatWarp2EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giHatWarp2SampleRate filesr gSHatWarp2SampleFilePath

if giHatWarp2NumberOfChannels == 2 then
  giHatWarp2SampleTableL ftgenonce 0, 0, 0, 1, gSHatWarp2SampleFilePath, giHatWarp2StartTime, 0, 1
  giHatWarp2SampleTableR ftgenonce 0, 0, 0, 1, gSHatWarp2SampleFilePath, giHatWarp2StartTime, 0, 2
else
  giHatWarp2SampleTable ftgenonce 0, 0, 0, 1, gSHatWarp2SampleFilePath, giHatWarp2StartTime, 0, 0
endif

gkHatWarp2TimeStretch init 1
gkHatWarp2GrainSizeAdjustment init 1
gkHatWarp2GrainFrequencyAdjustment init 1
gkHatWarp2PitchAdjustment init 1
gkHatWarp2GrainOverlapPercentageAdjustment init 1

instr HatWarp2
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  iGrainFrequencyForInstance = p6 <= 0 ? 1 : p6
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
  kTimeStretch = .1 + poscil(.4, beatsToSeconds(1)) + poscil(.2, .3)
  kGrainSizeAdjustment = .3 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = iGrainFrequencyForInstance + poscil(.4, beatsToSeconds(4)) + poscil(.2, .3)
  kPitchAdjustment = 1 + linseg(0, beatsToSeconds(4), .025, beatsToSeconds(4), 0);+ poscil(.01, .5) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 2+ poscil(.04, .87) + poscil(.2, .3)

  kTimeStretch *= p6 == 0 ? 1 : p6
  kGrainSizeAdjustment *= p8 == 0 ? 1 : p8
  kGrainFrequencyAdjustment *= p9 == 0 ? 1 : p9
  kPitchAdjustment *= p10 == 0 ? 1 : p10
  kGrainOverlapPercentageAdjustment *= p11 == 0 ? 1 : p11

  kTimeStretch *= gkHatWarp2TimeStretch
  kGrainSizeAdjustment *= gkHatWarp2GrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkHatWarp2GrainFrequencyAdjustment
  kPitchAdjustment *= gkHatWarp2PitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkHatWarp2GrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giHatWarp2NumberOfChannels == 2 then
    aHatWarp2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giHatWarp2StartTime, giHatWarp2EndTime, giHatWarp2SampleTableL, giHatWarp2EnvelopeTable, iMaxOverlaps
    aHatWarp2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giHatWarp2StartTime, giHatWarp2EndTime, giHatWarp2SampleTableR, giHatWarp2EnvelopeTable, iMaxOverlaps

    aHatWarp2L = aHatWarp2L * kAmplitudeEnvelope
    aHatWarp2R = aHatWarp2R * kAmplitudeEnvelope
  else
    aHatWarp2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giHatWarp2StartTime, giHatWarp2EndTime, giHatWarp2SampleTable, giHatWarp2EnvelopeTable, iMaxOverlaps
    aHatWarp2L *= kAmplitudeEnvelope

    aHatWarp2R = aHatWarp2L
  endif

  outleta "OutL", aHatWarp2L
  outleta "OutR", aHatWarp2R
endin

instr HatWarp2BassKnob
  gkHatWarp2EqBass linseg p4, p3, p5
endin

instr HatWarp2MidKnob
  gkHatWarp2EqMid linseg p4, p3, p5
endin

instr HatWarp2HighKnob
  gkHatWarp2EqHigh linseg p4, p3, p5
endin

instr HatWarp2Fader
  gkHatWarp2Fader linseg p4, p3, p5
endin

instr HatWarp2Pan
  gkHatWarp2Pan linseg p4, p3, p5
endin

instr HatWarp2MixerChannel
  aHatWarp2L inleta "InL"
  aHatWarp2R inleta "InR"

  aHatWarp2L, aHatWarp2R mixerChannel aHatWarp2L, aHatWarp2R, gkHatWarp2Fader, gkHatWarp2Pan, gkHatWarp2EqBass, gkHatWarp2EqMid, gkHatWarp2EqHigh

  outleta "OutL", aHatWarp2L
  outleta "OutR", aHatWarp2R
endin
