instrumentRoute "TwistedUpKickExample", "Mixer"
alwayson "TwistedUpKickExampleMixerChannel"

gkTwistedUpKickExampleEqBass init 1
gkTwistedUpKickExampleEqMid init 1
gkTwistedUpKickExampleEqHigh init 1
gkTwistedUpKickExampleFader init 1
gkTwistedUpKickExamplePan init 50

gSTwistedUpKickExampleSampleFilePath = "localSamples/CB_Kick.wav"
giTwistedUpKickExampleNumberOfChannels filenchnls gSTwistedUpKickExampleSampleFilePath
giTwistedUpKickExampleSampleLength filelen gSTwistedUpKickExampleSampleFilePath
giTwistedUpKickExampleStartTime = 0
giTwistedUpKickExampleEndTime = giTwistedUpKickExampleSampleLength - giTwistedUpKickExampleStartTime
giTwistedUpKickExampleEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giTwistedUpKickExampleSampleRate filesr gSTwistedUpKickExampleSampleFilePath

if giTwistedUpKickExampleNumberOfChannels == 2 then
  giTwistedUpKickExampleSampleTableL ftgenonce 0, 0, 0, 1, gSTwistedUpKickExampleSampleFilePath, giTwistedUpKickExampleStartTime, 0, 1
  giTwistedUpKickExampleSampleTableR ftgenonce 0, 0, 0, 1, gSTwistedUpKickExampleSampleFilePath, giTwistedUpKickExampleStartTime, 0, 2
else
  giTwistedUpKickExampleSampleTable ftgenonce 0, 0, 0, 1, gSTwistedUpKickExampleSampleFilePath, giTwistedUpKickExampleStartTime, 0, 0
endif

instr TwistedUpKickExample
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
  kPitchAdjustment = 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 2+ poscil(.04, .87) + poscil(.2, .3)

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giTwistedUpKickExampleNumberOfChannels == 2 then
    aTwistedUpKickExampleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giTwistedUpKickExampleStartTime, giTwistedUpKickExampleEndTime, giTwistedUpKickExampleSampleTableL, giTwistedUpKickExampleEnvelopeTable, iMaxOverlaps
    aTwistedUpKickExampleR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giTwistedUpKickExampleStartTime, giTwistedUpKickExampleEndTime, giTwistedUpKickExampleSampleTableR, giTwistedUpKickExampleEnvelopeTable, iMaxOverlaps

    aTwistedUpKickExampleL = aTwistedUpKickExampleL * kAmplitudeEnvelope
    aTwistedUpKickExampleR = aTwistedUpKickExampleR * kAmplitudeEnvelope
  else
    aTwistedUpKickExampleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giTwistedUpKickExampleStartTime, giTwistedUpKickExampleEndTime, giTwistedUpKickExampleSampleTable, giTwistedUpKickExampleEnvelopeTable, iMaxOverlaps

    aTwistedUpKickExampleR = aTwistedUpKickExampleR * kAmplitudeEnvelope

    aTwistedUpKickExampleR = aTwistedUpKickExampleL
  endif

  outleta "OutL", aTwistedUpKickExampleL
  outleta "OutR", aTwistedUpKickExampleR
endin

instr TwistedUpKickExampleBassKnob
  gkTwistedUpKickExampleEqBass linseg p4, p3, p5
endin

instr TwistedUpKickExampleMidKnob
  gkTwistedUpKickExampleEqMid linseg p4, p3, p5
endin

instr TwistedUpKickExampleHighKnob
  gkTwistedUpKickExampleEqHigh linseg p4, p3, p5
endin

instr TwistedUpKickExampleFader
  gkTwistedUpKickExampleFader linseg p4, p3, p5
endin

instr TwistedUpKickExamplePan
  gkTwistedUpKickExamplePan linseg p4, p3, p5
endin

instr TwistedUpKickExampleMixerChannel
  aTwistedUpKickExampleL inleta "InL"
  aTwistedUpKickExampleR inleta "InR"

  aTwistedUpKickExampleL, aTwistedUpKickExampleR mixerChannel aTwistedUpKickExampleL, aTwistedUpKickExampleR, gkTwistedUpKickExampleFader, gkTwistedUpKickExamplePan, gkTwistedUpKickExampleEqBass, gkTwistedUpKickExampleEqMid, gkTwistedUpKickExampleEqHigh

  outleta "OutL", aTwistedUpKickExampleL
  outleta "OutR", aTwistedUpKickExampleR
endin
