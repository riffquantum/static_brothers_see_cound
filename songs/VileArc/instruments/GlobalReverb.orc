alwayson "GlobalReverbInput"
alwayson "GlobalReverbMixerChannel"

gkGlobalReverbEqBass init 1
gkGlobalReverbEqMid init 1
gkGlobalReverbEqHigh init 1
gkGlobalReverbFader init 1
gkGlobalReverbPan init 50

giGlobalReverbMode init 3

gkGlobalReverbWetAmount init .3
gkGlobalReverbDryAmount init 1

bypassRoute "GlobalReverb", "Mixer", "Mixer"

instr GlobalReverbInput
  aGlobalReverbInL inleta "InL"
  aGlobalReverbInR inleta "InR"

  aGlobalReverbOutWetL, aGlobalReverbOutWetR, aGlobalReverbOutDryL, aGlobalReverbOutDryR bypassSwitch aGlobalReverbInL, aGlobalReverbInR, gkGlobalReverbDryAmount, gkGlobalReverbWetAmount, "GlobalReverb"

  outleta "OutWetL", aGlobalReverbOutWetL
  outleta "OutWetR", aGlobalReverbOutWetR

  outleta "OutDryL", aGlobalReverbOutDryL
  outleta "OutDryR", aGlobalReverbOutDryR
endin

instr GlobalReverb
  aGlobalReverbInL inleta "InL"
  aGlobalReverbInR inleta "InR"

  aGlobalReverbWetL = aGlobalReverbInL
  aGlobalReverbWetR = aGlobalReverbInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giGlobalReverbMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aGlobalReverbWetL alpass aGlobalReverbInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aGlobalReverbWetR alpass aGlobalReverbInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giGlobalReverbMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aGlobalReverbWetL reverb aGlobalReverbInL, kReverbTime, iSkip
    aGlobalReverbWetR reverb aGlobalReverbInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giGlobalReverbMode == 3 then
    kFeedbackLevel = 0.95
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aGlobalReverbWetL, aGlobalReverbWetR reverbsc aGlobalReverbInL, aGlobalReverbInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giGlobalReverbMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aGlobalReverbWetL, aGlobalReverbWetR freeverb aGlobalReverbInL, aGlobalReverbInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giGlobalReverbMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aGlobalReverbWetL pconvolve aGlobalReverbInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aGlobalReverbWetR pconvolve aGlobalReverbInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giGlobalReverbMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aGlobalReverbWetL convolve aGlobalReverbInL, SImpulseResponseFile, iChannelL
    aGlobalReverbWetR convolve aGlobalReverbInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giGlobalReverbMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aGlobalReverbWetL ftconv aGlobalReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aGlobalReverbWetR ftconv aGlobalReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
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
  if giGlobalReverbMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aGlobalReverbWetL nreverb aGlobalReverbInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aGlobalReverbWetR nreverb aGlobalReverbInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giGlobalReverbMode == 9 then
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

    aGlobalReverbWetLL, aGlobalReverbWetLR babo aGlobalReverbInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aGlobalReverbWetRL, aGlobalReverbWetRR babo aGlobalReverbInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aGlobalReverbWetL = aGlobalReverbWetLL + aGlobalReverbWetRL
    aGlobalReverbWetR = aGlobalReverbWetLR + aGlobalReverbWetRR
  endif

  aGlobalReverbL = aGlobalReverbWetL * madsr(0.01, 0.01, 1, .5)
  aGlobalReverbR = aGlobalReverbWetR * madsr(0.01, 0.01, 1, .5)

  outleta "OutL", aGlobalReverbL
  outleta "OutR", aGlobalReverbR
endin

instr GlobalReverbWetKnob
  gkGlobalReverbWet linseg p4, p3, p5
endin

instr GlobalReverbDryKnob
  gkGlobalReverbWet linseg p4, p3, p5
endin

instr GlobalReverbBassKnob
  gkGlobalReverbEqBass linseg p4, p3, p5
endin

instr GlobalReverbMidKnob
  gkGlobalReverbEqMid linseg p4, p3, p5
endin

instr GlobalReverbHighKnob
  gkGlobalReverbEqHigh linseg p4, p3, p5
endin

instr GlobalReverbFader
  gkGlobalReverbFader linseg p4, p3, p5
endin

instr GlobalReverbPan
  gkGlobalReverbPan linseg p4, p3, p5
endin

instr GlobalReverbMixerChannel
  aGlobalReverbL inleta "InL"
  aGlobalReverbR inleta "InR"

  aGlobalReverbL, aGlobalReverbR mixerChannel aGlobalReverbL, aGlobalReverbR, gkGlobalReverbFader, gkGlobalReverbPan, gkGlobalReverbEqBass, gkGlobalReverbEqMid, gkGlobalReverbEqHigh

  outleta "OutL", aGlobalReverbL
  outleta "OutR", aGlobalReverbR
endin
