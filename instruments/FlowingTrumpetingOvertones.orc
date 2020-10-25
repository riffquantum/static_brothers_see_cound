instrumentRoute "FlowingTrumpetingOvertones", "DefaultEffectChain"
alwayson "FlowingTrumpetingOvertonesMixerChannel"

gkFlowingTrumpetingOvertonesEqBass init 1
gkFlowingTrumpetingOvertonesEqMid init 1
gkFlowingTrumpetingOvertonesEqHigh init 1
gkFlowingTrumpetingOvertonesFader init 1
gkFlowingTrumpetingOvertonesPan init 50

gSFlowingTrumpetingOvertonesSampleFilePath = "localSamples/Roy Orbison - Blue Angel/blueangel5.wav"
giFlowingTrumpetingOvertonesNumberOfChannels filenchnls gSFlowingTrumpetingOvertonesSampleFilePath
giFlowingTrumpetingOvertonesSampleLength filelen gSFlowingTrumpetingOvertonesSampleFilePath
giFlowingTrumpetingOvertonesStartTime = 0
giFlowingTrumpetingOvertonesEndTime = giFlowingTrumpetingOvertonesSampleLength - giFlowingTrumpetingOvertonesStartTime
giFlowingTrumpetingOvertonesEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
giFlowingTrumpetingOvertonesSampleRate filesr gSFlowingTrumpetingOvertonesSampleFilePath

if giFlowingTrumpetingOvertonesNumberOfChannels == 2 then
  giFlowingTrumpetingOvertonesSampleTableL ftgenonce 0, 0, 0, 1, gSFlowingTrumpetingOvertonesSampleFilePath, giFlowingTrumpetingOvertonesStartTime, 0, 1
  giFlowingTrumpetingOvertonesSampleTableR ftgenonce 0, 0, 0, 1, gSFlowingTrumpetingOvertonesSampleFilePath, giFlowingTrumpetingOvertonesStartTime, 0, 2
else
  giFlowingTrumpetingOvertonesSampleTable ftgenonce 0, 0, 0, 1, gSFlowingTrumpetingOvertonesSampleFilePath, giFlowingTrumpetingOvertonesStartTime, 0, 0
endif

instr FlowingTrumpetingOvertones
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

  if giFlowingTrumpetingOvertonesNumberOfChannels == 2 then
    aFlowingTrumpetingOvertonesL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giFlowingTrumpetingOvertonesEndTime, giFlowingTrumpetingOvertonesSampleTableL, giFlowingTrumpetingOvertonesEnvelopeTable, iMaxOverlaps

    aFlowingTrumpetingOvertonesR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giFlowingTrumpetingOvertonesEndTime, giFlowingTrumpetingOvertonesSampleTableR, giFlowingTrumpetingOvertonesEnvelopeTable, iMaxOverlaps

    aFlowingTrumpetingOvertonesL = aFlowingTrumpetingOvertonesL * kAmplitudeEnvelope
    aFlowingTrumpetingOvertonesR = aFlowingTrumpetingOvertonesR * kAmplitudeEnvelope
  else
    aFlowingTrumpetingOvertonesL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giFlowingTrumpetingOvertonesEndTime, giFlowingTrumpetingOvertonesSampleTable, giFlowingTrumpetingOvertonesEnvelopeTable, iMaxOverlaps
    aFlowingTrumpetingOvertonesL *= kAmplitudeEnvelope

    aFlowingTrumpetingOvertonesR = aFlowingTrumpetingOvertonesL
  endif

  outleta "OutL", aFlowingTrumpetingOvertonesL
  outleta "OutR", aFlowingTrumpetingOvertonesR
endin

instr FlowingTrumpetingOvertonesBassKnob
  gkFlowingTrumpetingOvertonesEqBass linseg p4, p3, p5
endin

instr FlowingTrumpetingOvertonesMidKnob
  gkFlowingTrumpetingOvertonesEqMid linseg p4, p3, p5
endin

instr FlowingTrumpetingOvertonesHighKnob
  gkFlowingTrumpetingOvertonesEqHigh linseg p4, p3, p5
endin

instr FlowingTrumpetingOvertonesFader
  gkFlowingTrumpetingOvertonesFader linseg p4, p3, p5
endin

instr FlowingTrumpetingOvertonesPan
  gkFlowingTrumpetingOvertonesPan linseg p4, p3, p5
endin

instr FlowingTrumpetingOvertonesMixerChannel
  aFlowingTrumpetingOvertonesL inleta "InL"
  aFlowingTrumpetingOvertonesR inleta "InR"

  aFlowingTrumpetingOvertonesL, aFlowingTrumpetingOvertonesR mixerChannel aFlowingTrumpetingOvertonesL, aFlowingTrumpetingOvertonesR, gkFlowingTrumpetingOvertonesFader, gkFlowingTrumpetingOvertonesPan, gkFlowingTrumpetingOvertonesEqBass, gkFlowingTrumpetingOvertonesEqMid, gkFlowingTrumpetingOvertonesEqHigh

  outleta "OutL", aFlowingTrumpetingOvertonesL
  outleta "OutR", aFlowingTrumpetingOvertonesR
endin
