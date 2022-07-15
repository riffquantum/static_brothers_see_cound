instrumentRoute "WhoIsHeLoop", "Mixer"
alwayson "WhoIsHeLoopMixerChannel"

gkWhoIsHeLoopEqBass init 1
gkWhoIsHeLoopEqMid init 1
gkWhoIsHeLoopEqHigh init 1
gkWhoIsHeLoopFader init 2
gkWhoIsHeLoopPan init 50

gSWhoIsHeLoopSamplePath = "songs/Withers/instruments/WhoIsHeLoop/WhoIsHeLoop.wav"
giWhoIsHeLoopSampleChannels filenchnls gSWhoIsHeLoopSamplePath
giWhoIsHeLoopSampleLength filelen gSWhoIsHeLoopSamplePath
giWhoIsHeLoopSampleLengthInBeats = 16
giWhoIsHeLoopLengthOfBeat = giWhoIsHeLoopSampleLength / giWhoIsHeLoopSampleLengthInBeats
giWhoIsHeLoopLengthBPM init 60 /giWhoIsHeLoopLengthOfBeat
giWhoIsHeLoopLengthOfBeatFactor = i(gkBPM) / giWhoIsHeLoopLengthBPM

if giWhoIsHeLoopSampleChannels = 2 then
  giWhoIsHeLoopSampleL ftgen 0, 0, 0, 1, gSWhoIsHeLoopSamplePath, 0, 0, 1
  giWhoIsHeLoopSampleR ftgen 0, 0, 0, 1, gSWhoIsHeLoopSamplePath, 0, 0, 2
else
  giWhoIsHeLoopSample ftgen 0, 0, 0, 1, gSWhoIsHeLoopSamplePath, 0, 0, 0
endif

instr WhoIsHeLoop
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giWhoIsHeLoopSampleLength * p5 * giWhoIsHeLoopLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giWhoIsHeLoopSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giWhoIsHeLoopSampleLengthInBeats

  if giWhoIsHeLoopSampleChannels = 2 then
    aWhoIsHeLoopR poscil kAmplitudeEnvelope, kPitch, giWhoIsHeLoopSampleR, iStartTime
    aWhoIsHeLoopL poscil kAmplitudeEnvelope, kPitch, giWhoIsHeLoopSampleL, iStartTime
  else
    aWhoIsHeLoopL poscil kAmplitudeEnvelope, kPitch, giWhoIsHeLoopSample, iStartTime
    aWhoIsHeLoopR = aWhoIsHeLoopL
  endif

  outleta "OutL", aWhoIsHeLoopL
  outleta "OutR", aWhoIsHeLoopR
endin

instr WhoIsHeLoopBassKnob
  gkWhoIsHeLoopEqBass linseg p4, p3, p5
endin

instr WhoIsHeLoopMidKnob
  gkWhoIsHeLoopEqMid linseg p4, p3, p5
endin

instr WhoIsHeLoopHighKnob
  gkWhoIsHeLoopEqHigh linseg p4, p3, p5
endin

instr WhoIsHeLoopFader
  gkWhoIsHeLoopFader linseg p4, p3, p5
endin

instr WhoIsHeLoopPan
  gkWhoIsHeLoopPan linseg p4, p3, p5
endin

instr WhoIsHeLoopMixerChannel
  aWhoIsHeLoopL inleta "InL"
  aWhoIsHeLoopR inleta "InR"

  aWhoIsHeLoopL, aWhoIsHeLoopR mixerChannel aWhoIsHeLoopL, aWhoIsHeLoopR, gkWhoIsHeLoopFader, gkWhoIsHeLoopPan, gkWhoIsHeLoopEqBass, gkWhoIsHeLoopEqMid, gkWhoIsHeLoopEqHigh

  outleta "OutL", aWhoIsHeLoopL
  outleta "OutR", aWhoIsHeLoopR
endin

