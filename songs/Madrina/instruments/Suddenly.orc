instrumentRoute "Suddenly", "FreezerInput"
alwayson "SuddenlyMixerChannel"

gkSuddenlyEqBass init 1
gkSuddenlyEqMid init 1
gkSuddenlyEqHigh init 1
gkSuddenlyFader init 1
gkSuddenlyPan init 50

gSSuddenlySamplePath = "localSamples/Lifestyle - This Dream/Suddenly.wav"
giSuddenlySampleChannels filenchnls gSSuddenlySamplePath
giSuddenlySampleLength filelen gSSuddenlySamplePath
giSuddenlySampleLengthInBeats = 4
giSuddenlyLengthOfBeat = giSuddenlySampleLength / giSuddenlySampleLengthInBeats
giSuddenlyLengthBPM init 60 /giSuddenlyLengthOfBeat
giSuddenlyLengthOfBeatFactor = i(gkBPM) / giSuddenlyLengthBPM

if giSuddenlySampleChannels = 2 then
  giSuddenlySampleL ftgen 0, 0, 0, 1, gSSuddenlySamplePath, 0, 0, 1
  giSuddenlySampleR ftgen 0, 0, 0, 1, gSSuddenlySamplePath, 0, 0, 2
else
  giSuddenlySample ftgen 0, 0, 0, 1, gSSuddenlySamplePath, 0, 0, 0
endif

instr Suddenly
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giSuddenlySampleLength * p5 * giSuddenlyLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giSuddenlySampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giSuddenlySampleLengthInBeats

  if giSuddenlySampleChannels = 2 then
    aSuddenlyR poscil kAmplitudeEnvelope, kPitch, giSuddenlySampleR, iStartTime
    aSuddenlyL poscil kAmplitudeEnvelope, kPitch, giSuddenlySampleL, iStartTime
  else
    aSuddenlyL poscil kAmplitudeEnvelope, kPitch, giSuddenlySample, iStartTime
    aSuddenlyR = aSuddenlyL
  endif

  outleta "OutL", aSuddenlyL
  outleta "OutR", aSuddenlyR
endin

instr SuddenlyBassKnob
  gkSuddenlyEqBass linseg p4, p3, p5
endin

instr SuddenlyMidKnob
  gkSuddenlyEqMid linseg p4, p3, p5
endin

instr SuddenlyHighKnob
  gkSuddenlyEqHigh linseg p4, p3, p5
endin

instr SuddenlyFader
  gkSuddenlyFader linseg p4, p3, p5
endin

instr SuddenlyPan
  gkSuddenlyPan linseg p4, p3, p5
endin

instr SuddenlyMixerChannel
  aSuddenlyL inleta "InL"
  aSuddenlyR inleta "InR"

  aSuddenlyL, aSuddenlyR mixerChannel aSuddenlyL, aSuddenlyR, gkSuddenlyFader, gkSuddenlyPan, gkSuddenlyEqBass, gkSuddenlyEqMid, gkSuddenlyEqHigh

  outleta "OutL", aSuddenlyL
  outleta "OutR", aSuddenlyR
endin

