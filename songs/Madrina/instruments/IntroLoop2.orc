instrumentRoute "IntroLoop2", "FreezerInput"
alwayson "IntroLoop2MixerChannel"

gkIntroLoop2EqBass init 1
gkIntroLoop2EqMid init 1
gkIntroLoop2EqHigh init 1
gkIntroLoop2Fader init 1
gkIntroLoop2Pan init 50

gSIntroLoop2SamplePath = "localSamples/Lifestyle - This Dream/IntroLoop2.wav"
giIntroLoop2SampleChannels filenchnls gSIntroLoop2SamplePath
giIntroLoop2SampleLength filelen gSIntroLoop2SamplePath
giIntroLoop2SampleLengthInBeats = 8
giIntroLoop2LengthOfBeat = giIntroLoop2SampleLength / giIntroLoop2SampleLengthInBeats
giIntroLoop2LengthBPM init 60 /giIntroLoop2LengthOfBeat
giIntroLoop2LengthOfBeatFactor = i(gkBPM) / giIntroLoop2LengthBPM

if giIntroLoop2SampleChannels = 2 then
  giIntroLoop2SampleL ftgen 0, 0, 0, 1, gSIntroLoop2SamplePath, 0, 0, 1
  giIntroLoop2SampleR ftgen 0, 0, 0, 1, gSIntroLoop2SamplePath, 0, 0, 2
else
  giIntroLoop2Sample ftgen 0, 0, 0, 1, gSIntroLoop2SamplePath, 0, 0, 0
endif

instr IntroLoop2
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giIntroLoop2SampleLength * p5 * giIntroLoop2LengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giIntroLoop2SampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giIntroLoop2SampleLengthInBeats

  if giIntroLoop2SampleChannels = 2 then
    aIntroLoop2R poscil kAmplitudeEnvelope, kPitch, giIntroLoop2SampleR, iStartTime
    aIntroLoop2L poscil kAmplitudeEnvelope, kPitch, giIntroLoop2SampleL, iStartTime
  else
    aIntroLoop2L poscil kAmplitudeEnvelope, kPitch, giIntroLoop2Sample, iStartTime
    aIntroLoop2R = aIntroLoop2L
  endif

  outleta "OutL", aIntroLoop2L
  outleta "OutR", aIntroLoop2R
endin

instr IntroLoop2BassKnob
  gkIntroLoop2EqBass linseg p4, p3, p5
endin

instr IntroLoop2MidKnob
  gkIntroLoop2EqMid linseg p4, p3, p5
endin

instr IntroLoop2HighKnob
  gkIntroLoop2EqHigh linseg p4, p3, p5
endin

instr IntroLoop2Fader
  gkIntroLoop2Fader linseg p4, p3, p5
endin

instr IntroLoop2Pan
  gkIntroLoop2Pan linseg p4, p3, p5
endin

instr IntroLoop2MixerChannel
  aIntroLoop2L inleta "InL"
  aIntroLoop2R inleta "InR"

  aIntroLoop2L, aIntroLoop2R mixerChannel aIntroLoop2L, aIntroLoop2R, gkIntroLoop2Fader, gkIntroLoop2Pan, gkIntroLoop2EqBass, gkIntroLoop2EqMid, gkIntroLoop2EqHigh

  outleta "OutL", aIntroLoop2L
  outleta "OutR", aIntroLoop2R
endin

