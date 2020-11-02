instrumentRoute "CharybdisLoop2", "Mixer"
alwayson "CharybdisLoop2MixerChannel"

gkCharybdisLoop2EqBass init 1
gkCharybdisLoop2EqMid init 1
gkCharybdisLoop2EqHigh init 1
gkCharybdisLoop2Fader init 1
gkCharybdisLoop2Pan init 50

gSCharybdisLoop2SamplePath = "localSamples/cannedHeatLoop2.wav"
giCharybdisLoop2SampleChannels filenchnls gSCharybdisLoop2SamplePath
giCharybdisLoop2SampleLength filelen gSCharybdisLoop2SamplePath
giCharybdisLoop2SampleLengthInBeats = 6
giCharybdisLoop2LengthOfBeat = giCharybdisLoop2SampleLength / giCharybdisLoop2SampleLengthInBeats
giCharybdisLoop2LengthBPM init 60 /giCharybdisLoop2LengthOfBeat
giCharybdisLoop2LengthOfBeatFactor = i(gkBPM) / giCharybdisLoop2LengthBPM

if giCharybdisLoop2SampleChannels = 2 then
  giCharybdisLoop2SampleL ftgen 0, 0, 0, 1, gSCharybdisLoop2SamplePath, 0, 0, 1
  giCharybdisLoop2SampleR ftgen 0, 0, 0, 1, gSCharybdisLoop2SamplePath, 0, 0, 2
else
  giCharybdisLoop2Sample ftgen 0, 0, 0, 1, gSCharybdisLoop2SamplePath, 0, 0, 0
endif

instr CharybdisLoop2
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giCharybdisLoop2SampleLength * p5 * giCharybdisLoop2LengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giCharybdisLoop2SampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giCharybdisLoop2SampleLengthInBeats

  if giCharybdisLoop2SampleChannels = 2 then
    aCharybdisLoop2R poscil kAmplitudeEnvelope, kPitch, giCharybdisLoop2SampleR, iStartTime
    aCharybdisLoop2L poscil kAmplitudeEnvelope, kPitch, giCharybdisLoop2SampleL, iStartTime
  else
    aCharybdisLoop2L poscil kAmplitudeEnvelope, kPitch, giCharybdisLoop2Sample, iStartTime
    aCharybdisLoop2R = aCharybdisLoop2L
  endif

  outleta "OutL", aCharybdisLoop2L
  outleta "OutR", aCharybdisLoop2R
endin

instr CharybdisLoop2BassKnob
  gkCharybdisLoop2EqBass linseg p4, p3, p5
endin

instr CharybdisLoop2MidKnob
  gkCharybdisLoop2EqMid linseg p4, p3, p5
endin

instr CharybdisLoop2HighKnob
  gkCharybdisLoop2EqHigh linseg p4, p3, p5
endin

instr CharybdisLoop2Fader
  gkCharybdisLoop2Fader linseg p4, p3, p5
endin

instr CharybdisLoop2Pan
  gkCharybdisLoop2Pan linseg p4, p3, p5
endin

instr CharybdisLoop2MixerChannel
  aCharybdisLoop2L inleta "InL"
  aCharybdisLoop2R inleta "InR"

  aCharybdisLoop2L, aCharybdisLoop2R mixerChannel aCharybdisLoop2L, aCharybdisLoop2R, gkCharybdisLoop2Fader, gkCharybdisLoop2Pan, gkCharybdisLoop2EqBass, gkCharybdisLoop2EqMid, gkCharybdisLoop2EqHigh

  outleta "OutL", aCharybdisLoop2L
  outleta "OutR", aCharybdisLoop2R
endin

