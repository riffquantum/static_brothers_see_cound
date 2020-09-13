instrumentRoute "DescentTwinkle2", "Mixer"
alwayson "DescentTwinkle2MixerChannel"

gkDescentTwinkle2EqBass init 1
gkDescentTwinkle2EqMid init 1
gkDescentTwinkle2EqHigh init 1
gkDescentTwinkle2Fader init 1
gkDescentTwinkle2Pan init 50

gSDescentTwinkle2SampleFilePath = "localSamples/gloria2.wav"
giDescentTwinkle2NumberOfChannels filenchnls gSDescentTwinkle2SampleFilePath
giDescentTwinkle2SampleLength filelen gSDescentTwinkle2SampleFilePath
giDescentTwinkle2StartTime = 2
giDescentTwinkle2EndTime = giDescentTwinkle2SampleLength - giDescentTwinkle2StartTime
giDescentTwinkle2EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giDescentTwinkle2SampleRate filesr gSDescentTwinkle2SampleFilePath

gkDescentTwinkle2TimeStretch init 1
gkDescentTwinkle2GrainSizeAdjustment init 1
gkDescentTwinkle2GrainFrequencyAdjustment init 1
gkDescentTwinkle2PitchAdjustment init 1
gkDescentTwinkle2GrainOverlapPercentageAdjustment init 1

if giDescentTwinkle2NumberOfChannels == 2 then
  giDescentTwinkle2SampleTableL ftgenonce 0, 0, 0, 1, gSDescentTwinkle2SampleFilePath, giDescentTwinkle2StartTime, 0, 1
  giDescentTwinkle2SampleTableR ftgenonce 0, 0, 0, 1, gSDescentTwinkle2SampleFilePath, giDescentTwinkle2StartTime, 0, 2
else
  giDescentTwinkle2SampleTable ftgenonce 0, 0, 0, 1, gSDescentTwinkle2SampleFilePath, giDescentTwinkle2StartTime, 0, 0
endif

instr DescentTwinkle2
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = 2
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude


  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  ;Grain Parameter Adjustments
  kTimeStretch = .1 ;+ poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = 10 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1 + line(0, 1, -.01) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 2 ;+ poscil(.04, .87) + poscil(.2, .3)

  kTimeStretch *= gkDescentTwinkle2TimeStretch
  kGrainSizeAdjustment *= gkDescentTwinkle2GrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkDescentTwinkle2GrainFrequencyAdjustment
  kPitchAdjustment *= gkDescentTwinkle2PitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkDescentTwinkle2GrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giDescentTwinkle2NumberOfChannels == 2 then
    aDescentTwinkle2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giDescentTwinkle2StartTime, giDescentTwinkle2EndTime, giDescentTwinkle2SampleTableL, giDescentTwinkle2EnvelopeTable, iMaxOverlaps
    aDescentTwinkle2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giDescentTwinkle2StartTime, giDescentTwinkle2EndTime, giDescentTwinkle2SampleTableR, giDescentTwinkle2EnvelopeTable, iMaxOverlaps

    aDescentTwinkle2L = aDescentTwinkle2L * kAmplitudeEnvelope
    aDescentTwinkle2R = aDescentTwinkle2R * kAmplitudeEnvelope
  else
    aDescentTwinkle2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giDescentTwinkle2StartTime, giDescentTwinkle2EndTime, giDescentTwinkle2SampleTable, giDescentTwinkle2EnvelopeTable, iMaxOverlaps

    aDescentTwinkle2L *= kAmplitudeEnvelope

    aDescentTwinkle2R = aDescentTwinkle2L
  endif

  outleta "OutL", aDescentTwinkle2L
  outleta "OutR", aDescentTwinkle2R
endin

instr DescentTwinkle2BassKnob
  gkDescentTwinkle2EqBass linseg p4, p3, p5
endin

instr DescentTwinkle2MidKnob
  gkDescentTwinkle2EqMid linseg p4, p3, p5
endin

instr DescentTwinkle2HighKnob
  gkDescentTwinkle2EqHigh linseg p4, p3, p5
endin

instr DescentTwinkle2Fader
  gkDescentTwinkle2Fader linseg p4, p3, p5
endin

instr DescentTwinkle2Pan
  gkDescentTwinkle2Pan linseg p4, p3, p5
endin

instr DescentTwinkle2MixerChannel
  aDescentTwinkle2L inleta "InL"
  aDescentTwinkle2R inleta "InR"

  aDescentTwinkle2L, aDescentTwinkle2R mixerChannel aDescentTwinkle2L, aDescentTwinkle2R, gkDescentTwinkle2Fader, gkDescentTwinkle2Pan, gkDescentTwinkle2EqBass, gkDescentTwinkle2EqMid, gkDescentTwinkle2EqHigh

  outleta "OutL", aDescentTwinkle2L
  outleta "OutR", aDescentTwinkle2R
endin
