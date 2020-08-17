instrumentRoute "Guitar", "FreezerInput"
alwayson "GuitarMixerChannel"

gkGuitarEqBass init 1
gkGuitarEqMid init 1
gkGuitarEqHigh init 1
gkGuitarFader init 1
gkGuitarPan init 50

gSGuitarSamplePath = "localSamples/Lifestyle - This Dream/Guitar.wav"
giGuitarSampleChannels filenchnls gSGuitarSamplePath
giGuitarSampleLength filelen gSGuitarSamplePath
giGuitarSampleLengthInBeats = 4
giGuitarLengthOfBeat = giGuitarSampleLength / giGuitarSampleLengthInBeats
giGuitarLengthBPM init 60 /giGuitarLengthOfBeat
giGuitarLengthOfBeatFactor = i(gkBPM) / giGuitarLengthBPM

if giGuitarSampleChannels = 2 then
  giGuitarSampleL ftgen 0, 0, 0, 1, gSGuitarSamplePath, 0, 0, 1
  giGuitarSampleR ftgen 0, 0, 0, 1, gSGuitarSamplePath, 0, 0, 2
else
  giGuitarSample ftgen 0, 0, 0, 1, gSGuitarSamplePath, 0, 0, 0
endif

instr Guitar
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giGuitarSampleLength * p5 * giGuitarLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giGuitarSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giGuitarSampleLengthInBeats

  if giGuitarSampleChannels = 2 then
    aGuitarR poscil kAmplitudeEnvelope, kPitch, giGuitarSampleR, iStartTime
    aGuitarL poscil kAmplitudeEnvelope, kPitch, giGuitarSampleL, iStartTime
  else
    aGuitarL poscil kAmplitudeEnvelope, kPitch, giGuitarSample, iStartTime
    aGuitarR = aGuitarL
  endif

  outleta "OutL", aGuitarL
  outleta "OutR", aGuitarR
endin

instr GuitarBassKnob
  gkGuitarEqBass linseg p4, p3, p5
endin

instr GuitarMidKnob
  gkGuitarEqMid linseg p4, p3, p5
endin

instr GuitarHighKnob
  gkGuitarEqHigh linseg p4, p3, p5
endin

instr GuitarFader
  gkGuitarFader linseg p4, p3, p5
endin

instr GuitarPan
  gkGuitarPan linseg p4, p3, p5
endin

instr GuitarMixerChannel
  aGuitarL inleta "InL"
  aGuitarR inleta "InR"

  aGuitarL, aGuitarR mixerChannel aGuitarL, aGuitarR, gkGuitarFader, gkGuitarPan, gkGuitarEqBass, gkGuitarEqMid, gkGuitarEqHigh

  outleta "OutL", aGuitarL
  outleta "OutR", aGuitarR
endin

