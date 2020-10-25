alwayson "DrumKitReverbInput"
alwayson "DrumKitReverbMixerChannel"

gkDrumKitReverbEqBass init 1
gkDrumKitReverbEqMid init 1
gkDrumKitReverbEqHigh init 1
gkDrumKitReverbFader init 1
gkDrumKitReverbPan init 50

giDrumKitReverbMode init 7

gkDrumKitReverbWetAmount init .1
gkDrumKitReverbDryAmount init 1

bypassRoute "DrumKitReverb", "Mixer", "Mixer"

instr DrumKitReverbInput
  aDrumKitReverbInL inleta "InL"
  aDrumKitReverbInR inleta "InR"

  aDrumKitReverbOutWetL, aDrumKitReverbOutWetR, aDrumKitReverbOutDryL, aDrumKitReverbOutDryR bypassSwitch aDrumKitReverbInL, aDrumKitReverbInR, gkDrumKitReverbDryAmount, gkDrumKitReverbWetAmount, "DrumKitReverb"

  outleta "OutWetL", aDrumKitReverbOutWetL
  outleta "OutWetR", aDrumKitReverbOutWetR

  outleta "OutDryL", aDrumKitReverbOutDryL
  outleta "OutDryR", aDrumKitReverbOutDryR
endin

instr DrumKitReverb
  aDrumKitReverbInL inleta "InL"
  aDrumKitReverbInR inleta "InR"

  aDrumKitReverbWetL = aDrumKitReverbInL
  aDrumKitReverbWetR = aDrumKitReverbInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giDrumKitReverbMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aDrumKitReverbWetL alpass aDrumKitReverbInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aDrumKitReverbWetR alpass aDrumKitReverbInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giDrumKitReverbMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aDrumKitReverbWetL reverb aDrumKitReverbInL, kReverbTime, iSkip
    aDrumKitReverbWetR reverb aDrumKitReverbInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giDrumKitReverbMode == 3 then
    kFeedbackLevel = 0.95
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aDrumKitReverbWetL, aDrumKitReverbWetR reverbsc aDrumKitReverbInL, aDrumKitReverbInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giDrumKitReverbMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aDrumKitReverbWetL, aDrumKitReverbWetR freeverb aDrumKitReverbInL, aDrumKitReverbInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giDrumKitReverbMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aDrumKitReverbWetL pconvolve aDrumKitReverbInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aDrumKitReverbWetR pconvolve aDrumKitReverbInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giDrumKitReverbMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aDrumKitReverbWetL convolve aDrumKitReverbInL, SImpulseResponseFile, iChannelL
    aDrumKitReverbWetR convolve aDrumKitReverbInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giDrumKitReverbMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Highly Damped Large Room.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aDrumKitReverbWetL ftconv aDrumKitReverbInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aDrumKitReverbWetR ftconv aDrumKitReverbInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
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
  if giDrumKitReverbMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aDrumKitReverbWetL nreverb aDrumKitReverbInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aDrumKitReverbWetR nreverb aDrumKitReverbInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giDrumKitReverbMode == 9 then
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

    aDrumKitReverbWetLL, aDrumKitReverbWetLR babo aDrumKitReverbInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aDrumKitReverbWetRL, aDrumKitReverbWetRR babo aDrumKitReverbInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aDrumKitReverbWetL = aDrumKitReverbWetLL + aDrumKitReverbWetRL
    aDrumKitReverbWetR = aDrumKitReverbWetLR + aDrumKitReverbWetRR
  endif

  aDrumKitReverbL = aDrumKitReverbWetL
  aDrumKitReverbR = aDrumKitReverbWetR

  outleta "OutL", aDrumKitReverbL
  outleta "OutR", aDrumKitReverbR
endin

instr DrumKitReverbWetKnob
  gkDrumKitReverbWet linseg p4, p3, p5
endin

instr DrumKitReverbDryKnob
  gkDrumKitReverbWet linseg p4, p3, p5
endin

instr DrumKitReverbBassKnob
  gkDrumKitReverbEqBass linseg p4, p3, p5
endin

instr DrumKitReverbMidKnob
  gkDrumKitReverbEqMid linseg p4, p3, p5
endin

instr DrumKitReverbHighKnob
  gkDrumKitReverbEqHigh linseg p4, p3, p5
endin

instr DrumKitReverbFader
  gkDrumKitReverbFader linseg p4, p3, p5
endin

instr DrumKitReverbPan
  gkDrumKitReverbPan linseg p4, p3, p5
endin

instr DrumKitReverbMixerChannel
  aDrumKitReverbL inleta "InL"
  aDrumKitReverbR inleta "InR"

  aDrumKitReverbL, aDrumKitReverbR mixerChannel aDrumKitReverbL, aDrumKitReverbR, gkDrumKitReverbFader, gkDrumKitReverbPan, gkDrumKitReverbEqBass, gkDrumKitReverbEqMid, gkDrumKitReverbEqHigh

  outleta "OutL", aDrumKitReverbL
  outleta "OutR", aDrumKitReverbR
endin
