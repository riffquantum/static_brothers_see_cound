instrumentRoute "DefaultTomMid", "DefaultDrumKitBus"

alwayson "DefaultTomMidMixerChannel"

gkDefaultTomMidEqBass init 1
gkDefaultTomMidEqMid init 1
gkDefaultTomMidEqHigh init 1
gkDefaultTomMidFader init 1
gkDefaultTomMidPan init 60

gSDefaultTomMidSamplePath = "localSamples/Drums/R8-Drums_Tom_E7662.wav"
giDefaultTomMidSample ftgen 0, 0, 0, 1, gSDefaultTomMidSamplePath, 0, 0, 0

instr DefaultTomMid
  aOutL, aOutR drumSample giDefaultTomMidSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr DefaultTomMidBassKnob
    gkDefaultTomMidEqBass linseg p4, p3, p5
endin

instr DefaultTomMidMidKnob
    gkDefaultTomMidEqMid linseg p4, p3, p5
endin

instr DefaultTomMidHighKnob
    gkDefaultTomMidEqHigh linseg p4, p3, p5
endin

instr DefaultTomMidFader
    gkDefaultTomMidFader linseg p4, p3, p5
endin

instr DefaultTomMidPan
    gkDefaultTomMidPan linseg p4, p3, p5
endin

instr DefaultTomMidMixerChannel
  aDefaultTomMidL inleta "InL"
  aDefaultTomMidR inleta "InR"

  aDefaultTomMidL, aDefaultTomMidR mixerChannel aDefaultTomMidL, aDefaultTomMidR, gkDefaultTomMidFader, gkDefaultTomMidPan, gkDefaultTomMidEqBass, gkDefaultTomMidEqMid, gkDefaultTomMidEqHigh

  outleta "OutL", aDefaultTomMidL
  outleta "OutR", aDefaultTomMidR
endin
