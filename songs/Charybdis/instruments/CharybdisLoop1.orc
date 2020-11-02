instrumentRoute "CharybdisLoop1", "DelayForCharybdisLoop1Input"
alwayson "CharybdisLoop1MixerChannel"

gkCharybdisLoop1EqBass init 1
gkCharybdisLoop1EqMid init 1
gkCharybdisLoop1EqHigh init 1
gkCharybdisLoop1Fader init 1
gkCharybdisLoop1Pan init 50

gSCharybdisLoop1SamplePath = "localSamples/cannedHeatLoop1.wav"
giCharybdisLoop1SampleChannels filenchnls gSCharybdisLoop1SamplePath
giCharybdisLoop1SampleLength filelen gSCharybdisLoop1SamplePath
giCharybdisLoop1SampleLengthInBeats = 6
giCharybdisLoop1LengthOfBeat = giCharybdisLoop1SampleLength / giCharybdisLoop1SampleLengthInBeats
giCharybdisLoop1LengthBPM init 60 /giCharybdisLoop1LengthOfBeat
giCharybdisLoop1LengthOfBeatFactor = i(gkBPM) / giCharybdisLoop1LengthBPM

if giCharybdisLoop1SampleChannels = 2 then
  giCharybdisLoop1SampleL ftgen 0, 0, 0, 1, gSCharybdisLoop1SamplePath, 0, 0, 1
  giCharybdisLoop1SampleR ftgen 0, 0, 0, 1, gSCharybdisLoop1SamplePath, 0, 0, 2
else
  giCharybdisLoop1Sample ftgen 0, 0, 0, 1, gSCharybdisLoop1SamplePath, 0, 0, 0
endif

instr CharybdisLoop1
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giCharybdisLoop1SampleLength * p5 * giCharybdisLoop1LengthOfBeatFactor

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giCharybdisLoop1SampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giCharybdisLoop1SampleLengthInBeats

  if giCharybdisLoop1SampleChannels = 2 then
    aCharybdisLoop1R poscil kAmplitudeEnvelope, kPitch, giCharybdisLoop1SampleR, iStartTime
    aCharybdisLoop1L poscil kAmplitudeEnvelope, kPitch, giCharybdisLoop1SampleL, iStartTime
  else
    aCharybdisLoop1L poscil kAmplitudeEnvelope, kPitch, giCharybdisLoop1Sample, iStartTime
    aCharybdisLoop1R = aCharybdisLoop1L
  endif

  outleta "OutL", aCharybdisLoop1L
  outleta "OutR", aCharybdisLoop1R
endin

instr CharybdisLoop1BassKnob
  gkCharybdisLoop1EqBass linseg p4, p3, p5
endin

instr CharybdisLoop1MidKnob
  gkCharybdisLoop1EqMid linseg p4, p3, p5
endin

instr CharybdisLoop1HighKnob
  gkCharybdisLoop1EqHigh linseg p4, p3, p5
endin

instr CharybdisLoop1Fader
  gkCharybdisLoop1Fader linseg p4, p3, p5
endin

instr CharybdisLoop1Pan
  gkCharybdisLoop1Pan linseg p4, p3, p5
endin

instr CharybdisLoop1MixerChannel
  aCharybdisLoop1L inleta "InL"
  aCharybdisLoop1R inleta "InR"

  aCharybdisLoop1L, aCharybdisLoop1R mixerChannel aCharybdisLoop1L, aCharybdisLoop1R, gkCharybdisLoop1Fader, gkCharybdisLoop1Pan, gkCharybdisLoop1EqBass, gkCharybdisLoop1EqMid, gkCharybdisLoop1EqHigh

  outleta "OutL", aCharybdisLoop1L
  outleta "OutR", aCharybdisLoop1R
endin

