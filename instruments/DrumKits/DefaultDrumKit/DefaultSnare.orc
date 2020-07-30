instrumentRoute "DefaultSnare", "DefaultDrumKitBus"

alwayson "DefaultSnareMixerChannel"

gkDefaultSnareEqBass init 1.3
gkDefaultSnareEqMid init 1
gkDefaultSnareEqHigh init 1
gkDefaultSnareFader init 1
gkDefaultSnarePan init 45

gSDefaultSnareSamplePath = "localSamples/Drums/Mixed-Drums_Snare_EA8512.wav"
giDefaultSnareSample ftgen 0, 0, 0, 1, gSDefaultSnareSamplePath, 0, 0, 0

instr DefaultSnare
  aDefaultSnareL, aDefaultSnareR drumSample giDefaultSnareSample, p4, p5

  outleta "OutL", aDefaultSnareL
  outleta "OutR", aDefaultSnareR
endin

instr DefaultSnareBassKnob
  gkDefaultSnareEqBass linseg p4, p3, p5
endin

instr DefaultSnareMidKnob
  gkDefaultSnareEqMid linseg p4, p3, p5
endin

instr DefaultSnareHighKnob
  gkDefaultSnareEqHigh linseg p4, p3, p5
endin

instr DefaultSnareFader
  gkDefaultSnareFader linseg p4, p3, p5
endin

instr DefaultSnarePan
  gkDefaultSnarePan linseg p4, p3, p5
endin

instr DefaultSnareMixerChannel
  aDefaultSnareL inleta "InL"
  aDefaultSnareR inleta "InR"

  aDefaultSnareL, aDefaultSnareR mixerChannel aDefaultSnareL, aDefaultSnareR, gkDefaultSnareFader, gkDefaultSnarePan, gkDefaultSnareEqBass, gkDefaultSnareEqMid, gkDefaultSnareEqHigh

  outleta "OutL", aDefaultSnareL
  outleta "OutR", aDefaultSnareR
endin
