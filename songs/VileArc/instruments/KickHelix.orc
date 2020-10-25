instrumentRoute "KickHelix", "Mixer"
alwayson "KickHelixMixerChannel"

gkKickHelixEqBass init 1
gkKickHelixEqMid init 1
gkKickHelixEqHigh init 1
gkKickHelixFader init 1
gkKickHelixPan init 50

gSKickHelixSampleFilePath = "localSamples/CB_Kick.wav"
giKickHelixNumberOfChannels filenchnls gSKickHelixSampleFilePath
giKickHelixSampleLength filelen gSKickHelixSampleFilePath
giKickHelixStartTime = 0
giKickHelixEndTime = giKickHelixSampleLength - giKickHelixStartTime
giKickHelixEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giKickHelixSampleRate filesr gSKickHelixSampleFilePath

if giKickHelixNumberOfChannels == 2 then
  giKickHelixSampleTableL ftgenonce 0, 0, 0, 1, gSKickHelixSampleFilePath, giKickHelixStartTime, 0, 1
  giKickHelixSampleTableR ftgenonce 0, 0, 0, 1, gSKickHelixSampleFilePath, giKickHelixStartTime, 0, 2
else
  giKickHelixSampleTable ftgenonce 0, 0, 0, 1, gSKickHelixSampleFilePath, giKickHelixStartTime, 0, 0
endif

gkKickHelixTimeStretch init 1
gkKickHelixGrainSizeAdjustment init 1
gkKickHelixGrainFrequencyAdjustment init 1
gkKickHelixPitchAdjustment init 1
gkKickHelixGrainOverlapPercentageAdjustment init 1

instr KickHelix
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
  kTimeStretch = .01 + poscil(.04, 1.87) + poscil(.2, .3)
  kGrainSizeAdjustment = .3 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 2+ poscil(.04, .87) + poscil(.2, .3)

  kTimeStretch *= gkKickHelixTimeStretch
  kGrainSizeAdjustment *= gkKickHelixGrainSizeAdjustment
  kGrainFrequencyAdjustment  *= gkKickHelixGrainFrequencyAdjustment
  kPitchAdjustment *= gkKickHelixPitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkKickHelixGrainOverlapPercentageAdjustment


  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giKickHelixNumberOfChannels == 2 then
    aKickHelixL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giKickHelixStartTime, giKickHelixEndTime, giKickHelixSampleTableL, giKickHelixEnvelopeTable, iMaxOverlaps
    aKickHelixR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giKickHelixStartTime, giKickHelixEndTime, giKickHelixSampleTableR, giKickHelixEnvelopeTable, iMaxOverlaps

    aKickHelixL = aKickHelixL * kAmplitudeEnvelope
    aKickHelixR = aKickHelixR * kAmplitudeEnvelope
  else
    aKickHelixL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giKickHelixStartTime, giKickHelixEndTime, giKickHelixSampleTable, giKickHelixEnvelopeTable, iMaxOverlaps
    aKickHelixL *= kAmplitudeEnvelope

    aKickHelixR = aKickHelixL
  endif

  outleta "OutL", aKickHelixL
  outleta "OutR", aKickHelixR
endin

instr KickHelixBassKnob
  gkKickHelixEqBass linseg p4, p3, p5
endin

instr KickHelixMidKnob
  gkKickHelixEqMid linseg p4, p3, p5
endin

instr KickHelixHighKnob
  gkKickHelixEqHigh linseg p4, p3, p5
endin

instr KickHelixFader
  gkKickHelixFader linseg p4, p3, p5
endin

instr KickHelixPan
  gkKickHelixPan linseg p4, p3, p5
endin

instr KickHelixMixerChannel
  aKickHelixL inleta "InL"
  aKickHelixR inleta "InR"

  aKickHelixL, aKickHelixR mixerChannel aKickHelixL, aKickHelixR, gkKickHelixFader, gkKickHelixPan, gkKickHelixEqBass, gkKickHelixEqMid, gkKickHelixEqHigh

  outleta "OutL", aKickHelixL
  outleta "OutR", aKickHelixR
endin
