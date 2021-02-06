instrumentRoute "Riff1", "Mixer"
alwayson "Riff1MixerChannel"

gkRiff1EqBass init 1
gkRiff1EqMid init 1
gkRiff1EqHigh init 1
gkRiff1Fader init 1
gkRiff1Pan init 50

gSRiff1SamplePath = "localSamples/GodRootUntitledSong/riff1.wav"
giRiff1SampleChannels filenchnls gSRiff1SamplePath
giRiff1SampleLength filelen gSRiff1SamplePath
giRiff1SampleLengthInBeats = 3
giRiff1LengthOfBeat = giRiff1SampleLength / giRiff1SampleLengthInBeats
giRiff1LengthBPM init 60 /giRiff1LengthOfBeat
giRiff1LengthOfBeatFactor = i(gkBPM) / giRiff1LengthBPM

if giRiff1SampleChannels = 2 then
  giRiff1SampleL ftgen 0, 0, 0, 1, gSRiff1SamplePath, 0, 0, 1
  giRiff1SampleR ftgen 0, 0, 0, 1, gSRiff1SamplePath, 0, 0, 2
else
  giRiff1Sample ftgen 0, 0, 0, 1, gSRiff1SamplePath, 0, 0, 0
endif

instr Riff1
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giRiff1SampleLength * p5 * giRiff1LengthOfBeatFactor

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giRiff1SampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .01) * iAmplitude
  iStartTime = iStartBeat / giRiff1SampleLengthInBeats

  if giRiff1SampleChannels = 2 then
    aRiff1R poscil kAmplitudeEnvelope, kPitch, giRiff1SampleR, iStartTime
    aRiff1L poscil kAmplitudeEnvelope, kPitch, giRiff1SampleL, iStartTime
  else
    aRiff1L poscil kAmplitudeEnvelope, kPitch, giRiff1Sample, iStartTime
    aRiff1R = aRiff1L
  endif

  outleta "OutL", aRiff1L
  outleta "OutR", aRiff1R
endin

instr Riff1BassKnob
  gkRiff1EqBass linseg p4, p3, p5
endin

instr Riff1MidKnob
  gkRiff1EqMid linseg p4, p3, p5
endin

instr Riff1HighKnob
  gkRiff1EqHigh linseg p4, p3, p5
endin

instr Riff1Fader
  gkRiff1Fader linseg p4, p3, p5
endin

instr Riff1Pan
  gkRiff1Pan linseg p4, p3, p5
endin

instr Riff1MixerChannel
  aRiff1L inleta "InL"
  aRiff1R inleta "InR"

  aRiff1L, aRiff1R mixerChannel aRiff1L, aRiff1R, gkRiff1Fader, gkRiff1Pan, gkRiff1EqBass, gkRiff1EqMid, gkRiff1EqHigh

  outleta "OutL", aRiff1L
  outleta "OutR", aRiff1R
endin

