instrumentRoute "DefaultCowbell", "DefaultDrumKitBus"

alwayson "DefaultCowbellMixerChannel"

gkDefaultCowbellEqBass init 1.3
gkDefaultCowbellEqMid init 1
gkDefaultCowbellEqHigh init 1
gkDefaultCowbellFader init 1
gkDefaultCowbellPan init 25

gSDefaultCowbellSamplePath = "localSamples/Drums/Qdrums_Cowbell_EA9012.wav"
giDefaultCowbellSample ftgen 0, 0, 0, 1, gSDefaultCowbellSamplePath, 0, 0, 0

instr DefaultCowbell
  aDefaultCowbellL, aDefaultCowbellR drumSample giDefaultCowbellSample, p4, p5

  outleta "OutL", aDefaultCowbellL
  outleta "OutR", aDefaultCowbellR
endin

instr DefaultCowbellBassKnob
  gkDefaultCowbellEqBass linseg p4, p3, p5
endin

instr DefaultCowbellMidKnob
  gkDefaultCowbellEqMid linseg p4, p3, p5
endin

instr DefaultCowbellHighKnob
  gkDefaultCowbellEqHigh linseg p4, p3, p5
endin

instr DefaultCowbellFader
  gkDefaultCowbellFader linseg p4, p3, p5
endin

instr DefaultCowbellPan
  gkDefaultCowbellPan linseg p4, p3, p5
endin

instr DefaultCowbellMixerChannel
  aDefaultCowbellL inleta "InL"
  aDefaultCowbellR inleta "InR"

  aDefaultCowbellL, aDefaultCowbellR mixerChannel aDefaultCowbellL, aDefaultCowbellR, gkDefaultCowbellFader, gkDefaultCowbellPan, gkDefaultCowbellEqBass, gkDefaultCowbellEqMid, gkDefaultCowbellEqHigh

  outleta "OutL", aDefaultCowbellL
  outleta "OutR", aDefaultCowbellR
endin
