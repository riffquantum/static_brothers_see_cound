instrumentRoute "Stab", "Mixer"
alwayson "StabMixerChannel"

gkStabEqBass init 1
gkStabEqMid init 1
gkStabEqHigh init 1
gkStabFader init 1
gkStabPan init 50

gSStabSamplePath = "localSamples/cannedHeatStabWithNoise.wav"
giStabSampleChannels filenchnls gSStabSamplePath
giStabSampleLength filelen gSStabSamplePath

if giStabSampleChannels = 2 then
  giStabSampleL ftgen 0, 0, 0, 1, gSStabSamplePath, 0, 0, 1
  giStabSampleR ftgen 0, 0, 0, 1, gSStabSamplePath, 0, 0, 2
else
  giStabSample ftgen 0, 0, 0, 1, gSStabSamplePath, 0, 0, 0
endif

instr Stab
  iAmplitude = flexibleAmplitudeInput(p4)
  kPitch = 1 / giStabSampleLength * (flexiblePitchInput(p5)/261)

  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = p6
  iEndBeat = p7

  if giStabSampleChannels = 2 then
    aStabR poscil kAmplitudeEnvelope, kPitch, giStabSampleR, iStartTime
    aStabL poscil kAmplitudeEnvelope, kPitch, giStabSampleL, iStartTime
  else
    aStabL poscil kAmplitudeEnvelope, kPitch, giStabSample, iStartTime
    aStabR = aStabL
  endif

  outleta "OutL", aStabL
  outleta "OutR", aStabR
endin

instr StabBassKnob
  gkStabEqBass linseg p4, p3, p5
endin

instr StabMidKnob
  gkStabEqMid linseg p4, p3, p5
endin

instr StabHighKnob
  gkStabEqHigh linseg p4, p3, p5
endin

instr StabFader
  gkStabFader linseg p4, p3, p5
endin

instr StabPan
  gkStabPan linseg p4, p3, p5
endin

instr StabMixerChannel
  aStabL inleta "InL"
  aStabR inleta "InR"

  aStabL, aStabR mixerChannel aStabL, aStabR, gkStabFader, gkStabPan, gkStabEqBass, gkStabEqMid, gkStabEqHigh

  outleta "OutL", aStabL
  outleta "OutR", aStabR
endin

