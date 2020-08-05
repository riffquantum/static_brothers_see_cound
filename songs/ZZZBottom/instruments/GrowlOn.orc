instrumentRoute "GrowlOn", "Mixer"
alwayson "GrowlOnMixerChannel"

gkGrowlOnEqBass init 1
gkGrowlOnEqMid init 1
gkGrowlOnEqHigh init 1
gkGrowlOnFader init 1
gkGrowlOnPan init 50

gSGrowlOnSampleFilePath = "localSamples/blueangel5.wav"
giGrowlOnNumberOfChannels filenchnls gSGrowlOnSampleFilePath
giGrowlOnSampleLength filelen gSGrowlOnSampleFilePath
giGrowlOnStartTime = 0.05
giGrowlOnEndTime = giGrowlOnSampleLength - giGrowlOnStartTime
giGrowlOnEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giGrowlOnSampleRate filesr gSGrowlOnSampleFilePath

if giGrowlOnNumberOfChannels == 2 then
  giGrowlOnSampleTableL ftgenonce 0, 0, 0, 1, gSGrowlOnSampleFilePath, giGrowlOnStartTime, 0, 1
  giGrowlOnSampleTableR ftgenonce 0, 0, 0, 1, gSGrowlOnSampleFilePath, giGrowlOnStartTime, 0, 2
else
  giGrowlOnSampleTable ftgenonce 0, 0, 0, 1, gSGrowlOnSampleFilePath, giGrowlOnStartTime, 0, 0
endif

instr GrowlOn
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = 1
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude


  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  ;Grain Parameter Adjustments
  kTimeStretch = .2 ;+ poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = .1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1; + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giGrowlOnNumberOfChannels == 2 then
    aGrowlOnL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giGrowlOnStartTime, giGrowlOnEndTime, giGrowlOnSampleTableL, giGrowlOnEnvelopeTable, iMaxOverlaps
    aGrowlOnR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giGrowlOnStartTime, giGrowlOnEndTime, giGrowlOnSampleTableR, giGrowlOnEnvelopeTable, iMaxOverlaps

    aGrowlOnL = aGrowlOnL * kAmplitudeEnvelope
    aGrowlOnR = aGrowlOnR * kAmplitudeEnvelope
  else
    aGrowlOnL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giGrowlOnStartTime, giGrowlOnEndTime, giGrowlOnSampleTable, giGrowlOnEnvelopeTable, iMaxOverlaps

    aGrowlOnR = aGrowlOnR * kAmplitudeEnvelope

    aGrowlOnR = aGrowlOnL
  endif

  outleta "OutL", aGrowlOnL
  outleta "OutR", aGrowlOnR
endin

instr GrowlOnBassKnob
  gkGrowlOnEqBass linseg p4, p3, p5
endin

instr GrowlOnMidKnob
  gkGrowlOnEqMid linseg p4, p3, p5
endin

instr GrowlOnHighKnob
  gkGrowlOnEqHigh linseg p4, p3, p5
endin

instr GrowlOnFader
  gkGrowlOnFader linseg p4, p3, p5
endin

instr GrowlOnPan
  gkGrowlOnPan linseg p4, p3, p5
endin

instr GrowlOnMixerChannel
  aGrowlOnL inleta "InL"
  aGrowlOnR inleta "InR"

  aGrowlOnL, aGrowlOnR mixerChannel aGrowlOnL, aGrowlOnR, gkGrowlOnFader, gkGrowlOnPan, gkGrowlOnEqBass, gkGrowlOnEqMid, gkGrowlOnEqHigh

  outleta "OutL", aGrowlOnL
  outleta "OutR", aGrowlOnR
endin
