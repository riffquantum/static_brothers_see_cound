instrumentRoute "TriplePortraitLoop1", "Mixer"
alwayson "TriplePortraitLoop1MixerChannel"

gkTriplePortraitLoop1EqBass init 2
gkTriplePortraitLoop1EqMid init 1
gkTriplePortraitLoop1EqHigh init 1
gkTriplePortraitLoop1Fader init 1
gkTriplePortraitLoop1Pan init 50

gSTriplePortraitLoop1SamplePath = "localSamples/TriplePortraitLoop1.wav"
giTriplePortraitLoop1SampleChannels filenchnls gSTriplePortraitLoop1SamplePath
giTriplePortraitLoop1SampleLength filelen gSTriplePortraitLoop1SamplePath
giTriplePortraitLoop1SampleLengthInBeats = 2
giTriplePortraitLoop1LengthOfBeat = giTriplePortraitLoop1SampleLength / giTriplePortraitLoop1SampleLengthInBeats
giTriplePortraitLoop1LengthBPM init 60 /giTriplePortraitLoop1LengthOfBeat
giTriplePortraitLoop1LengthOfBeatFactor = i(gkBPM) / giTriplePortraitLoop1LengthBPM

if giTriplePortraitLoop1SampleChannels = 2 then
  giTriplePortraitLoop1SampleL ftgen 0, 0, 0, 1, gSTriplePortraitLoop1SamplePath, 0, 0, 1
  giTriplePortraitLoop1SampleR ftgen 0, 0, 0, 1, gSTriplePortraitLoop1SamplePath, 0, 0, 2
else
  giTriplePortraitLoop1Sample ftgen 0, 0, 0, 1, gSTriplePortraitLoop1SamplePath, 0, 0, 0
endif

instr TriplePortraitLoop1
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giTriplePortraitLoop1SampleLength * p5 * giTriplePortraitLoop1LengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giTriplePortraitLoop1SampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = (iStartBeat / giTriplePortraitLoop1SampleLengthInBeats) + 0.22

  if giTriplePortraitLoop1SampleChannels = 2 then
    aTriplePortraitLoop1R poscil kAmplitudeEnvelope, kPitch, giTriplePortraitLoop1SampleR, iStartTime
    aTriplePortraitLoop1L poscil kAmplitudeEnvelope, kPitch, giTriplePortraitLoop1SampleL, iStartTime
  else
    aTriplePortraitLoop1L poscil kAmplitudeEnvelope, kPitch, giTriplePortraitLoop1Sample, iStartTime
    aTriplePortraitLoop1R = aTriplePortraitLoop1L
  endif

  outleta "OutL", aTriplePortraitLoop1L
  outleta "OutR", aTriplePortraitLoop1R
endin

instr TriplePortraitLoop1BassKnob
  gkTriplePortraitLoop1EqBass linseg p4, p3, p5
endin

instr TriplePortraitLoop1MidKnob
  gkTriplePortraitLoop1EqMid linseg p4, p3, p5
endin

instr TriplePortraitLoop1HighKnob
  gkTriplePortraitLoop1EqHigh linseg p4, p3, p5
endin

instr TriplePortraitLoop1Fader
  gkTriplePortraitLoop1Fader linseg p4, p3, p5
endin

instr TriplePortraitLoop1Pan
  gkTriplePortraitLoop1Pan linseg p4, p3, p5
endin

instr TriplePortraitLoop1MixerChannel
  aTriplePortraitLoop1L inleta "InL"
  aTriplePortraitLoop1R inleta "InR"

  kTriplePortraitLoop1Fader = gkTriplePortraitLoop1Fader
  kTriplePortraitLoop1Pan = gkTriplePortraitLoop1Pan
  kTriplePortraitLoop1EqBass = gkTriplePortraitLoop1EqBass
  kTriplePortraitLoop1EqMid = gkTriplePortraitLoop1EqMid
  kTriplePortraitLoop1EqHigh = gkTriplePortraitLoop1EqHigh

  aTriplePortraitLoop1L, aTriplePortraitLoop1R threeBandEqStereo aTriplePortraitLoop1L, aTriplePortraitLoop1R, kTriplePortraitLoop1EqBass, kTriplePortraitLoop1EqMid, kTriplePortraitLoop1EqHigh

  if kTriplePortraitLoop1Pan > 100 then
      kTriplePortraitLoop1Pan = 100
  elseif kTriplePortraitLoop1Pan < 0 then
      kTriplePortraitLoop1Pan = 0
  endif

  aTriplePortraitLoop1L = (aTriplePortraitLoop1L * ((100 - kTriplePortraitLoop1Pan) * 2 / 100)) * kTriplePortraitLoop1Fader
  aTriplePortraitLoop1R = (aTriplePortraitLoop1R * (kTriplePortraitLoop1Pan * 2 / 100)) * kTriplePortraitLoop1Fader

  outleta "OutL", aTriplePortraitLoop1L
  outleta "OutR", aTriplePortraitLoop1R
endin

