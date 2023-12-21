instrumentRoute "MoltenGuitar", "Mixer"

gSMoltenGuitarSampleFilePath = "localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 1 SOLDANO 57.wav"
giMoltenGuitarNumberOfChannels filenchnls gSMoltenGuitarSampleFilePath
giMoltenGuitarSampleLength filelen gSMoltenGuitarSampleFilePath
giMoltenGuitarStartTime = 0
giMoltenGuitarEndTime = giMoltenGuitarSampleLength - giMoltenGuitarStartTime
giMoltenGuitarEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giMoltenGuitarSampleRate filesr gSMoltenGuitarSampleFilePath

if giMoltenGuitarNumberOfChannels == 2 then
  giMoltenGuitarSampleTableL ftgenonce 0, 0, 0, 1, gSMoltenGuitarSampleFilePath, giMoltenGuitarStartTime, 0, 1
  giMoltenGuitarSampleTableR ftgenonce 0, 0, 0, 1, gSMoltenGuitarSampleFilePath, giMoltenGuitarStartTime, 0, 2
else
  giMoltenGuitarSampleTable ftgenonce 0, 0, 0, 1, gSMoltenGuitarSampleFilePath, giMoltenGuitarStartTime, 0, 0
endif

instr MoltenGuitar
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
  kTimeStretch = .02000
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

  if giMoltenGuitarNumberOfChannels == 2 then
    aMoltenGuitarL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giMoltenGuitarEndTime, giMoltenGuitarSampleTableL, giMoltenGuitarEnvelopeTable, iMaxOverlaps

    aMoltenGuitarR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giMoltenGuitarEndTime, giMoltenGuitarSampleTableR, giMoltenGuitarEnvelopeTable, iMaxOverlaps

    aMoltenGuitarL = aMoltenGuitarL * kAmplitudeEnvelope
    aMoltenGuitarR = aMoltenGuitarR * kAmplitudeEnvelope
  else
    aMoltenGuitarL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giMoltenGuitarEndTime, giMoltenGuitarSampleTable, giMoltenGuitarEnvelopeTable, iMaxOverlaps
    aMoltenGuitarL *= kAmplitudeEnvelope

    aMoltenGuitarR = aMoltenGuitarL
  endif

  outleta "OutL", aMoltenGuitarL
  outleta "OutR", aMoltenGuitarR
endin

$MIXER_CHANNEL(MoltenGuitar)
