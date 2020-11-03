instrumentRoute "HatWarp", "DefaultEffectChainReverbInput"
alwayson "HatWarpMixerChannel"

gkHatWarpEqBass init 1
gkHatWarpEqMid init 1
gkHatWarpEqHigh init 1
gkHatWarpFader init 1
gkHatWarpPan init 50

gSHatWarpSampleFilePath = "localSamples/Drums/Beatbox-Drums_Closed-Hat_EA7544.wav"
giHatWarpNumberOfChannels filenchnls gSHatWarpSampleFilePath
giHatWarpSampleLength filelen gSHatWarpSampleFilePath
giHatWarpStartTime = 0
giHatWarpEndTime = giHatWarpSampleLength - giHatWarpStartTime
giHatWarpEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giHatWarpSampleRate filesr gSHatWarpSampleFilePath

if giHatWarpNumberOfChannels == 2 then
  giHatWarpSampleTableL ftgenonce 0, 0, 0, 1, gSHatWarpSampleFilePath, giHatWarpStartTime, 0, 1
  giHatWarpSampleTableR ftgenonce 0, 0, 0, 1, gSHatWarpSampleFilePath, giHatWarpStartTime, 0, 2
else
  giHatWarpSampleTable ftgenonce 0, 0, 0, 1, gSHatWarpSampleFilePath, giHatWarpStartTime, 0, 0
endif

gkHatWarpTimeStretch init 1
gkHatWarpGrainSizeAdjustment init 1
gkHatWarpGrainFrequencyAdjustment init 1
gkHatWarpPitchAdjustment init 1
gkHatWarpGrainOverlapPercentageAdjustment init 1

instr HatWarp
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

  kTimeStretch *= gkHatWarpTimeStretch
  kGrainSizeAdjustment *= gkHatWarpGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkHatWarpGrainFrequencyAdjustment
  kPitchAdjustment *= gkHatWarpPitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkHatWarpGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giHatWarpNumberOfChannels == 2 then
    aHatWarpL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giHatWarpStartTime, giHatWarpEndTime, giHatWarpSampleTableL, giHatWarpEnvelopeTable, iMaxOverlaps
    aHatWarpR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giHatWarpStartTime, giHatWarpEndTime, giHatWarpSampleTableR, giHatWarpEnvelopeTable, iMaxOverlaps

    aHatWarpL = aHatWarpL * kAmplitudeEnvelope
    aHatWarpR = aHatWarpR * kAmplitudeEnvelope
  else
    aHatWarpL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giHatWarpStartTime, giHatWarpEndTime, giHatWarpSampleTable, giHatWarpEnvelopeTable, iMaxOverlaps
    aHatWarpL *= kAmplitudeEnvelope

    aHatWarpR = aHatWarpL
  endif

  outleta "OutL", aHatWarpL
  outleta "OutR", aHatWarpR
endin

instr HatWarpBassKnob
  gkHatWarpEqBass linseg p4, p3, p5
endin

instr HatWarpMidKnob
  gkHatWarpEqMid linseg p4, p3, p5
endin

instr HatWarpHighKnob
  gkHatWarpEqHigh linseg p4, p3, p5
endin

instr HatWarpFader
  gkHatWarpFader linseg p4, p3, p5
endin

instr HatWarpPan
  gkHatWarpPan linseg p4, p3, p5
endin

instr HatWarpMixerChannel
  aHatWarpL inleta "InL"
  aHatWarpR inleta "InR"

  aHatWarpL, aHatWarpR mixerChannel aHatWarpL, aHatWarpR, gkHatWarpFader, gkHatWarpPan, gkHatWarpEqBass, gkHatWarpEqMid, gkHatWarpEqHigh

  outleta "OutL", aHatWarpL
  outleta "OutR", aHatWarpR
endin
