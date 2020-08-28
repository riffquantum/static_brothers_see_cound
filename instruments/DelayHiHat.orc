stereoRoute "DelayHiHatSound", "DelayHiHat"
stereoRoute "DelayHiHatSound", "Mixer"
instrumentRoute "DelayHiHat", "WarmDistortionInput"
alwayson "DelayHiHatMixerChannel"

gkDelayHiHatEqBass init 1
gkDelayHiHatEqMid init 1
gkDelayHiHatEqHigh init 1
gkDelayHiHatFader init 1
gkDelayHiHatPan init 50

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
  kFeedbackAmmount = 1
  aSignalL += delayBuffer(aSignalL, kFeedbackAmmount, iBufferLength, aDelayTimeL, kDelayLevel)
  aSignalR += delayBuffer(aSignalR, kFeedbackAmmount, iBufferLength, aDelayTimeR, kDelayLevel)

  outleta "OutL", aSignalL
  outleta "OutR", aSignalR
endin


instr DelayHiHatBassKnob
  gkDelayHiHatEqBass linseg p4, p3, p5
endin

instr DelayHiHatMidKnob
  gkDelayHiHatEqMid linseg p4, p3, p5
endin

instr DelayHiHatHighKnob
  gkDelayHiHatEqHigh linseg p4, p3, p5
endin

instr DelayHiHatFader
  gkDelayHiHatFader linseg p4, p3, p5
endin

instr DelayHiHatPan
  gkDelayHiHatPan linseg p4, p3, p5
endin

instr DelayHiHatMixerChannel
  aDelayHiHatL inleta "InL"
  aDelayHiHatR inleta "InR"

  aDelayHiHatL, aDelayHiHatR mixerChannel aDelayHiHatL, aDelayHiHatR, gkDelayHiHatFader, gkDelayHiHatPan, gkDelayHiHatEqBass, gkDelayHiHatEqMid, gkDelayHiHatEqHigh

  outleta "OutL", aDelayHiHatL
  outleta "OutR", aDelayHiHatR
endin
