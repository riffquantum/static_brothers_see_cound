instrumentRoute "WeThought", "FreezerInput"
alwayson "WeThoughtMixerChannel"

gkWeThoughtEqBass init 1
gkWeThoughtEqMid init 1
gkWeThoughtEqHigh init 1
gkWeThoughtFader init 1
gkWeThoughtPan init 50

gSWeThoughtSamplePath = "localSamples/Lifestyle - This Dream/WeThought.wav"
giWeThoughtSampleChannels filenchnls gSWeThoughtSamplePath
giWeThoughtSampleLength filelen gSWeThoughtSamplePath
giWeThoughtSampleLengthInBeats = 4
giWeThoughtLengthOfBeat = giWeThoughtSampleLength / giWeThoughtSampleLengthInBeats
giWeThoughtLengthBPM init 60 /giWeThoughtLengthOfBeat
giWeThoughtLengthOfBeatFactor = i(gkBPM) / giWeThoughtLengthBPM

if giWeThoughtSampleChannels = 2 then
  giWeThoughtSampleL ftgen 0, 0, 0, 1, gSWeThoughtSamplePath, 0, 0, 1
  giWeThoughtSampleR ftgen 0, 0, 0, 1, gSWeThoughtSamplePath, 0, 0, 2
else
  giWeThoughtSample ftgen 0, 0, 0, 1, gSWeThoughtSamplePath, 0, 0, 0
endif

instr WeThought
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giWeThoughtSampleLength * p5 * giWeThoughtLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giWeThoughtSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giWeThoughtSampleLengthInBeats

  if giWeThoughtSampleChannels = 2 then
    aWeThoughtR poscil kAmplitudeEnvelope, kPitch, giWeThoughtSampleR, iStartTime
    aWeThoughtL poscil kAmplitudeEnvelope, kPitch, giWeThoughtSampleL, iStartTime
  else
    aWeThoughtL poscil kAmplitudeEnvelope, kPitch, giWeThoughtSample, iStartTime
    aWeThoughtR = aWeThoughtL
  endif

  outleta "OutL", aWeThoughtL
  outleta "OutR", aWeThoughtR
endin

instr WeThoughtBassKnob
  gkWeThoughtEqBass linseg p4, p3, p5
endin

instr WeThoughtMidKnob
  gkWeThoughtEqMid linseg p4, p3, p5
endin

instr WeThoughtHighKnob
  gkWeThoughtEqHigh linseg p4, p3, p5
endin

instr WeThoughtFader
  gkWeThoughtFader linseg p4, p3, p5
endin

instr WeThoughtPan
  gkWeThoughtPan linseg p4, p3, p5
endin

instr WeThoughtMixerChannel
  aWeThoughtL inleta "InL"
  aWeThoughtR inleta "InR"

  aWeThoughtL, aWeThoughtR mixerChannel aWeThoughtL, aWeThoughtR, gkWeThoughtFader, gkWeThoughtPan, gkWeThoughtEqBass, gkWeThoughtEqMid, gkWeThoughtEqHigh

  outleta "OutL", aWeThoughtL
  outleta "OutR", aWeThoughtR
endin

