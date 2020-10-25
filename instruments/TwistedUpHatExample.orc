instrumentRoute "TwistedUpHatExample", "Mixer"
alwayson "TwistedUpHatExampleMixerChannel"

gkTwistedUpHatExampleEqBass init 1
gkTwistedUpHatExampleEqMid init 1
gkTwistedUpHatExampleEqHigh init 1
gkTwistedUpHatExampleFader init 1
gkTwistedUpHatExamplePan init 50

gSTwistedUpHatExampleSampleFilePath = "localSamples/Drums/Beatbox-Drums_Closed-Hat_EA7544.wav"
giTwistedUpHatExampleNumberOfChannels filenchnls gSTwistedUpHatExampleSampleFilePath
giTwistedUpHatExampleSampleLength filelen gSTwistedUpHatExampleSampleFilePath
giTwistedUpHatExampleStartTime = 0
giTwistedUpHatExampleEndTime = giTwistedUpHatExampleSampleLength - giTwistedUpHatExampleStartTime
giTwistedUpHatExampleEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giTwistedUpHatExampleSampleRate filesr gSTwistedUpHatExampleSampleFilePath

if giTwistedUpHatExampleNumberOfChannels == 2 then
  giTwistedUpHatExampleSampleTableL ftgenonce 0, 0, 0, 1, gSTwistedUpHatExampleSampleFilePath, giTwistedUpHatExampleStartTime, 0, 1
  giTwistedUpHatExampleSampleTableR ftgenonce 0, 0, 0, 1, gSTwistedUpHatExampleSampleFilePath, giTwistedUpHatExampleStartTime, 0, 2
else
  giTwistedUpHatExampleSampleTable ftgenonce 0, 0, 0, 1, gSTwistedUpHatExampleSampleFilePath, giTwistedUpHatExampleStartTime, 0, 0
endif

instr TwistedUpHatExample
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
  kPitchAdjustment = 1 + poscil(.01, .5) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 2+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giTwistedUpHatExampleNumberOfChannels == 2 then
    aTwistedUpHatExampleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giTwistedUpHatExampleStartTime, giTwistedUpHatExampleEndTime, giTwistedUpHatExampleSampleTableL, giTwistedUpHatExampleEnvelopeTable, iMaxOverlaps
    aTwistedUpHatExampleR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giTwistedUpHatExampleStartTime, giTwistedUpHatExampleEndTime, giTwistedUpHatExampleSampleTableR, giTwistedUpHatExampleEnvelopeTable, iMaxOverlaps

    aTwistedUpHatExampleL = aTwistedUpHatExampleL * kAmplitudeEnvelope
    aTwistedUpHatExampleR = aTwistedUpHatExampleR * kAmplitudeEnvelope
  else
    aTwistedUpHatExampleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giTwistedUpHatExampleStartTime, giTwistedUpHatExampleEndTime, giTwistedUpHatExampleSampleTable, giTwistedUpHatExampleEnvelopeTable, iMaxOverlaps
    aTwistedUpHatExampleL *= kAmplitudeEnvelope

    aTwistedUpHatExampleR = aTwistedUpHatExampleL
  endif

  outleta "OutL", aTwistedUpHatExampleL
  outleta "OutR", aTwistedUpHatExampleR
endin

instr TwistedUpHatExampleBassKnob
  gkTwistedUpHatExampleEqBass linseg p4, p3, p5
endin

instr TwistedUpHatExampleMidKnob
  gkTwistedUpHatExampleEqMid linseg p4, p3, p5
endin

instr TwistedUpHatExampleHighKnob
  gkTwistedUpHatExampleEqHigh linseg p4, p3, p5
endin

instr TwistedUpHatExampleFader
  gkTwistedUpHatExampleFader linseg p4, p3, p5
endin

instr TwistedUpHatExamplePan
  gkTwistedUpHatExamplePan linseg p4, p3, p5
endin

instr TwistedUpHatExampleMixerChannel
  aTwistedUpHatExampleL inleta "InL"
  aTwistedUpHatExampleR inleta "InR"

  aTwistedUpHatExampleL, aTwistedUpHatExampleR mixerChannel aTwistedUpHatExampleL, aTwistedUpHatExampleR, gkTwistedUpHatExampleFader, gkTwistedUpHatExamplePan, gkTwistedUpHatExampleEqBass, gkTwistedUpHatExampleEqMid, gkTwistedUpHatExampleEqHigh

  outleta "OutL", aTwistedUpHatExampleL
  outleta "OutR", aTwistedUpHatExampleR
endin
