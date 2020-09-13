instrumentRoute "ItsOnlyLove", "Mixer"
alwayson "ItsOnlyLoveMixerChannel"

gkItsOnlyLoveEqBass init 1
gkItsOnlyLoveEqMid init 1
gkItsOnlyLoveEqHigh init 1
gkItsOnlyLoveFader init 1
gkItsOnlyLovePan init 50

gkItsOnlyLoveTimeStretch init 1
gkItsOnlyLoveGrainSizeAdjustment init 1
gkItsOnlyLoveGrainFrequencyAdjustment init 1
gkItsOnlyLovePitchAdjustment init 1
gkItsOnlyLoveGrainOverlapPercentageAdjustment init 1

gSItsOnlyLoveSampleFilePath = "localSamples/itsOnlyLoveBreak.wav"
giItsOnlyLoveNumberOfChannels filenchnls gSItsOnlyLoveSampleFilePath
giItsOnlyLoveSampleLength filelen gSItsOnlyLoveSampleFilePath
giItsOnlyLoveStartTime = 0
giItsOnlyLoveEndTime = giItsOnlyLoveSampleLength - giItsOnlyLoveStartTime
giItsOnlyLoveEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giItsOnlyLoveSampleRate filesr gSItsOnlyLoveSampleFilePath

if giItsOnlyLoveNumberOfChannels == 2 then
  giItsOnlyLoveSampleTableL ftgenonce 0, 0, 0, 1, gSItsOnlyLoveSampleFilePath, giItsOnlyLoveStartTime, 0, 1
  giItsOnlyLoveSampleTableR ftgenonce 0, 0, 0, 1, gSItsOnlyLoveSampleFilePath, giItsOnlyLoveStartTime, 0, 2
else
  giItsOnlyLoveSampleTable ftgenonce 0, 0, 0, 1, gSItsOnlyLoveSampleFilePath, giItsOnlyLoveStartTime, 0, 0
endif

instr ItsOnlyLove
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
  kTimeStretch = 0 + poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1; + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)

  kTimeStretch *= gkItsOnlyLoveTimeStretch
  kGrainSizeAdjustment *= gkItsOnlyLoveGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkItsOnlyLoveGrainFrequencyAdjustment
  kPitchAdjustment *= gkItsOnlyLovePitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkItsOnlyLoveGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giItsOnlyLoveNumberOfChannels == 2 then
    aItsOnlyLoveL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsOnlyLoveStartTime, giItsOnlyLoveEndTime, giItsOnlyLoveSampleTableL, giItsOnlyLoveEnvelopeTable, iMaxOverlaps
    aItsOnlyLoveR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsOnlyLoveStartTime, giItsOnlyLoveEndTime, giItsOnlyLoveSampleTableR, giItsOnlyLoveEnvelopeTable, iMaxOverlaps

    aItsOnlyLoveL = aItsOnlyLoveL * kAmplitudeEnvelope
    aItsOnlyLoveR = aItsOnlyLoveR * kAmplitudeEnvelope
  else
    aItsOnlyLoveL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giItsOnlyLoveStartTime, giItsOnlyLoveEndTime, giItsOnlyLoveSampleTable, giItsOnlyLoveEnvelopeTable, iMaxOverlaps
    aItsOnlyLoveL *= kAmplitudeEnvelope

    aItsOnlyLoveR = aItsOnlyLoveL
  endif

  outleta "OutL", aItsOnlyLoveL
  outleta "OutR", aItsOnlyLoveR
endin

instr ItsOnlyLoveBassKnob
  gkItsOnlyLoveEqBass linseg p4, p3, p5
endin

instr ItsOnlyLoveMidKnob
  gkItsOnlyLoveEqMid linseg p4, p3, p5
endin

instr ItsOnlyLoveHighKnob
  gkItsOnlyLoveEqHigh linseg p4, p3, p5
endin

instr ItsOnlyLoveFader
  gkItsOnlyLoveFader linseg p4, p3, p5
endin

instr ItsOnlyLovePan
  gkItsOnlyLovePan linseg p4, p3, p5
endin

instr ItsOnlyLoveMixerChannel
  aItsOnlyLoveL inleta "InL"
  aItsOnlyLoveR inleta "InR"

  aItsOnlyLoveL, aItsOnlyLoveR mixerChannel aItsOnlyLoveL, aItsOnlyLoveR, gkItsOnlyLoveFader, gkItsOnlyLovePan, gkItsOnlyLoveEqBass, gkItsOnlyLoveEqMid, gkItsOnlyLoveEqHigh

  outleta "OutL", aItsOnlyLoveL
  outleta "OutR", aItsOnlyLoveR
endin
