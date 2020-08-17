instrumentRoute "IntroLoop3", "FreezerInput"
alwayson "IntroLoop3MixerChannel"

gkIntroLoop3EqBass init 1
gkIntroLoop3EqMid init 1
gkIntroLoop3EqHigh init 1
gkIntroLoop3Fader init 1
gkIntroLoop3Pan init 50

gSIntroLoop3SamplePath = "localSamples/Lifestyle - This Dream/IntroLoop3.wav"
giIntroLoop3SampleChannels filenchnls gSIntroLoop3SamplePath
giIntroLoop3SampleLength filelen gSIntroLoop3SamplePath
giIntroLoop3SampleLengthInBeats = 4
giIntroLoop3LengthOfBeat = giIntroLoop3SampleLength / giIntroLoop3SampleLengthInBeats
giIntroLoop3LengthBPM init 60 /giIntroLoop3LengthOfBeat
giIntroLoop3LengthOfBeatFactor = i(gkBPM) / giIntroLoop3LengthBPM

if giIntroLoop3SampleChannels = 2 then
  giIntroLoop3SampleL ftgen 0, 0, 0, 1, gSIntroLoop3SamplePath, 0, 0, 1
  giIntroLoop3SampleR ftgen 0, 0, 0, 1, gSIntroLoop3SamplePath, 0, 0, 2
else
  giIntroLoop3Sample ftgen 0, 0, 0, 1, gSIntroLoop3SamplePath, 0, 0, 0
endif

instr IntroLoop3
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giIntroLoop3SampleLength * p5 * giIntroLoop3LengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giIntroLoop3SampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giIntroLoop3SampleLengthInBeats

  if giIntroLoop3SampleChannels = 2 then
    aIntroLoop3R poscil kAmplitudeEnvelope, kPitch, giIntroLoop3SampleR, iStartTime
    aIntroLoop3L poscil kAmplitudeEnvelope, kPitch, giIntroLoop3SampleL, iStartTime
  else
    aIntroLoop3L poscil kAmplitudeEnvelope, kPitch, giIntroLoop3Sample, iStartTime
    aIntroLoop3R = aIntroLoop3L
  endif

  outleta "OutL", aIntroLoop3L
  outleta "OutR", aIntroLoop3R
endin

instr IntroLoop3BassKnob
  gkIntroLoop3EqBass linseg p4, p3, p5
endin

instr IntroLoop3MidKnob
  gkIntroLoop3EqMid linseg p4, p3, p5
endin

instr IntroLoop3HighKnob
  gkIntroLoop3EqHigh linseg p4, p3, p5
endin

instr IntroLoop3Fader
  gkIntroLoop3Fader linseg p4, p3, p5
endin

instr IntroLoop3Pan
  gkIntroLoop3Pan linseg p4, p3, p5
endin

instr IntroLoop3MixerChannel
  aIntroLoop3L inleta "InL"
  aIntroLoop3R inleta "InR"

  aIntroLoop3L, aIntroLoop3R mixerChannel aIntroLoop3L, aIntroLoop3R, gkIntroLoop3Fader, gkIntroLoop3Pan, gkIntroLoop3EqBass, gkIntroLoop3EqMid, gkIntroLoop3EqHigh

  outleta "OutL", aIntroLoop3L
  outleta "OutR", aIntroLoop3R
endin

