alwayson "DefaultEffectChainReverbInput"
alwayson "DefaultEffectChainReverbMixerChannel"

gkDefaultEffectChainReverbEqBass init 1
gkDefaultEffectChainReverbEqMid init 1
gkDefaultEffectChainReverbEqHigh init 1
gkDefaultEffectChainReverbFader init 1
gkDefaultEffectChainReverbPan init 50

giDefaultEffectChainReverbMode init 3

gkDefaultEffectChainReverbWetAmmount init .3
gkDefaultEffectChainReverbDryAmmount init 1

bypassRoute "DefaultEffectChainReverb", "Mixer", "Mixer"

instr DefaultEffectChainReverbInput
  aDefaultEffectChainReverbInL inleta "InL"
  aDefaultEffectChainReverbInR inleta "InR"

  aDefaultEffectChainReverbOutWetL, aDefaultEffectChainReverbOutWetR, aDefaultEffectChainReverbOutDryL, aDefaultEffectChainReverbOutDryR bypassSwitch aDefaultEffectChainReverbInL, aDefaultEffectChainReverbInR, gkDefaultEffectChainReverbDryAmmount, gkDefaultEffectChainReverbWetAmmount, "DefaultEffectChainReverb"

  outleta "OutWetL", aDefaultEffectChainReverbOutWetL
  outleta "OutWetR", aDefaultEffectChainReverbOutWetR

  outleta "OutDryL", aDefaultEffectChainReverbOutDryL
  outleta "OutDryR", aDefaultEffectChainReverbOutDryR
endin

instr DefaultEffectChainReverb
  aDefaultEffectChainReverbInL inleta "InL"
  aDefaultEffectChainReverbInR inleta "InR"

  aDefaultEffectChainReverbWetL = aDefaultEffectChainReverbInL
  aDefaultEffectChainReverbWetR = aDefaultEffectChainReverbInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giDefaultEffectChainReverbMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aDefaultEffectChainReverbWetL alpass aDefaultEffectChainReverbInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aDefaultEffectChainReverbWetR alpass aDefaultEffectChainReverbInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giDefaultEffectChainReverbMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aDefaultEffectChainReverbWetL reverb aDefaultEffectChainReverbInL, kReverbTime, iSkip
    aDefaultEffectChainReverbWetR reverb aDefaultEffectChainReverbInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giDefaultEffectChainReverbMode == 3 then
    kFeedbackLevel = 0.95
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aDefaultEffectChainReverbWetL, aDefaultEffectChainReverbWetR reverbsc aDefaultEffectChainReverbInL, aDefaultEffectChainReverbInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giDefaultEffectChainReverbMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aDefaultEffectChainReverbWetL, aDefaultEffectChainReverbWetR freeverb aDefaultEffectChainReverbInL, aDefaultEffectChainReverbInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giDefaultEffectChainReverbMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aDefaultEffectChainReverbWetL pconvolve aDefaultEffectChainReverbInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aDefaultEffectChainReverbWetR pconvolve aDefaultEffectChainReverbInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giDefaultEffectChainReverbMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aDefaultEffectChainReverbWetL convolve aDefaultEffectChainReverbInL, SImpulseResponseFile, iChannelL
    aDefaultEffectChainReverbWetR convolve aDefaultEffectChainReverbInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giDefaultEffectChainReverbMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aDefaultEffectChainReverbWetL ftconv aDefaultEffectChainReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aDefaultEffectChainReverbWetR ftconv aDefaultEffectChainReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
  endif

  /* ********
      hrtfreverb
     ********

     to do: https://csound.com/docs/manual/hrtfearly.html
  */

  /* ********
      nreverb
     ********
  */
  if giDefaultEffectChainReverbMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aDefaultEffectChainReverbWetL nreverb aDefaultEffectChainReverbInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aDefaultEffectChainReverbWetR nreverb aDefaultEffectChainReverbInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giDefaultEffectChainReverbMode == 9 then
    iXLength = 14.39
    iYLength = 11.86
    iZLength = 10
    kXSourcePosition = 4
    kYSourcePosition = 6
    kZSourcePosition = 4

    iDiffusion = 1

    iDecay = .99
    iHighFrequencyDecay = 0.95
    iXReceiverPosition = 0
    iYReceiverPosition = 0
    iZReceiverPosition = 0
    iReceiverStereoDistance = 0.3
    iDirectSignalAttenuation = 0.9
    iEarlyAttenuation = 0.9

    iReverbParams ftgenonce 1001, 0, 0, -2, iDecay, iHighFrequencyDecay, iXReceiverPosition, iYReceiverPosition, iZReceiverPosition, iReceiverStereoDistance, iDirectSignalAttenuation, iEarlyAttenuation

    aDefaultEffectChainReverbWetLL, aDefaultEffectChainReverbWetLR babo aDefaultEffectChainReverbInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aDefaultEffectChainReverbWetRL, aDefaultEffectChainReverbWetRR babo aDefaultEffectChainReverbInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aDefaultEffectChainReverbWetL = aDefaultEffectChainReverbWetLL + aDefaultEffectChainReverbWetRL
    aDefaultEffectChainReverbWetR = aDefaultEffectChainReverbWetLR + aDefaultEffectChainReverbWetRR
  endif

  aDefaultEffectChainReverbL = aDefaultEffectChainReverbWetL
  aDefaultEffectChainReverbR = aDefaultEffectChainReverbWetR

  outleta "OutL", aDefaultEffectChainReverbL
  outleta "OutR", aDefaultEffectChainReverbR
endin

instr DefaultEffectChainReverbWetKnob
  gkDefaultEffectChainReverbWet linseg p4, p3, p5
endin

instr DefaultEffectChainReverbDryKnob
  gkDefaultEffectChainReverbWet linseg p4, p3, p5
endin

instr DefaultEffectChainReverbBassKnob
  gkDefaultEffectChainReverbEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainReverbMidKnob
  gkDefaultEffectChainReverbEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainReverbHighKnob
  gkDefaultEffectChainReverbEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainReverbFader
  gkDefaultEffectChainReverbFader linseg p4, p3, p5
endin

instr DefaultEffectChainReverbPan
  gkDefaultEffectChainReverbPan linseg p4, p3, p5
endin

instr DefaultEffectChainReverbMixerChannel
  aDefaultEffectChainReverbL inleta "InL"
  aDefaultEffectChainReverbR inleta "InR"

  aDefaultEffectChainReverbL, aDefaultEffectChainReverbR mixerChannel aDefaultEffectChainReverbL, aDefaultEffectChainReverbR, gkDefaultEffectChainReverbFader, gkDefaultEffectChainReverbPan, gkDefaultEffectChainReverbEqBass, gkDefaultEffectChainReverbEqMid, gkDefaultEffectChainReverbEqHigh

  outleta "OutL", aDefaultEffectChainReverbL
  outleta "OutR", aDefaultEffectChainReverbR
endin
