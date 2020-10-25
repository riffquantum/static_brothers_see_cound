alwayson "ReverbForGrainStabInput"
alwayson "ReverbForGrainStabMixerChannel"

gkReverbForGrainStabEqBass init 1
gkReverbForGrainStabEqMid init 1
gkReverbForGrainStabEqHigh init 1
gkReverbForGrainStabFader init 1
gkReverbForGrainStabPan init 50

giReverbForGrainStabMode init 3

gkReverbForGrainStabWetAmount init .3
gkReverbForGrainStabDryAmount init 1

bypassRoute "ReverbForGrainStab", "Mixer", "Mixer"

instr ReverbForGrainStabInput
  aReverbForGrainStabInL inleta "InL"
  aReverbForGrainStabInR inleta "InR"

  aReverbForGrainStabOutWetL, aReverbForGrainStabOutWetR, aReverbForGrainStabOutDryL, aReverbForGrainStabOutDryR bypassSwitch aReverbForGrainStabInL, aReverbForGrainStabInR, gkReverbForGrainStabDryAmount, gkReverbForGrainStabWetAmount, "ReverbForGrainStab"

  outleta "OutWetL", aReverbForGrainStabOutWetL
  outleta "OutWetR", aReverbForGrainStabOutWetR

  outleta "OutDryL", aReverbForGrainStabOutDryL
  outleta "OutDryR", aReverbForGrainStabOutDryR
endin

instr ReverbForGrainStab
  aReverbForGrainStabInL inleta "InL"
  aReverbForGrainStabInR inleta "InR"

  aReverbForGrainStabWetL = aReverbForGrainStabInL
  aReverbForGrainStabWetR = aReverbForGrainStabInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giReverbForGrainStabMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aReverbForGrainStabWetL alpass aReverbForGrainStabInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aReverbForGrainStabWetR alpass aReverbForGrainStabInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giReverbForGrainStabMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aReverbForGrainStabWetL reverb aReverbForGrainStabInL, kReverbTime, iSkip
    aReverbForGrainStabWetR reverb aReverbForGrainStabInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giReverbForGrainStabMode == 3 then
    kFeedbackLevel = 0.95
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aReverbForGrainStabWetL, aReverbForGrainStabWetR reverbsc aReverbForGrainStabInL, aReverbForGrainStabInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giReverbForGrainStabMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aReverbForGrainStabWetL, aReverbForGrainStabWetR freeverb aReverbForGrainStabInL, aReverbForGrainStabInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giReverbForGrainStabMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aReverbForGrainStabWetL pconvolve aReverbForGrainStabInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aReverbForGrainStabWetR pconvolve aReverbForGrainStabInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giReverbForGrainStabMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aReverbForGrainStabWetL convolve aReverbForGrainStabInL, SImpulseResponseFile, iChannelL
    aReverbForGrainStabWetR convolve aReverbForGrainStabInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giReverbForGrainStabMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aReverbForGrainStabWetL ftconv aReverbForGrainStabInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aReverbForGrainStabWetR ftconv aReverbForGrainStabInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
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
  if giReverbForGrainStabMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aReverbForGrainStabWetL nreverb aReverbForGrainStabInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aReverbForGrainStabWetR nreverb aReverbForGrainStabInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giReverbForGrainStabMode == 9 then
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

    aReverbForGrainStabWetLL, aReverbForGrainStabWetLR babo aReverbForGrainStabInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aReverbForGrainStabWetRL, aReverbForGrainStabWetRR babo aReverbForGrainStabInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aReverbForGrainStabWetL = aReverbForGrainStabWetLL + aReverbForGrainStabWetRL
    aReverbForGrainStabWetR = aReverbForGrainStabWetLR + aReverbForGrainStabWetRR
  endif

  aReverbForGrainStabL = aReverbForGrainStabWetL
  aReverbForGrainStabR = aReverbForGrainStabWetR

  outleta "OutL", aReverbForGrainStabL
  outleta "OutR", aReverbForGrainStabR
endin

instr ReverbForGrainStabWetKnob
  gkReverbForGrainStabWet linseg p4, p3, p5
endin

instr ReverbForGrainStabDryKnob
  gkReverbForGrainStabWet linseg p4, p3, p5
endin

instr ReverbForGrainStabBassKnob
  gkReverbForGrainStabEqBass linseg p4, p3, p5
endin

instr ReverbForGrainStabMidKnob
  gkReverbForGrainStabEqMid linseg p4, p3, p5
endin

instr ReverbForGrainStabHighKnob
  gkReverbForGrainStabEqHigh linseg p4, p3, p5
endin

instr ReverbForGrainStabFader
  gkReverbForGrainStabFader linseg p4, p3, p5
endin

instr ReverbForGrainStabPan
  gkReverbForGrainStabPan linseg p4, p3, p5
endin

instr ReverbForGrainStabMixerChannel
  aReverbForGrainStabL inleta "InL"
  aReverbForGrainStabR inleta "InR"

  aReverbForGrainStabL, aReverbForGrainStabR mixerChannel aReverbForGrainStabL, aReverbForGrainStabR, gkReverbForGrainStabFader, gkReverbForGrainStabPan, gkReverbForGrainStabEqBass, gkReverbForGrainStabEqMid, gkReverbForGrainStabEqHigh

  outleta "OutL", aReverbForGrainStabL
  outleta "OutR", aReverbForGrainStabR
endin
