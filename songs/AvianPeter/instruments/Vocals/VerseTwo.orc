instrumentRoute "VerseTwo", "VocalEffectChain"
alwayson "VerseTwoMixerChannel"

gkVerseTwoEqBass init 1
gkVerseTwoEqMid init 1
gkVerseTwoEqHigh init 1
gkVerseTwoFader init 1
gkVerseTwoPan init 50

gSVerseTwoSamplePath = "songs/AvianPeter/instruments/Vocals/Avian Peter Verse 2.wav"
giVerseTwoSampleChannels filenchnls gSVerseTwoSamplePath
giVerseTwoSampleLength filelen gSVerseTwoSamplePath
giVerseTwoSampleLengthInBeats = 95
giVerseTwoLengthOfBeat = giVerseTwoSampleLength / giVerseTwoSampleLengthInBeats
giVerseTwoLengthBPM init 60 /giVerseTwoLengthOfBeat
giVerseTwoLengthOfBeatFactor = i(gkBPM) / giVerseTwoLengthBPM

if giVerseTwoSampleChannels = 2 then
  giVerseTwoSampleL ftgen 0, 0, 0, 1, gSVerseTwoSamplePath, 0, 0, 1
  giVerseTwoSampleR ftgen 0, 0, 0, 1, gSVerseTwoSamplePath, 0, 0, 2
else
  giVerseTwoSample ftgen 0, 0, 0, 1, gSVerseTwoSamplePath, 0, 0, 0
endif

instr VerseTwo
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giVerseTwoSampleLength * p5 * giVerseTwoLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giVerseTwoSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giVerseTwoSampleLengthInBeats

  if giVerseTwoSampleChannels = 2 then
    aVerseTwoR poscil kAmplitudeEnvelope, kPitch, giVerseTwoSampleR, iStartTime
    aVerseTwoL poscil kAmplitudeEnvelope, kPitch, giVerseTwoSampleL, iStartTime
  else
    aVerseTwoL poscil kAmplitudeEnvelope, kPitch, giVerseTwoSample, iStartTime
    aVerseTwoR = aVerseTwoL
  endif

  outleta "OutL", aVerseTwoL
  outleta "OutR", aVerseTwoR
endin

instr VerseTwoBassKnob
  gkVerseTwoEqBass linseg p4, p3, p5
endin

instr VerseTwoMidKnob
  gkVerseTwoEqMid linseg p4, p3, p5
endin

instr VerseTwoHighKnob
  gkVerseTwoEqHigh linseg p4, p3, p5
endin

instr VerseTwoFader
  gkVerseTwoFader linseg p4, p3, p5
endin

instr VerseTwoPan
  gkVerseTwoPan linseg p4, p3, p5
endin

instr VerseTwoMixerChannel
  aVerseTwoL inleta "InL"
  aVerseTwoR inleta "InR"

  aVerseTwoL, aVerseTwoR mixerChannel aVerseTwoL, aVerseTwoR, gkVerseTwoFader, gkVerseTwoPan, gkVerseTwoEqBass, gkVerseTwoEqMid, gkVerseTwoEqHigh

  outleta "OutL", aVerseTwoL
  outleta "OutR", aVerseTwoR
endin

