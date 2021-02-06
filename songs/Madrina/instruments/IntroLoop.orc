instrumentRoute "IntroLoop", "FreezerInput"
alwayson "IntroLoopMixerChannel"

gkIntroLoopEqBass init 1
gkIntroLoopEqMid init 1
gkIntroLoopEqHigh init 1
gkIntroLoopFader init 1
gkIntroLoopPan init 50

gSIntroLoopSamplePath = "localSamples/Lifestyle - This Dream/IntroLoop.wav"
giIntroLoopSampleChannels filenchnls gSIntroLoopSamplePath
giIntroLoopSampleLength filelen gSIntroLoopSamplePath
giIntroLoopSampleLengthInBeats = 8
giIntroLoopLengthOfBeat = giIntroLoopSampleLength / giIntroLoopSampleLengthInBeats
giIntroLoopLengthBPM init 60 /giIntroLoopLengthOfBeat
giIntroLoopLengthOfBeatFactor = i(gkBPM) / giIntroLoopLengthBPM

if giIntroLoopSampleChannels = 2 then
  giIntroLoopSampleL ftgen 0, 0, 0, 1, gSIntroLoopSamplePath, 0, 0, 1
  giIntroLoopSampleR ftgen 0, 0, 0, 1, gSIntroLoopSamplePath, 0, 0, 2
else
  giIntroLoopSample ftgen 0, 0, 0, 1, gSIntroLoopSamplePath, 0, 0, 0
endif

instr IntroLoop
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giIntroLoopSampleLength * p5 * giIntroLoopLengthOfBeatFactor

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giIntroLoopSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giIntroLoopSampleLengthInBeats

  if giIntroLoopSampleChannels = 2 then
    aIntroLoopR poscil kAmplitudeEnvelope, kPitch, giIntroLoopSampleR, iStartTime
    aIntroLoopL poscil kAmplitudeEnvelope, kPitch, giIntroLoopSampleL, iStartTime
  else
    aIntroLoopL poscil kAmplitudeEnvelope, kPitch, giIntroLoopSample, iStartTime
    aIntroLoopR = aIntroLoopL
  endif

  outleta "OutL", aIntroLoopL
  outleta "OutR", aIntroLoopR
endin

instr IntroLoopBassKnob
  gkIntroLoopEqBass linseg p4, p3, p5
endin

instr IntroLoopMidKnob
  gkIntroLoopEqMid linseg p4, p3, p5
endin

instr IntroLoopHighKnob
  gkIntroLoopEqHigh linseg p4, p3, p5
endin

instr IntroLoopFader
  gkIntroLoopFader linseg p4, p3, p5
endin

instr IntroLoopPan
  gkIntroLoopPan linseg p4, p3, p5
endin

instr IntroLoopMixerChannel
  aIntroLoopL inleta "InL"
  aIntroLoopR inleta "InR"

  aIntroLoopL, aIntroLoopR mixerChannel aIntroLoopL, aIntroLoopR, gkIntroLoopFader, gkIntroLoopPan, gkIntroLoopEqBass, gkIntroLoopEqMid, gkIntroLoopEqHigh

  outleta "OutL", aIntroLoopL
  outleta "OutR", aIntroLoopR
endin

