instrumentRoute "SegueVocal", "VocalEffectChain"
alwayson "SegueVocalMixerChannel"

gkSegueVocalEqBass init 1
gkSegueVocalEqMid init 1
gkSegueVocalEqHigh init 1
gkSegueVocalFader init 1
gkSegueVocalPan init 50

gSSegueVocalSamplePath = "songs/AvianPeter/instruments/Vocals/Avian Peter Segue.wav"
giSegueVocalSampleChannels filenchnls gSSegueVocalSamplePath
giSegueVocalSampleLength filelen gSSegueVocalSamplePath
giSegueVocalSampleLengthInBeats = 3
giSegueVocalLengthOfBeat = giSegueVocalSampleLength / giSegueVocalSampleLengthInBeats
giSegueVocalLengthBPM init 60 /giSegueVocalLengthOfBeat
giSegueVocalLengthOfBeatFactor = i(gkBPM) / giSegueVocalLengthBPM

if giSegueVocalSampleChannels = 2 then
  giSegueVocalSampleL ftgen 0, 0, 0, 1, gSSegueVocalSamplePath, 0, 0, 1
  giSegueVocalSampleR ftgen 0, 0, 0, 1, gSSegueVocalSamplePath, 0, 0, 2
else
  giSegueVocalSample ftgen 0, 0, 0, 1, gSSegueVocalSamplePath, 0, 0, 0
endif

instr SegueVocal
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giSegueVocalSampleLength * p5 * giSegueVocalLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giSegueVocalSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giSegueVocalSampleLengthInBeats

  if giSegueVocalSampleChannels = 2 then
    aSegueVocalR poscil kAmplitudeEnvelope, kPitch, giSegueVocalSampleR, iStartTime
    aSegueVocalL poscil kAmplitudeEnvelope, kPitch, giSegueVocalSampleL, iStartTime
  else
    aSegueVocalL poscil kAmplitudeEnvelope, kPitch, giSegueVocalSample, iStartTime
    aSegueVocalR = aSegueVocalL
  endif

  outleta "OutL", aSegueVocalL
  outleta "OutR", aSegueVocalR
endin

instr SegueVocalBassKnob
  gkSegueVocalEqBass linseg p4, p3, p5
endin

instr SegueVocalMidKnob
  gkSegueVocalEqMid linseg p4, p3, p5
endin

instr SegueVocalHighKnob
  gkSegueVocalEqHigh linseg p4, p3, p5
endin

instr SegueVocalFader
  gkSegueVocalFader linseg p4, p3, p5
endin

instr SegueVocalPan
  gkSegueVocalPan linseg p4, p3, p5
endin

instr SegueVocalMixerChannel
  aSegueVocalL inleta "InL"
  aSegueVocalR inleta "InR"

  aSegueVocalL, aSegueVocalR mixerChannel aSegueVocalL, aSegueVocalR, gkSegueVocalFader, gkSegueVocalPan, gkSegueVocalEqBass, gkSegueVocalEqMid, gkSegueVocalEqHigh

  outleta "OutL", aSegueVocalL
  outleta "OutR", aSegueVocalR
endin

