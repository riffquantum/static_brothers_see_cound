instrumentRoute "Snare", "DistortionForSnareInput"

alwayson "SnareMixerChannel"

gkSnareEqBass init 1.3
gkSnareEqMid init 1
gkSnareEqHigh init 1
gkSnareFader init 1
gkSnarePan init 45

gSSnareSamplePath = "localSamples/Drums/Funk-Kit_Snare_EA8141.wav"
giSnareSample ftgen 0, 0, 0, 1, gSSnareSamplePath, 0, 0, 0

instr Snare
  aSnareL, aSnareR drumSample giSnareSample, p4, p5

  outleta "OutL", aSnareL
  outleta "OutR", aSnareR
endin

instr SnareBassKnob
  gkSnareEqBass linseg p4, p3, p5
endin

instr SnareMidKnob
  gkSnareEqMid linseg p4, p3, p5
endin

instr SnareHighKnob
  gkSnareEqHigh linseg p4, p3, p5
endin

instr SnareFader
  gkSnareFader linseg p4, p3, p5
endin

instr SnarePan
  gkSnarePan linseg p4, p3, p5
endin

instr SnareMixerChannel
  aSnareL inleta "InL"
  aSnareR inleta "InR"

  aSnareL, aSnareR mixerChannel aSnareL, aSnareR, gkSnareFader, gkSnarePan, gkSnareEqBass, gkSnareEqMid, gkSnareEqHigh

  outleta "OutL", aSnareL
  outleta "OutR", aSnareR
endin
