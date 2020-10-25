instrumentRoute "EndingVocal", "VocalEffectChain"
alwayson "EndingVocalMixerChannel"

gkEndingVocalEqBass init 1
gkEndingVocalEqMid init 1
gkEndingVocalEqHigh init 1
gkEndingVocalFader init 1
gkEndingVocalPan init 50

gSEndingVocalSamplePath = "songs/AvianPeter/instruments/Vocals/Avian Peter End.wav"
giEndingVocalSampleChannels filenchnls gSEndingVocalSamplePath
giEndingVocalSampleLength filelen gSEndingVocalSamplePath
giEndingVocalSampleLengthInBeats = 121
giEndingVocalLengthOfBeat = giEndingVocalSampleLength / giEndingVocalSampleLengthInBeats
giEndingVocalLengthBPM init 60 /giEndingVocalLengthOfBeat
giEndingVocalLengthOfBeatFactor = i(gkBPM) / giEndingVocalLengthBPM

if giEndingVocalSampleChannels = 2 then
  giEndingVocalSampleL ftgen 0, 0, 0, 1, gSEndingVocalSamplePath, 0, 0, 1
  giEndingVocalSampleR ftgen 0, 0, 0, 1, gSEndingVocalSamplePath, 0, 0, 2
else
  giEndingVocalSample ftgen 0, 0, 0, 1, gSEndingVocalSamplePath, 0, 0, 0
endif

instr EndingVocal
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giEndingVocalSampleLength * p5 * giEndingVocalLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giEndingVocalSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giEndingVocalSampleLengthInBeats

  if giEndingVocalSampleChannels = 2 then
    aEndingVocalR poscil kAmplitudeEnvelope, kPitch, giEndingVocalSampleR, iStartTime
    aEndingVocalL poscil kAmplitudeEnvelope, kPitch, giEndingVocalSampleL, iStartTime
  else
    aEndingVocalL poscil kAmplitudeEnvelope, kPitch, giEndingVocalSample, iStartTime
    aEndingVocalR = aEndingVocalL
  endif

  outleta "OutL", aEndingVocalL
  outleta "OutR", aEndingVocalR
endin

instr EndingVocalBassKnob
  gkEndingVocalEqBass linseg p4, p3, p5
endin

instr EndingVocalMidKnob
  gkEndingVocalEqMid linseg p4, p3, p5
endin

instr EndingVocalHighKnob
  gkEndingVocalEqHigh linseg p4, p3, p5
endin

instr EndingVocalFader
  gkEndingVocalFader linseg p4, p3, p5
endin

instr EndingVocalPan
  gkEndingVocalPan linseg p4, p3, p5
endin

instr EndingVocalMixerChannel
  aEndingVocalL inleta "InL"
  aEndingVocalR inleta "InR"

  aEndingVocalL, aEndingVocalR mixerChannel aEndingVocalL, aEndingVocalR, gkEndingVocalFader, gkEndingVocalPan, gkEndingVocalEqBass, gkEndingVocalEqMid, gkEndingVocalEqHigh

  outleta "OutL", aEndingVocalL
  outleta "OutR", aEndingVocalR
endin

