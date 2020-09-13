instrumentRoute "ItsOnlyLove2", "Mixer"
alwayson "ItsOnlyLove2MixerChannel"

gkItsOnlyLove2EqBass init 1
gkItsOnlyLove2EqMid init 1
gkItsOnlyLove2EqHigh init 1
gkItsOnlyLove2Fader init 1
gkItsOnlyLove2Pan init 50

gSItsOnlyLove2SampleFilePath = "localSamples/itsOnlyLoveBreak.wav"
giItsOnlyLove2NumberOfChannels filenchnls gSItsOnlyLove2SampleFilePath
giItsOnlyLove2SampleLength filelen gSItsOnlyLove2SampleFilePath
giItsOnlyLove2StartTime = 3.2
giItsOnlyLove2EndTime = giItsOnlyLove2SampleLength - giItsOnlyLove2StartTime
giItsOnlyLove2EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giItsOnlyLove2SampleRate filesr gSItsOnlyLove2SampleFilePath

if giItsOnlyLove2NumberOfChannels == 2 then
  giItsOnlyLove2SampleTableL ftgenonce 0, 0, 0, 1, gSItsOnlyLove2SampleFilePath, giItsOnlyLove2StartTime, 0, 1
  giItsOnlyLove2SampleTableR ftgenonce 0, 0, 0, 1, gSItsOnlyLove2SampleFilePath, giItsOnlyLove2StartTime, 0, 2
else
  giItsOnlyLove2SampleTable ftgenonce 0, 0, 0, 1, gSItsOnlyLove2SampleFilePath, giItsOnlyLove2StartTime, 0, 0
endif

instr ItsOnlyLove2
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
  ;Amplitude Envelope
  iAttack = .001
  iDecay = .01
  iSustain = 1
  iRelease = .5
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude


  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  ;Grain Parameter Adjustments
  kTimeStretch = 0 + poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = 1.2 + poscil(.04, .87) ;+ poscil(.2, .3)
  kGrainFrequencyAdjustment = .5 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1; + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giItsOnlyLove2NumberOfChannels == 2 then
    aItsOnlyLove2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsOnlyLove2StartTime, giItsOnlyLove2EndTime, giItsOnlyLove2SampleTableL, giItsOnlyLove2EnvelopeTable, iMaxOverlaps
    aItsOnlyLove2R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsOnlyLove2StartTime, giItsOnlyLove2EndTime, giItsOnlyLove2SampleTableR, giItsOnlyLove2EnvelopeTable, iMaxOverlaps

    aItsOnlyLove2L = aItsOnlyLove2L * kAmplitudeEnvelope
    aItsOnlyLove2R = aItsOnlyLove2R * kAmplitudeEnvelope
  else
    aItsOnlyLove2L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsOnlyLove2StartTime, giItsOnlyLove2EndTime, giItsOnlyLove2SampleTable, giItsOnlyLove2EnvelopeTable, iMaxOverlaps
    aItsOnlyLove2L *= kAmplitudeEnvelope

    aItsOnlyLove2R = aItsOnlyLove2L
  endif

  outleta "OutL", aItsOnlyLove2L
  outleta "OutR", aItsOnlyLove2R
endin

instr ItsOnlyLove2BassKnob
  gkItsOnlyLove2EqBass linseg p4, p3, p5
endin

instr ItsOnlyLove2MidKnob
  gkItsOnlyLove2EqMid linseg p4, p3, p5
endin

instr ItsOnlyLove2HighKnob
  gkItsOnlyLove2EqHigh linseg p4, p3, p5
endin

instr ItsOnlyLove2Fader
  gkItsOnlyLove2Fader linseg p4, p3, p5
endin

instr ItsOnlyLove2Pan
  gkItsOnlyLove2Pan linseg p4, p3, p5
endin

instr ItsOnlyLove2MixerChannel
  aItsOnlyLove2L inleta "InL"
  aItsOnlyLove2R inleta "InR"

  aItsOnlyLove2L, aItsOnlyLove2R mixerChannel aItsOnlyLove2L, aItsOnlyLove2R, gkItsOnlyLove2Fader, gkItsOnlyLove2Pan, gkItsOnlyLove2EqBass, gkItsOnlyLove2EqMid, gkItsOnlyLove2EqHigh

  outleta "OutL", aItsOnlyLove2L
  outleta "OutR", aItsOnlyLove2R
endin
