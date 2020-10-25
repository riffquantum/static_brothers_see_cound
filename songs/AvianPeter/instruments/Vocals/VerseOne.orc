instrumentRoute "VerseOne", "VocalEffectChain"
alwayson "VerseOneMixerChannel"

gkVerseOneEqBass init 1
gkVerseOneEqMid init 1
gkVerseOneEqHigh init 1
gkVerseOneFader init 1
gkVerseOnePan init 50

gSVerseOneSamplePath = "songs/AvianPeter/instruments/Vocals/Avian Peter Verse 1.wav"
giVerseOneSampleChannels filenchnls gSVerseOneSamplePath
giVerseOneSampleLength filelen gSVerseOneSamplePath
giVerseOneSampleLengthInBeats = 121
giVerseOneLengthOfBeat = giVerseOneSampleLength / giVerseOneSampleLengthInBeats
giVerseOneLengthBPM init 60 /giVerseOneLengthOfBeat
giVerseOneLengthOfBeatFactor = i(gkBPM) / giVerseOneLengthBPM

if giVerseOneSampleChannels = 2 then
  giVerseOneSampleL ftgen 0, 0, 0, 1, gSVerseOneSamplePath, 0, 0, 1
  giVerseOneSampleR ftgen 0, 0, 0, 1, gSVerseOneSamplePath, 0, 0, 2
else
  giVerseOneSample ftgen 0, 0, 0, 1, gSVerseOneSamplePath, 0, 0, 0
endif

instr VerseOne
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giVerseOneSampleLength * p5 * giVerseOneLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giVerseOneSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giVerseOneSampleLengthInBeats

  if giVerseOneSampleChannels = 2 then
    aVerseOneR poscil kAmplitudeEnvelope, kPitch, giVerseOneSampleR, iStartTime
    aVerseOneL poscil kAmplitudeEnvelope, kPitch, giVerseOneSampleL, iStartTime
  else
    aVerseOneL poscil kAmplitudeEnvelope, kPitch, giVerseOneSample, iStartTime
    aVerseOneR = aVerseOneL
  endif

  outleta "OutL", aVerseOneL
  outleta "OutR", aVerseOneR
endin

instr VerseOneBassKnob
  gkVerseOneEqBass linseg p4, p3, p5
endin

instr VerseOneMidKnob
  gkVerseOneEqMid linseg p4, p3, p5
endin

instr VerseOneHighKnob
  gkVerseOneEqHigh linseg p4, p3, p5
endin

instr VerseOneFader
  gkVerseOneFader linseg p4, p3, p5
endin

instr VerseOnePan
  gkVerseOnePan linseg p4, p3, p5
endin

instr VerseOneMixerChannel
  aVerseOneL inleta "InL"
  aVerseOneR inleta "InR"

  aVerseOneL, aVerseOneR mixerChannel aVerseOneL, aVerseOneR, gkVerseOneFader, gkVerseOnePan, gkVerseOneEqBass, gkVerseOneEqMid, gkVerseOneEqHigh

  outleta "OutL", aVerseOneL
  outleta "OutR", aVerseOneR
endin

