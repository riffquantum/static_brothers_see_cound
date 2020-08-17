instrumentRoute "Ooo", "FreezerInput"
alwayson "OooMixerChannel"

gkOooEqBass init 1
gkOooEqMid init 1
gkOooEqHigh init 1
gkOooFader init 1
gkOooPan init 50

gSOooSamplePath = "localSamples/Lifestyle - This Dream/Ooo.wav"
giOooSampleChannels filenchnls gSOooSamplePath
giOooSampleLength filelen gSOooSamplePath
giOooSampleLengthInBeats = 4
giOooLengthOfBeat = giOooSampleLength / giOooSampleLengthInBeats
giOooLengthBPM init 60 /giOooLengthOfBeat
giOooLengthOfBeatFactor = i(gkBPM) / giOooLengthBPM

if giOooSampleChannels = 2 then
  giOooSampleL ftgen 0, 0, 0, 1, gSOooSamplePath, 0, 0, 1
  giOooSampleR ftgen 0, 0, 0, 1, gSOooSamplePath, 0, 0, 2
else
  giOooSample ftgen 0, 0, 0, 1, gSOooSamplePath, 0, 0, 0
endif

instr Ooo
  iAmplitude = velocityToAmplitude(p4)
  kPitch = 1 / giOooSampleLength * p5 * giOooLengthOfBeatFactor

  ; kPitch += oscil(.0025, p3/2 )

  iStartBeat = p6
  iEndBeat = p7 == 0 ? giOooSampleLengthInBeats : p7
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = iStartBeat / giOooSampleLengthInBeats

  if giOooSampleChannels = 2 then
    aOooR poscil kAmplitudeEnvelope, kPitch, giOooSampleR, iStartTime
    aOooL poscil kAmplitudeEnvelope, kPitch, giOooSampleL, iStartTime
  else
    aOooL poscil kAmplitudeEnvelope, kPitch, giOooSample, iStartTime
    aOooR = aOooL
  endif

  outleta "OutL", aOooL
  outleta "OutR", aOooR
endin

instr OooBassKnob
  gkOooEqBass linseg p4, p3, p5
endin

instr OooMidKnob
  gkOooEqMid linseg p4, p3, p5
endin

instr OooHighKnob
  gkOooEqHigh linseg p4, p3, p5
endin

instr OooFader
  gkOooFader linseg p4, p3, p5
endin

instr OooPan
  gkOooPan linseg p4, p3, p5
endin

instr OooMixerChannel
  aOooL inleta "InL"
  aOooR inleta "InR"

  aOooL, aOooR mixerChannel aOooL, aOooR, gkOooFader, gkOooPan, gkOooEqBass, gkOooEqMid, gkOooEqHigh

  outleta "OutL", aOooL
  outleta "OutR", aOooR
endin

