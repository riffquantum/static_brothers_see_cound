alwayson "ReverbExamples"
alwayson "ReverbExamplesMixerChannel"

connect "ReverbExamples", "ReverbExamplesOutL", "ReverbExamplesMixerChannel", "ReverbExamplesInL"
connect "ReverbExamples", "ReverbExamplesOutR", "ReverbExamplesMixerChannel", "ReverbExamplesInR"

gkReverbExamplesEqBass init 1
gkReverbExamplesEqMid init 1
gkReverbExamplesEqHigh init 1
gkReverbExamplesFader init 1
gkReverbExamplesPan init 50

gkReverbExamplesWet init 1
gkReverbExamplesDry init 1

giReverbExamplesMode init 9

instr ReverbExamples
  aReverbExamplesInL inleta "ReverbExamplesInL"
  aReverbExamplesInR inleta "ReverbExamplesInR"

  aReverbExamplesWetL = aReverbExamplesInL
  aReverbExamplesWetR = aReverbExamplesInR

  /* ********
      homemade schroeder
     ********

     to do
  */

  /* ********
      alpass
     ********
  */
  if giReverbExamplesMode == 1 then
    iReverbTime = 3
    iLoopTime  = .05
    iSkip = 0
    iDelayAmountInSamples = 0

    aReverbExamplesWetL alpass aReverbExamplesInL, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
    aReverbExamplesWetR alpass aReverbExamplesInR, iReverbTime, iLoopTime, iSkip, iDelayAmountInSamples
  endif
  /* ********
      reverb
     ********
  */
  if giReverbExamplesMode == 2 then
    kReverbTime = 3
    iSkip = 0

    aReverbExamplesWetL reverb aReverbExamplesInL, kReverbTime, iSkip
    aReverbExamplesWetR reverb aReverbExamplesInR, kReverbTime, iSkip
  endif

  /* ********
      reverbsc
     ********
  */
  if giReverbExamplesMode == 3 then
    kFeedbackLevel = 0.9
    iSampleRate = sr
    kCutoffFrequency = iSampleRate/4 - 1
    iPitchVariation = 1
    iSkip = 0
    aReverbExamplesWetL, aReverbExamplesWetR reverbsc aReverbExamplesInL, aReverbExamplesInR, kFeedbackLevel, kCutoffFrequency, iSampleRate, iPitchVariation, iSkip
  endif

  /* ********
      freeverb
     ********
  */
  if giReverbExamplesMode == 4 then
    kRoomSize = 0.9
    kHighFrequencyDampening = 1
    iSampleRate = sr
    iSkip = 0

    aReverbExamplesWetL, aReverbExamplesWetR freeverb aReverbExamplesInL, aReverbExamplesInR, kRoomSize, kHighFrequencyDampening, iSampleRate, iSkip
  endif

  /* ********
      pconvolve
     ********
  */
  if giReverbExamplesMode == 5 then
    SImpulseResponseFile = "./localsamples/stairwell.wav"
    iPartitionSize = 1024
    iChannelL = 1
    iChannelR = 2

    aReverbExamplesWetL pconvolve aReverbExamplesInL, SImpulseResponseFile, iPartitionSize, iChannelL
    aReverbExamplesWetR pconvolve aReverbExamplesInR, SImpulseResponseFile, iPartitionSize, iChannelR
  endif

  /* ********
      convolve - wow that's terrible!
     ********
  */
  if giReverbExamplesMode == 6 then
    SImpulseResponseFile = "./localsamples/stairwell.cv"
    iChannelL = 1
    iChannelR = 2

    aReverbExamplesWetL convolve aReverbExamplesInL, SImpulseResponseFile, iChannelL
    aReverbExamplesWetR convolve aReverbExamplesInR, SImpulseResponseFile, iChannelR
  endif

  /* ********
      ftconv
     ********
  */
  if giReverbExamplesMode == 7 then
    iImpulseTable ftgen 0, 0, 0, 1, "./localSamples/IMreverbs/Small Prehistoric Cave.wav", 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aReverbExamplesWetL ftconv aReverbExamplesInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aReverbExamplesWetR ftconv aReverbExamplesInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
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
  if giReverbExamplesMode == 8 then
    kReverbTime = 3
    kHighFrequencyDiffusion = .75
    iSkip = 0
    iNumberOfCombConstants = 8
    iCombFilterTimeValues ftgen 0, 0, 0, -2,  -1116, -1188, -1277, -1356, -1422, -1491, -1557, -1617,  0.8,  0.79,  0.78,  0.77,  0.76,  0.75,  0.74,  0.73 ;This table needs iNumberOfCombConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.
    iNumberOfAlpassConstants = 4
    iAlpassTimeValues ftgen 0, 0, 0, -2,  -556, -441, -341, -225,  0.7,  0.72,  0.74,  0.76 ;This table needs iNumberOfAlpassConstants time values followed by the same number of gain values. Negative time values are in samples, positive time values are in seconds.

    aReverbExamplesWetL nreverb aReverbExamplesInL, kReverbTime, kHighFrequencyDiffusion, iSkip,  iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues

    aReverbExamplesWetR nreverb aReverbExamplesInR, kReverbTime, kHighFrequencyDiffusion, iSkip, iNumberOfCombConstants, iCombFilterTimeValues, iNumberOfAlpassConstants, iAlpassTimeValues
  endif

  /* ********
      babo
     ********
  */
  if giReverbExamplesMode == 9 then
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

    aReverbExamplesWetLL, aReverbExamplesWetLR babo aReverbExamplesInL, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aReverbExamplesWetRL, aReverbExamplesWetRR babo aReverbExamplesInR, kXSourcePosition, kYSourcePosition, kZSourcePosition, iXLength, iYLength, iZLength, iDiffusion, iReverbParams

    aReverbExamplesWetL = aReverbExamplesWetLL + aReverbExamplesWetRL
    aReverbExamplesWetR = aReverbExamplesWetLR + aReverbExamplesWetRR
  endif

  aReverbExamplesL = (aReverbExamplesWetL * gkReverbExamplesWet) + (aReverbExamplesInL * gkReverbExamplesDry)
  aReverbExamplesR = (aReverbExamplesWetR * gkReverbExamplesWet) + (aReverbExamplesInR * gkReverbExamplesDry)

  outleta "ReverbExamplesOutL", aReverbExamplesL
  outleta "ReverbExamplesOutR", aReverbExamplesR
