instrumentRoute "DescentTwinkle", "Mixer"
alwayson "DescentTwinkleMixerChannel"

gkDescentTwinkleEqBass init 1
gkDescentTwinkleEqMid init 1
gkDescentTwinkleEqHigh init 1
gkDescentTwinkleFader init 1
gkDescentTwinklePan init 50

gSDescentTwinkleSampleFilePath = "localSamples/gloria2.wav"
giDescentTwinkleNumberOfChannels filenchnls gSDescentTwinkleSampleFilePath
giDescentTwinkleSampleLength filelen gSDescentTwinkleSampleFilePath
giDescentTwinkleStartTime = 0
giDescentTwinkleEndTime = giDescentTwinkleSampleLength - giDescentTwinkleStartTime
giDescentTwinkleEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giDescentTwinkleSampleRate filesr gSDescentTwinkleSampleFilePath

if giDescentTwinkleNumberOfChannels == 2 then
  giDescentTwinkleSampleTableL ftgenonce 0, 0, 0, 1, gSDescentTwinkleSampleFilePath, giDescentTwinkleStartTime, 0, 1
  giDescentTwinkleSampleTableR ftgenonce 0, 0, 0, 1, gSDescentTwinkleSampleFilePath, giDescentTwinkleStartTime, 0, 2
else
  giDescentTwinkleSampleTable ftgenonce 0, 0, 0, 1, gSDescentTwinkleSampleFilePath, giDescentTwinkleStartTime, 0, 0
endif

gkDescentTwinkleTimeStretch init 1
gkDescentTwinkleGrainSizeAdjustment init 1
gkDescentTwinkleGrainFrequencyAdjustment init 1
gkDescentTwinklePitchAdjustment init 1
gkDescentTwinkleGrainOverlapPercentageAdjustment init 1


instr DescentTwinkle
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

  kTimeStretch *= gkDescentTwinkleTimeStretch
  kGrainSizeAdjustment *= gkDescentTwinkleGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkDescentTwinkleGrainFrequencyAdjustment
  kPitchAdjustment *= gkDescentTwinklePitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkDescentTwinkleGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giDescentTwinkleNumberOfChannels == 2 then
    aDescentTwinkleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giDescentTwinkleStartTime, giDescentTwinkleEndTime, giDescentTwinkleSampleTableL, giDescentTwinkleEnvelopeTable, iMaxOverlaps
    aDescentTwinkleR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giDescentTwinkleStartTime, giDescentTwinkleEndTime, giDescentTwinkleSampleTableR, giDescentTwinkleEnvelopeTable, iMaxOverlaps

    aDescentTwinkleL = aDescentTwinkleL * kAmplitudeEnvelope
    aDescentTwinkleR = aDescentTwinkleR * kAmplitudeEnvelope
  else
    aDescentTwinkleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giDescentTwinkleStartTime, giDescentTwinkleEndTime, giDescentTwinkleSampleTable, giDescentTwinkleEnvelopeTable, iMaxOverlaps

    aDescentTwinkleL *= kAmplitudeEnvelope

    aDescentTwinkleR = aDescentTwinkleL
  endif

  outleta "OutL", aDescentTwinkleL
  outleta "OutR", aDescentTwinkleR
endin

instr DescentTwinkleBassKnob
  gkDescentTwinkleEqBass linseg p4, p3, p5
endin

instr DescentTwinkleMidKnob
  gkDescentTwinkleEqMid linseg p4, p3, p5
endin

instr DescentTwinkleHighKnob
  gkDescentTwinkleEqHigh linseg p4, p3, p5
endin

instr DescentTwinkleFader
  gkDescentTwinkleFader linseg p4, p3, p5
endin

instr DescentTwinklePan
  gkDescentTwinklePan linseg p4, p3, p5
endin

instr DescentTwinkleMixerChannel
  aDescentTwinkleL inleta "InL"
  aDescentTwinkleR inleta "InR"

  aDescentTwinkleL, aDescentTwinkleR mixerChannel aDescentTwinkleL, aDescentTwinkleR, gkDescentTwinkleFader, gkDescentTwinklePan, gkDescentTwinkleEqBass, gkDescentTwinkleEqMid, gkDescentTwinkleEqHigh

  outleta "OutL", aDescentTwinkleL
  outleta "OutR", aDescentTwinkleR
endin
