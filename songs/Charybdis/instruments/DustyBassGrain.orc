instrumentRoute "DustyBassGrain", "DelayForDustyBassGrainInput"
alwayson "DustyBassGrainMixerChannel"

gkDustyBassGrainEqBass init 1
gkDustyBassGrainEqMid init 1
gkDustyBassGrainEqHigh init 1
gkDustyBassGrainFader init 1
gkDustyBassGrainPan init 50

gSDustyBassGrainSampleFilePath = "localSamples/cannedHeatDustyBass.wav"
giDustyBassGrainNumberOfChannels filenchnls gSDustyBassGrainSampleFilePath
giDustyBassGrainSampleLength filelen gSDustyBassGrainSampleFilePath
giDustyBassGrainStartTime = 0
giDustyBassGrainEndTime = giDustyBassGrainSampleLength - giDustyBassGrainStartTime
giDustyBassGrainEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giDustyBassGrainSampleRate filesr gSDustyBassGrainSampleFilePath

if giDustyBassGrainNumberOfChannels == 2 then
  giDustyBassGrainSampleTableL ftgenonce 0, 0, 0, 1, gSDustyBassGrainSampleFilePath, giDustyBassGrainStartTime, 0, 1
  giDustyBassGrainSampleTableR ftgenonce 0, 0, 0, 1, gSDustyBassGrainSampleFilePath, giDustyBassGrainStartTime, 0, 2
else
  giDustyBassGrainSampleTable ftgenonce 0, 0, 0, 1, gSDustyBassGrainSampleFilePath, giDustyBassGrainStartTime, 0, 0
endif

instr DustyBassGrain
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
  kTimeStretch = .002000
  kGrainSizeAdjustment = 4  + poscil(.005, .01)
  kGrainFrequencyAdjustment = 10 + poscil(.1, .01)
  kPitchAdjustment = 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = .5

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giDustyBassGrainNumberOfChannels == 2 then
    aDustyBassGrainL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giDustyBassGrainEndTime, giDustyBassGrainSampleTableL, giDustyBassGrainEnvelopeTable, iMaxOverlaps

    aDustyBassGrainR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giDustyBassGrainEndTime, giDustyBassGrainSampleTableR, giDustyBassGrainEnvelopeTable, iMaxOverlaps

    aDustyBassGrainL = aDustyBassGrainL * kAmplitudeEnvelope
    aDustyBassGrainR = aDustyBassGrainR * kAmplitudeEnvelope
  else
    aDustyBassGrainL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giDustyBassGrainEndTime, giDustyBassGrainSampleTable, giDustyBassGrainEnvelopeTable, iMaxOverlaps
    aDustyBassGrainL *= kAmplitudeEnvelope

    aDustyBassGrainR = aDustyBassGrainL
  endif

  outleta "OutL", aDustyBassGrainL
  outleta "OutR", aDustyBassGrainR
endin

instr DustyBassGrainBassKnob
  gkDustyBassGrainEqBass linseg p4, p3, p5
endin

instr DustyBassGrainMidKnob
  gkDustyBassGrainEqMid linseg p4, p3, p5
endin

instr DustyBassGrainHighKnob
  gkDustyBassGrainEqHigh linseg p4, p3, p5
endin

instr DustyBassGrainFader
  gkDustyBassGrainFader linseg p4, p3, p5
endin

instr DustyBassGrainPan
  gkDustyBassGrainPan linseg p4, p3, p5
endin

instr DustyBassGrainMixerChannel
  aDustyBassGrainL inleta "InL"
  aDustyBassGrainR inleta "InR"

  aDustyBassGrainL, aDustyBassGrainR mixerChannel aDustyBassGrainL, aDustyBassGrainR, gkDustyBassGrainFader, gkDustyBassGrainPan, gkDustyBassGrainEqBass, gkDustyBassGrainEqMid, gkDustyBassGrainEqHigh

  outleta "OutL", aDustyBassGrainL
  outleta "OutR", aDustyBassGrainR
endin
