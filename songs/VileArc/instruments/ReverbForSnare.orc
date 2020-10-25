alwayson "ReverbForSnareInput"
alwayson "ReverbForSnareMixerChannel"

gkReverbForSnareEqBass init 0
gkReverbForSnareEqMid init 1
gkReverbForSnareEqHigh init 1
gkReverbForSnareFader init 1
gkReverbForSnarePan init 50

giReverbForSnareMode init 3

gkReverbForSnareWetAmount init .3
gkReverbForSnareDryAmount init 1

bypassRoute "ReverbForSnare", "Mixer", "Mixer"

instr ReverbForSnareInput
  aReverbForSnareInL inleta "InL"
  aReverbForSnareInR inleta "InR"

  aReverbForSnareOutWetL, aReverbForSnareOutWetR, aReverbForSnareOutDryL, aReverbForSnareOutDryR bypassSwitch aReverbForSnareInL, aReverbForSnareInR, gkReverbForSnareDryAmount, gkReverbForSnareWetAmount, "ReverbForSnare"

  outleta "OutWetL", aReverbForSnareOutWetL
  outleta "OutWetR", aReverbForSnareOutWetR

  outleta "OutDryL", aReverbForSnareOutDryL
  outleta "OutDryR", aReverbForSnareOutDryR
endin

instr ReverbForSnare
  aReverbForSnareInL inleta "InL"
  aReverbForSnareInR inleta "InR"

  aReverbForSnareWetL = aReverbForSnareInL
  aReverbForSnareWetR = aReverbForSnareInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giReverbForSnareMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aReverbForSnareWetL alpass aReverbForSnareInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aReverbForSnareWetR alpass aReverbForSnareInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giReverbForSnareMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aReverbForSnareWetL reverb aReverbForSnareInL, kReverbTime, iSkip
    aReverbForSnareWetR reverb aReverbForSnareInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giReverbForSnareMode == 3 then
    kFeedbackLevel = 0.95
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aReverbForSnareWetL, aReverbForSnareWetR reverbsc aReverbForSnareInL, aReverbForSnareInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giReverbForSnareMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aReverbForSnareWetL, aReverbForSnareWetR freeverb aReverbForSnareInL, aReverbForSnareInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giReverbForSnareMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aReverbForSnareWetL pconvolve aReverbForSnareInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aReverbForSnareWetR pconvolve aReverbForSnareInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giReverbForSnareMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aReverbForSnareWetL convolve aReverbForSnareInL, SImpulseResponseFile, iChannelL
    aReverbForSnareWetR convolve aReverbForSnareInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giReverbForSnareMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aReverbForSnareWetL ftconv aReverbForSnareInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aReverbForSnareWetR ftconv aReverbForSnareInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
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
  if giReverbForSnareMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aReverbForSnareWetL nreverb aReverbForSnareInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aReverbForSnareWetR nreverb aReverbForSnareInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giReverbForSnareMode == 9 then
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

    aReverbForSnareWetLL, aReverbForSnareWetLR babo aReverbForSnareInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aReverbForSnareWetRL, aReverbForSnareWetRR babo aReverbForSnareInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aReverbForSnareWetL = aReverbForSnareWetLL + aReverbForSnareWetRL
    aReverbForSnareWetR = aReverbForSnareWetLR + aReverbForSnareWetRR
  endif

  aReverbForSnareL = aReverbForSnareWetL * madsr(0.01, 0.01, 1, .5)
  aReverbForSnareR = aReverbForSnareWetR * madsr(0.01, 0.01, 1, .5)

  outleta "OutL", aReverbForSnareL
  outleta "OutR", aReverbForSnareR
endin

instr ReverbForSnareWetKnob
  gkReverbForSnareWet linseg p4, p3, p5
endin

instr ReverbForSnareDryKnob
  gkReverbForSnareWet linseg p4, p3, p5
endin

instr ReverbForSnareBassKnob
  gkReverbForSnareEqBass linseg p4, p3, p5
endin

instr ReverbForSnareMidKnob
  gkReverbForSnareEqMid linseg p4, p3, p5
endin

instr ReverbForSnareHighKnob
  gkReverbForSnareEqHigh linseg p4, p3, p5
endin

instr ReverbForSnareFader
  gkReverbForSnareFader linseg p4, p3, p5
endin

instr ReverbForSnarePan
  gkReverbForSnarePan linseg p4, p3, p5
endin

instr ReverbForSnareMixerChannel
  aReverbForSnareL inleta "InL"
  aReverbForSnareR inleta "InR"

  aReverbForSnareL, aReverbForSnareR mixerChannel aReverbForSnareL, aReverbForSnareR, gkReverbForSnareFader, gkReverbForSnarePan, gkReverbForSnareEqBass, gkReverbForSnareEqMid, gkReverbForSnareEqHigh

  outleta "OutL", aReverbForSnareL
  outleta "OutR", aReverbForSnareR
endin
