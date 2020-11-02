instrumentRoute "DustyBass", "Mixer"
alwayson "DustyBassMixerChannel"

gkDustyBassEqBass init 1
gkDustyBassEqMid init 1
gkDustyBassEqHigh init 1
gkDustyBassFader init 1
gkDustyBassPan init 50

gSDustyBassSamplePath = "localSamples/cannedHeatDustyBass.wav"
giDustyBassSampleChannels filenchnls gSDustyBassSamplePath
giDustyBassSampleLength filelen gSDustyBassSamplePath

if giDustyBassSampleChannels = 2 then
  giDustyBassSampleL ftgen 0, 0, 0, 1, gSDustyBassSamplePath, 0, 0, 1
  giDustyBassSampleR ftgen 0, 0, 0, 1, gSDustyBassSamplePath, 0, 0, 2
else
  giDustyBassSample ftgen 0, 0, 0, 1, gSDustyBassSamplePath, 0, 0, 0
endif

instr DustyBass
  iAmplitude = flexibleAmplitudeInput(p4)
  kPitch = 1 / giDustyBassSampleLength * (flexiblePitchInput(p5)/261)

  kAmplitudeEnvelope = madsr(.005, .01, 1, .1) * iAmplitude
  iStartTime = p6 + .23
  iEndBeat = p7

  if giDustyBassSampleChannels = 2 then
    aDustyBassR poscil kAmplitudeEnvelope, kPitch, giDustyBassSampleR, iStartTime
    aDustyBassL poscil kAmplitudeEnvelope, kPitch, giDustyBassSampleL, iStartTime
  else
    aDustyBassL poscil kAmplitudeEnvelope, kPitch, giDustyBassSample, iStartTime
    aDustyBassR = aDustyBassL
  endif

  outleta "OutL", aDustyBassL
  outleta "OutR", aDustyBassR
endin

instr DustyBassBassKnob
  gkDustyBassEqBass linseg p4, p3, p5
endin

instr DustyBassMidKnob
  gkDustyBassEqMid linseg p4, p3, p5
endin

instr DustyBassHighKnob
  gkDustyBassEqHigh linseg p4, p3, p5
endin

instr DustyBassFader
  gkDustyBassFader linseg p4, p3, p5
endin

instr DustyBassPan
  gkDustyBassPan linseg p4, p3, p5
endin

instr DustyBassMixerChannel
  aDustyBassL inleta "InL"
  aDustyBassR inleta "InR"

  aDustyBassL, aDustyBassR mixerChannel aDustyBassL, aDustyBassR, gkDustyBassFader, gkDustyBassPan, gkDustyBassEqBass, gkDustyBassEqMid, gkDustyBassEqHigh

  outleta "OutL", aDustyBassL
  outleta "OutR", aDustyBassR
endin

