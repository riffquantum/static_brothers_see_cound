instrumentRoute "GrainStab", "DelayForGrainStabInput"
alwayson "GrainStabMixerChannel"

gkGrainStabEqBass init 1
gkGrainStabEqMid init 1
gkGrainStabEqHigh init 1
gkGrainStabFader init 1
gkGrainStabPan init 50

gSGrainStabSampleFilePath = "localSamples/willieStab2.wav"
giGrainStabNumberOfChannels filenchnls gSGrainStabSampleFilePath
giGrainStabSampleLength filelen gSGrainStabSampleFilePath
giGrainStabStartTime = 0
giGrainStabEndTime = giGrainStabSampleLength - giGrainStabStartTime
giGrainStabEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giGrainStabSampleRate filesr gSGrainStabSampleFilePath

if giGrainStabNumberOfChannels == 2 then
  giGrainStabSampleTableL ftgenonce 0, 0, 0, 1, gSGrainStabSampleFilePath, giGrainStabStartTime, 0, 1
  giGrainStabSampleTableR ftgenonce 0, 0, 0, 1, gSGrainStabSampleFilePath, giGrainStabStartTime, 0, 2
else
  giGrainStabSampleTable ftgenonce 0, 0, 0, 1, gSGrainStabSampleFilePath, giGrainStabStartTime, 0, 0
endif

instr GrainStab
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = .1
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

  kTimeStretch = p6 == 0 ? 1 : p6
  kGrainSizeAdjustment = p8 == 0 ? 1 : p8
  kGrainFrequencyAdjustment = p9 == 0 ? 1 : p9
  kPitchAdjustment = p10 == 0 ? 1 : p10
  kGrainOverlapPercentageAdjustment = p11 == 0 ? 1 : p11

  kPitchBend = 0
  midipitchbend kPitchBend, 0, 100

  ;Grain Parameter Adjustments
  kTimeStretch *= .3 * (1 + kPitchBend) ; - poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment *= .3 + poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment *= 1 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= .99 ;+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giGrainStabNumberOfChannels == 2 then
    aGrainStabL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giGrainStabStartTime, giGrainStabEndTime, giGrainStabSampleTableL, giGrainStabEnvelopeTable, iMaxOverlaps
    aGrainStabR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giGrainStabStartTime, giGrainStabEndTime, giGrainStabSampleTableR, giGrainStabEnvelopeTable, iMaxOverlaps

    aGrainStabL = aGrainStabL * kAmplitudeEnvelope
    aGrainStabR = aGrainStabR * kAmplitudeEnvelope
  else
    aGrainStabL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giGrainStabStartTime, giGrainStabEndTime, giGrainStabSampleTable, giGrainStabEnvelopeTable, iMaxOverlaps

    aGrainStabL *= kAmplitudeEnvelope

    aGrainStabR = aGrainStabL
  endif

  outleta "OutL", aGrainStabL
  outleta "OutR", aGrainStabR
endin

instr GrainStabBassKnob
  gkGrainStabEqBass linseg p4, p3, p5
endin

instr GrainStabMidKnob
  gkGrainStabEqMid linseg p4, p3, p5
endin

instr GrainStabHighKnob
  gkGrainStabEqHigh linseg p4, p3, p5
endin

instr GrainStabFader
  gkGrainStabFader linseg p4, p3, p5
endin

instr GrainStabPan
  gkGrainStabPan linseg p4, p3, p5
endin

instr GrainStabMixerChannel
  aGrainStabL inleta "InL"
  aGrainStabR inleta "InR"

  aGrainStabL, aGrainStabR mixerChannel aGrainStabL, aGrainStabR, gkGrainStabFader, gkGrainStabPan, gkGrainStabEqBass, gkGrainStabEqMid, gkGrainStabEqHigh

  outleta "OutL", aGrainStabL
  outleta "OutR", aGrainStabR
endin
