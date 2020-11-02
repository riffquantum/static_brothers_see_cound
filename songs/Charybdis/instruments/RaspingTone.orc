instrumentRoute "RaspingTone", "ChorusForRaspingToneInput"
alwayson "RaspingToneMixerChannel"

gkRaspingToneEqBass init 1
gkRaspingToneEqMid init 1
gkRaspingToneEqHigh init 1
gkRaspingToneFader init 1
gkRaspingTonePan init 50

gSRaspingToneSamplePath = "localSamples/cannedHeatNoise1.wav"
giRaspingToneSampleChannels filenchnls gSRaspingToneSamplePath
giRaspingToneSampleLength filelen gSRaspingToneSamplePath

if giRaspingToneSampleChannels = 2 then
  giRaspingToneSampleL ftgen 0, 0, 0, 1, gSRaspingToneSamplePath, 0, 0, 1
  giRaspingToneSampleR ftgen 0, 0, 0, 1, gSRaspingToneSamplePath, 0, 0, 2
else
  giRaspingToneSample ftgen 0, 0, 0, 1, gSRaspingToneSamplePath, 0, 0, 0
endif

instr RaspingTone
  iAmplitude = flexibleAmplitudeInput(p4)
  kPitch = 1 / giStabSampleLength * (flexiblePitchInput(p5)/261)

  iStartTime = .1
  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude

  if giRaspingToneSampleChannels = 2 then
    aRaspingToneR poscil kAmplitudeEnvelope, kPitch, giRaspingToneSampleR, iStartTime
    aRaspingToneL poscil kAmplitudeEnvelope, kPitch, giRaspingToneSampleL, iStartTime
  else
    aRaspingToneL poscil kAmplitudeEnvelope, kPitch, giRaspingToneSample, iStartTime
    aRaspingToneR = aRaspingToneL
  endif

  outleta "OutL", aRaspingToneR
  outleta "OutR", aRaspingToneR
endin

instr RaspingToneBassKnob
  gkRaspingToneEqBass linseg p4, p3, p5
endin

instr RaspingToneMidKnob
  gkRaspingToneEqMid linseg p4, p3, p5
endin

instr RaspingToneHighKnob
  gkRaspingToneEqHigh linseg p4, p3, p5
endin

instr RaspingToneFader
  gkRaspingToneFader linseg p4, p3, p5
endin

instr RaspingTonePan
  gkRaspingTonePan linseg p4, p3, p5
endin

instr RaspingToneMixerChannel
  aRaspingToneL inleta "InL"
  aRaspingToneR inleta "InR"

  aRaspingToneL, aRaspingToneR mixerChannel aRaspingToneL, aRaspingToneR, gkRaspingToneFader, gkRaspingTonePan, gkRaspingToneEqBass, gkRaspingToneEqMid, gkRaspingToneEqHigh

  outleta "OutL", aRaspingToneL
  outleta "OutR", aRaspingToneR
endin

