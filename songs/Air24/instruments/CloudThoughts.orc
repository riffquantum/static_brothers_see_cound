instrumentRoute "CloudThoughts", "DefaultEffectChain"
alwayson "CloudThoughtsMixerChannel"

gkCloudThoughtsEqBass init 1
gkCloudThoughtsEqMid init 1
gkCloudThoughtsEqHigh init 1
gkCloudThoughtsFader init 1
gkCloudThoughtsPan init 50

gSCloudThoughtsSampleFilePath = "localSamples/windDemonLoop1.wav"
giCloudThoughtsNumberOfChannels filenchnls gSCloudThoughtsSampleFilePath
giCloudThoughtsSampleLength filelen gSCloudThoughtsSampleFilePath
giCloudThoughtsStartTime = 0
giCloudThoughtsEndTime = giCloudThoughtsSampleLength - giCloudThoughtsStartTime
giCloudThoughtsEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giCloudThoughtsSampleRate filesr gSCloudThoughtsSampleFilePath

if giCloudThoughtsNumberOfChannels == 2 then
  giCloudThoughtsSampleTableL ftgenonce 0, 0, 0, 1, gSCloudThoughtsSampleFilePath, giCloudThoughtsStartTime, 0, 1
  giCloudThoughtsSampleTableR ftgenonce 0, 0, 0, 1, gSCloudThoughtsSampleFilePath, giCloudThoughtsStartTime, 0, 2
else
  giCloudThoughtsSampleTable ftgenonce 0, 0, 0, 1, gSCloudThoughtsSampleFilePath, giCloudThoughtsStartTime, 0, 0
endif

gkCloudThoughtsTimeStretch init 1
gkCloudThoughtsGrainSizeAdjustment init 1
gkCloudThoughtsGrainFrequencyAdjustment init 1
gkCloudThoughtsPitchAdjustment init 1
gkCloudThoughtsGrainOverlapPercentageAdjustment init 1

instr CloudThoughts
  ;p fields
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)
  kPitch = iPitch / 261.626

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

  ;Grain Parameter Adjustments - Set these all to 1 for basic functionality
  kTimeStretch *= .1 ;- poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment *= 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment *= 1 ;+ poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment *= 1 ;+ poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment *= 1 ; + poscil(.04, .87) + poscil(.2, .3)

  ;Global Variables for K Rate Changes
  kTimeStretch *= gkCloudThoughtsTimeStretch
  kGrainSizeAdjustment *= gkCloudThoughtsGrainSizeAdjustment
  kGrainFrequencyAdjustment *= gkCloudThoughtsGrainFrequencyAdjustment
  kPitchAdjustment *= gkCloudThoughtsPitchAdjustment
  kGrainOverlapPercentageAdjustment *= gkCloudThoughtsGrainOverlapPercentageAdjustment

  ;Base settings for Granulizer
  kPitch *= kPitchAdjustment
  kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
  kGrainSize = .1 * kGrainSizeAdjustment
  kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
  kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
  iMaxOverlaps = 1000

  if giCloudThoughtsNumberOfChannels == 2 then
    aCloudThoughtsL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giCloudThoughtsStartTime, giCloudThoughtsEndTime, giCloudThoughtsSampleTableL, giCloudThoughtsEnvelopeTable, iMaxOverlaps
    aCloudThoughtsR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giCloudThoughtsStartTime, giCloudThoughtsEndTime, giCloudThoughtsSampleTableR, giCloudThoughtsEnvelopeTable, iMaxOverlaps

    aCloudThoughtsL = aCloudThoughtsL * kAmplitudeEnvelope
    aCloudThoughtsR = aCloudThoughtsR * kAmplitudeEnvelope
  else
    aCloudThoughtsL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, giCloudThoughtsStartTime, giCloudThoughtsEndTime, giCloudThoughtsSampleTable, giCloudThoughtsEnvelopeTable, iMaxOverlaps
    aCloudThoughtsL *= kAmplitudeEnvelope

    aCloudThoughtsR = aCloudThoughtsL
  endif

  outleta "OutL", aCloudThoughtsL
  outleta "OutR", aCloudThoughtsR
endin

instr CloudThoughtsBassKnob
  gkCloudThoughtsEqBass linseg p4, p3, p5
endin

instr CloudThoughtsMidKnob
  gkCloudThoughtsEqMid linseg p4, p3, p5
endin

instr CloudThoughtsHighKnob
  gkCloudThoughtsEqHigh linseg p4, p3, p5
endin

instr CloudThoughtsFader
  gkCloudThoughtsFader linseg p4, p3, p5
endin

instr CloudThoughtsPan
  gkCloudThoughtsPan linseg p4, p3, p5
endin

instr CloudThoughtsMixerChannel
  aCloudThoughtsL inleta "InL"
  aCloudThoughtsR inleta "InR"

  aCloudThoughtsL, aCloudThoughtsR mixerChannel aCloudThoughtsL, aCloudThoughtsR, gkCloudThoughtsFader, gkCloudThoughtsPan, gkCloudThoughtsEqBass, gkCloudThoughtsEqMid, gkCloudThoughtsEqHigh

  outleta "OutL", aCloudThoughtsL
  outleta "OutR", aCloudThoughtsR
endin
