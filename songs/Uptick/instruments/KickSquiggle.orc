instrumentRoute "KickSquiggle", "Mixer"
alwayson "KickSquiggleMixerChannel"

gkKickSquiggleEqBass init 1
gkKickSquiggleEqMid init 1
gkKickSquiggleEqHigh init 1
gkKickSquiggleFader init 1
gkKickSquigglePan init 50

gSKickSquiggleSampleFilePath = "localSamples/CB_Kick.wav"
giKickSquiggleNumberOfChannels filenchnls gSKickSquiggleSampleFilePath
giKickSquiggleSampleLength filelen gSKickSquiggleSampleFilePath
giKickSquiggleStartTime = 0
giKickSquiggleEndTime = giKickSquiggleSampleLength - giKickSquiggleStartTime
giKickSquiggleEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giKickSquiggleSampleRate filesr gSKickSquiggleSampleFilePath

if giKickSquiggleNumberOfChannels == 2 then
  giKickSquiggleSampleTableL ftgenonce 0, 0, 0, 1, gSKickSquiggleSampleFilePath, giKickSquiggleStartTime, 0, 1
  giKickSquiggleSampleTableR ftgenonce 0, 0, 0, 1, gSKickSquiggleSampleFilePath, giKickSquiggleStartTime, 0, 2
else
  giKickSquiggleSampleTable ftgenonce 0, 0, 0, 1, gSKickSquiggleSampleFilePath, giKickSquiggleStartTime, 0, 0
endif

instr KickSquiggle
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.6
  ;Amplitude Envelope
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = .2
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude


  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  ; ;Grain Parameter Adjustments
  ; kTimeStretch = .01 + poscil(.04, 1.87) + poscil(.2, .3)
  ; kGrainSizeAdjustment = .3 ;+ poscil(.04, .87) + poscil(.2, .3)
  ; kGrainFrequencyAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
  ; kPitchAdjustment = 1 + poscil(.1, .1) * (1 + kPitchBend)
  ; kGrainOverlapPercentageAdjustment = 2+ poscil(.04, .87) + poscil(.2, .3)

  kOneLoop = linseg(0, giKickSquiggleSampleLength, 0, giKickSquiggleSampleLength, 1)


   ;Grain Parameter Adjustments
  kTimeStretch = 1 + (kOneLoop * .01 + (poscil(.04, 1.87) + poscil(.2, .3)))
  kGrainSizeAdjustment = 1 + (kOneLoop * .3)
  kGrainFrequencyAdjustment = 1 + (kOneLoop * .3)
  kPitchAdjustment = 1 + (kOneLoop * oscil(.09, .3))
  kGrainOverlapPercentageAdjustment = 1 + (kOneLoop*(2+ poscil(.04, .87) + poscil(.2, .3)))

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giKickSquiggleNumberOfChannels == 2 then
    aKickSquiggleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giKickSquiggleStartTime, giKickSquiggleEndTime, giKickSquiggleSampleTableL, giKickSquiggleEnvelopeTable, iMaxOverlaps
    aKickSquiggleR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giKickSquiggleStartTime, giKickSquiggleEndTime, giKickSquiggleSampleTableR, giKickSquiggleEnvelopeTable, iMaxOverlaps

    aKickSquiggleL = aKickSquiggleL * kAmplitudeEnvelope
    aKickSquiggleR = aKickSquiggleR * kAmplitudeEnvelope
  else
    aKickSquiggleL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giKickSquiggleStartTime, giKickSquiggleEndTime, giKickSquiggleSampleTable, giKickSquiggleEnvelopeTable, iMaxOverlaps
    aKickSquiggleL *= kAmplitudeEnvelope

    aKickSquiggleR = aKickSquiggleL
  endif

  outleta "OutL", aKickSquiggleL
  outleta "OutR", aKickSquiggleR
endin

instr KickSquiggleBassKnob
  gkKickSquiggleEqBass linseg p4, p3, p5
endin

instr KickSquiggleMidKnob
  gkKickSquiggleEqMid linseg p4, p3, p5
endin

instr KickSquiggleHighKnob
  gkKickSquiggleEqHigh linseg p4, p3, p5
endin

instr KickSquiggleFader
  gkKickSquiggleFader linseg p4, p3, p5
endin

instr KickSquigglePan
  gkKickSquigglePan linseg p4, p3, p5
endin

instr KickSquiggleMixerChannel
  aKickSquiggleL inleta "InL"
  aKickSquiggleR inleta "InR"

  aKickSquiggleL, aKickSquiggleR mixerChannel aKickSquiggleL, aKickSquiggleR, gkKickSquiggleFader, gkKickSquigglePan, gkKickSquiggleEqBass, gkKickSquiggleEqMid, gkKickSquiggleEqHigh

  outleta "OutL", aKickSquiggleL
  outleta "OutR", aKickSquiggleR
endin
