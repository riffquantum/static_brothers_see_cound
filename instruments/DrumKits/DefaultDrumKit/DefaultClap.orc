instrumentRoute "DefaultClap", "DefaultDrumKitBus"

alwayson "DefaultClapMixerChannel"

gkDefaultClapEqBass init 1.3
gkDefaultClapEqMid init 1
gkDefaultClapEqHigh init 1
gkDefaultClapFader init 1
gkDefaultClapPan init 50

gSDefaultClapSamplePath = "localSamples/Drums/FL-Studio-Defaults_Clap_1.wav"
giDefaultClapSample ftgen 0, 0, 0, 1, gSDefaultClapSamplePath, 0, 0, 0

instr DefaultClap
  aDefaultClapL, aDefaultClapR drumSample giDefaultClapSample, p4, p5

  outleta "OutL", aDefaultClapL
  outleta "OutR", aDefaultClapR
endin

instr DefaultClapBassKnob
  gkDefaultClapEqBass linseg p4, p3, p5
endin

instr DefaultClapMidKnob
  gkDefaultClapEqMid linseg p4, p3, p5
endin

instr DefaultClapHighKnob
  gkDefaultClapEqHigh linseg p4, p3, p5
endin

instr DefaultClapFader
  gkDefaultClapFader linseg p4, p3, p5
endin

instr DefaultClapPan
  gkDefaultClapPan linseg p4, p3, p5
endin

instr DefaultClapMixerChannel
  aDefaultClapL inleta "InL"
  aDefaultClapR inleta "InR"

  aDefaultClapL, aDefaultClapR mixerChannel aDefaultClapL, aDefaultClapR, gkDefaultClapFader, gkDefaultClapPan, gkDefaultClapEqBass, gkDefaultClapEqMid, gkDefaultClapEqHigh

  outleta "OutL", aDefaultClapL
  outleta "OutR", aDefaultClapR
endin