endin

instr ReverbExamplesWetKnob
    gkReverbExamplesWet linseg p4, p3, p5
endin

instr ReverbExamplesDryKnob
    gkReverbExamplesWet linseg p4, p3, p5
endin

instr ReverbExamplesBassKnob
    gkReverbExamplesEqBass linseg p4, p3, p5
endin

instr ReverbExamplesMidKnob
    gkReverbExamplesEqMid linseg p4, p3, p5
endin

instr ReverbExamplesHighKnob
    gkReverbExamplesEqHigh linseg p4, p3, p5
endin

instr ReverbExamplesFader
    gkReverbExamplesFader linseg p4, p3, p5
endin

instr ReverbExamplesPan
    gkReverbExamplesPan linseg p4, p3, p5
endin

instr ReverbExamplesMixerChannel
    aReverbExamplesL inleta "ReverbExamplesInL"
    aReverbExamplesR inleta "ReverbExamplesInR"

    kReverbExamplesFader = gkReverbExamplesFader
    kReverbExamplesPan = gkReverbExamplesPan
    kReverbExamplesEqBass = gkReverbExamplesEqBass
    kReverbExamplesEqMid = gkReverbExamplesEqMid
    kReverbExamplesEqHigh = gkReverbExamplesEqHigh

    aReverbExamplesL, aReverbExamplesR threeBandEqStereo aReverbExamplesL, aReverbExamplesR, kReverbExamplesEqBass, kReverbExamplesEqMid, kReverbExamplesEqHigh

    if kReverbExamplesPan > 100 then
        kReverbExamplesPan = 100
    elseif kReverbExamplesPan < 0 then
        kReverbExamplesPan = 0
    endif

    aReverbExamplesL = (aReverbExamplesL * ((100 - kReverbExamplesPan) * 2 / 100)) * kReverbExamplesFader
    aReverbExamplesR = (aReverbExamplesR * (kReverbExamplesPan * 2 / 100)) * kReverbExamplesFader

    outleta "ReverbExamplesOutL", aReverbExamplesL
    outleta "ReverbExamplesOutR", aReverbExamplesR
endin

connect "ReverbExamplesMixerChannel", "ReverbExamplesOutL", "Mixer", "MixerInL"
connect "ReverbExamplesMixerChannel", "ReverbExamplesOutR", "Mixer", "MixerInR"
