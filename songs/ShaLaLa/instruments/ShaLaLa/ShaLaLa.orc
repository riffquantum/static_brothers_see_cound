instrumentRoute "ShaLaLa", "RingModInput"
alwayson "ShaLaLaMixerChannel"

gkShaLaLaEqBass init 1
gkShaLaLaEqMid init 1
gkShaLaLaEqHigh init 1
gkShaLaLaFader init 1
gkShaLaLaPan init 50

gSShaLaLaSampleFilePath = "localSamples/blueangel5.wav"
giShaLaLaNumberOfChannels filenchnls gSShaLaLaSampleFilePath
giShaLaLaSampleLength filelen gSShaLaLaSampleFilePath
giShaLaLaStartTime = 0
giShaLaLaEndTime = giShaLaLaSampleLength - giShaLaLaStartTime
giShaLaLaEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giShaLaLaSampleRate filesr gSShaLaLaSampleFilePath

if giShaLaLaNumberOfChannels == 2 then
  giShaLaLaSampleTableL ftgenonce 0, 0, 0, 1, gSShaLaLaSampleFilePath, giShaLaLaStartTime, 0, 1
  giShaLaLaSampleTableR ftgenonce 0, 0, 0, 1, gSShaLaLaSampleFilePath, giShaLaLaStartTime, 0, 2
else
  giShaLaLaSampleTable ftgenonce 0, 0, 0, 1, gSShaLaLaSampleFilePath, giShaLaLaStartTime, 0, 0
endif

instr ShaLaLa
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
  kTimeStretch = 2
  kGrainSizeAdjustment = .14  + poscil(.005, .01)
  kGrainFrequencyAdjustment = 1 + poscil(.1, .01)
  kPitchAdjustment = 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 1

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giShaLaLaNumberOfChannels == 2 then
    aShaLaLaL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giShaLaLaEndTime, giShaLaLaSampleTableL, giShaLaLaEnvelopeTable, iMaxOverlaps

    aShaLaLaR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giShaLaLaEndTime, giShaLaLaSampleTableR, giShaLaLaEnvelopeTable, iMaxOverlaps

    aShaLaLaL = aShaLaLaL * kAmplitudeEnvelope
    aShaLaLaR = aShaLaLaR * kAmplitudeEnvelope
  else
    aShaLaLaL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giShaLaLaEndTime, giShaLaLaSampleTable, giShaLaLaEnvelopeTable, iMaxOverlaps

    aShaLaLaR = aShaLaLaR * kAmplitudeEnvelope

    aShaLaLaR = aShaLaLaL
  endif

  outleta "OutL", aShaLaLaL
  outleta "OutR", aShaLaLaR
endin

instr ShaLaLaBassKnob
  gkShaLaLaEqBass linseg p4, p3, p5
endin

instr ShaLaLaMidKnob
  gkShaLaLaEqMid linseg p4, p3, p5
endin

instr ShaLaLaHighKnob
  gkShaLaLaEqHigh linseg p4, p3, p5
endin

instr ShaLaLaFader
  gkShaLaLaFader linseg p4, p3, p5
endin

instr ShaLaLaPan
  gkShaLaLaPan linseg p4, p3, p5
endin

instr ShaLaLaMixerChannel
  aShaLaLaL inleta "InL"
  aShaLaLaR inleta "InR"

  aShaLaLaL, aShaLaLaR mixerChannel aShaLaLaL, aShaLaLaR, gkShaLaLaFader, gkShaLaLaPan, gkShaLaLaEqBass, gkShaLaLaEqMid, gkShaLaLaEqHigh

  outleta "OutL", aShaLaLaL
  outleta "OutR", aShaLaLaR
endin
