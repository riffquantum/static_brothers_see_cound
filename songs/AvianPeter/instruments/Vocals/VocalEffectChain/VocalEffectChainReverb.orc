alwayson "VocalEffectChainReverbInput"
alwayson "VocalEffectChainReverbMixerChannel"

gkVocalEffectChainReverbEqBass init 1
gkVocalEffectChainReverbEqMid init 1
gkVocalEffectChainReverbEqHigh init 1
gkVocalEffectChainReverbFader init 1
gkVocalEffectChainReverbPan init 50

giVocalEffectChainReverbMode init 3

gkVocalEffectChainReverbWetAmount init .3
gkVocalEffectChainReverbDryAmount init 1

bypassRoute "VocalEffectChainReverb", "VocalEffectChainMixerChannel", "VocalEffectChainMixerChannel"

instr VocalEffectChainReverbInput
  aVocalEffectChainReverbInL inleta "InL"
  aVocalEffectChainReverbInR inleta "InR"

  aVocalEffectChainReverbOutWetL, aVocalEffectChainReverbOutWetR, aVocalEffectChainReverbOutDryL, aVocalEffectChainReverbOutDryR bypassSwitch aVocalEffectChainReverbInL, aVocalEffectChainReverbInR, gkVocalEffectChainReverbDryAmount, gkVocalEffectChainReverbWetAmount, "VocalEffectChainReverb"

  outleta "OutWetL", aVocalEffectChainReverbOutWetL
  outleta "OutWetR", aVocalEffectChainReverbOutWetR

  outleta "OutDryL", aVocalEffectChainReverbOutDryL
  outleta "OutDryR", aVocalEffectChainReverbOutDryR
endin

instr VocalEffectChainReverb
  aVocalEffectChainReverbInL inleta "InL"
  aVocalEffectChainReverbInR inleta "InR"

  aVocalEffectChainReverbWetL = aVocalEffectChainReverbInL
  aVocalEffectChainReverbWetR = aVocalEffectChainReverbInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giVocalEffectChainReverbMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aVocalEffectChainReverbWetL alpass aVocalEffectChainReverbInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aVocalEffectChainReverbWetR alpass aVocalEffectChainReverbInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giVocalEffectChainReverbMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aVocalEffectChainReverbWetL reverb aVocalEffectChainReverbInL, kReverbTime, iSkip
    aVocalEffectChainReverbWetR reverb aVocalEffectChainReverbInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giVocalEffectChainReverbMode == 3 then
    kFeedbackLevel = 0.95
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aVocalEffectChainReverbWetL, aVocalEffectChainReverbWetR reverbsc aVocalEffectChainReverbInL, aVocalEffectChainReverbInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giVocalEffectChainReverbMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aVocalEffectChainReverbWetL, aVocalEffectChainReverbWetR freeverb aVocalEffectChainReverbInL, aVocalEffectChainReverbInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giVocalEffectChainReverbMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aVocalEffectChainReverbWetL pconvolve aVocalEffectChainReverbInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aVocalEffectChainReverbWetR pconvolve aVocalEffectChainReverbInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giVocalEffectChainReverbMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aVocalEffectChainReverbWetL convolve aVocalEffectChainReverbInL, SImpulseResponseFile, iChannelL
    aVocalEffectChainReverbWetR convolve aVocalEffectChainReverbInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giVocalEffectChainReverbMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aVocalEffectChainReverbWetL ftconv aVocalEffectChainReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aVocalEffectChainReverbWetR ftconv aVocalEffectChainReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
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
  if giVocalEffectChainReverbMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aVocalEffectChainReverbWetL nreverb aVocalEffectChainReverbInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aVocalEffectChainReverbWetR nreverb aVocalEffectChainReverbInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giVocalEffectChainReverbMode == 9 then
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

    aVocalEffectChainReverbWetLL, aVocalEffectChainReverbWetLR babo aVocalEffectChainReverbInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aVocalEffectChainReverbWetRL, aVocalEffectChainReverbWetRR babo aVocalEffectChainReverbInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aVocalEffectChainReverbWetL = aVocalEffectChainReverbWetLL + aVocalEffectChainReverbWetRL
    aVocalEffectChainReverbWetR = aVocalEffectChainReverbWetLR + aVocalEffectChainReverbWetRR
  endif

  aVocalEffectChainReverbL = aVocalEffectChainReverbWetL * madsr(0.01, 0.01, 1, .5)
  aVocalEffectChainReverbR = aVocalEffectChainReverbWetR * madsr(0.01, 0.01, 1, .5)

  outleta "OutL", aVocalEffectChainReverbL
  outleta "OutR", aVocalEffectChainReverbR
endin

instr VocalEffectChainReverbWetKnob
  gkVocalEffectChainReverbWet linseg p4, p3, p5
endin

instr VocalEffectChainReverbDryKnob
  gkVocalEffectChainReverbWet linseg p4, p3, p5
endin

instr VocalEffectChainReverbBassKnob
  gkVocalEffectChainReverbEqBass linseg p4, p3, p5
endin

instr VocalEffectChainReverbMidKnob
  gkVocalEffectChainReverbEqMid linseg p4, p3, p5
endin

instr VocalEffectChainReverbHighKnob
  gkVocalEffectChainReverbEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainReverbFader
  gkVocalEffectChainReverbFader linseg p4, p3, p5
endin

instr VocalEffectChainReverbPan
  gkVocalEffectChainReverbPan linseg p4, p3, p5
endin

instr VocalEffectChainReverbMixerChannel
  aVocalEffectChainReverbL inleta "InL"
  aVocalEffectChainReverbR inleta "InR"

  aVocalEffectChainReverbL, aVocalEffectChainReverbR mixerChannel aVocalEffectChainReverbL, aVocalEffectChainReverbR, gkVocalEffectChainReverbFader, gkVocalEffectChainReverbPan, gkVocalEffectChainReverbEqBass, gkVocalEffectChainReverbEqMid, gkVocalEffectChainReverbEqHigh

  outleta "OutL", aVocalEffectChainReverbL
  outleta "OutR", aVocalEffectChainReverbR
endin
