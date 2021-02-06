stereoRoute "DelayHiHatSound", "DelayHiHat"
stereoRoute "DelayHiHatSound", "Mixer"
instrumentRoute "DelayHiHat", "WarmDistortionInput"

giDelayHiHatSamples[] fillarray \
  ftgen( 0, 0, 0, 1, "localSamples/Drums/House-Drums_Closed-Hat_EA8820.wav", 0, 0, 0), \
  ftgen( 0, 0, 0, 1, "localSamples/Drums/Funk-Kit_Open-Hat_EA8155.wav", 0, 0, 0)

gkDelayHiHatStereoOffset init 0
gaDelayHiHatTime init beatsToSeconds(1/4)

instr DelayHiHatSound
  aDelayHiHatSampleL, aDelayHiHatSampleR drumSample giDelayHiHatSamples[p6], p4, p5, 1

  outleta "OutL", aDelayHiHatSampleL
  outleta "OutR", aDelayHiHatSampleR
endin

instr DelayHiHat
  aSignalL inleta "InL"
  aSignalR inleta "InR"

  iOpenOrClosed = p6
  iHatNoteLength = p7 == 0 ? 2 : p7
  event_i "i", "DelayHiHatSound", 0, iHatNoteLength, p4, p5, iOpenOrClosed

  aDelayTime = p8 + gaDelayHiHatTime
  aDelayTimeL = limit(aDelayTime + gkDelayHiHatStereoOffset, 0.001, 100)
  aDelayTimeR = limit(aDelayTime - gkDelayHiHatStereoOffset, 0.001, 100)
  iBufferLength = 5
  kDelayLevel = 1
  kFeedbackAmount = 1
  aSignalL += delayBuffer(aSignalL, kFeedbackAmount, iBufferLength, aDelayTimeL, kDelayLevel)
  aSignalR += delayBuffer(aSignalR, kFeedbackAmount, iBufferLength, aDelayTimeR, kDelayLevel)

  outleta "OutL", aSignalL
  outleta "OutR", aSignalR
endin

$MIXER_CHANNEL(DelayHiHat)
