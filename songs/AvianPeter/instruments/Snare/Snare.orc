stereoRoute "SnareMixerChannel", "DrumKitBus"
alwayson "SnareMixerChannel"

gkSnareEqBass init 1
gkSnareEqMid init 1
gkSnareEqHigh init 1
gkSnareFader init .75
gkSnarePan init 50

instr Snare
  iSupressNoise = p6

  event_i "i", "DefaultSnare", 0, p3, p4, p5

  if iSupressNoise == 0 then
    event_i "i", "PhotoshopSamples", 0, 1, p4, 8
  endif
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
