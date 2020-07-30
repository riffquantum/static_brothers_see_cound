instrumentRoute "DefaultTomLow", "DefaultDrumKitBus"

alwayson "DefaultTomLowMixerChannel"

gkDefaultTomLowEqBass init 1
gkDefaultTomLowEqMid init 1
gkDefaultTomLowEqHigh init 1
gkDefaultTomLowFader init 1
gkDefaultTomLowPan init 65

gSDefaultTomLowSamplePath = "localSamples/Drums/R8-Drums_Tom_E7661.wav"

giDefaultTomLowSample ftgen 0, 0, 0, 1, gSDefaultTomLowSamplePath, 0, 0, 0


instr DefaultTomLow
  aOutL, aOutR drumSample giDefaultTomLowSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr DefaultTomLowBassKnob
    gkDefaultTomLowEqBass linseg p4, p3, p5
endin

instr DefaultTomLowMidKnob
    gkDefaultTomLowEqMid linseg p4, p3, p5
endin

instr DefaultTomLowHighKnob
    gkDefaultTomLowEqHigh linseg p4, p3, p5
endin

instr DefaultTomLowFader
    gkDefaultTomLowFader linseg p4, p3, p5
endin

instr DefaultTomLowPan
    gkDefaultTomLowPan linseg p4, p3, p5
endin

instr DefaultTomLowMixerChannel
  aDefaultTomLowL inleta "InL"
  aDefaultTomLowR inleta "InR"

  aDefaultTomLowL, aDefaultTomLowR mixerChannel aDefaultTomLowL, aDefaultTomLowR, gkDefaultTomLowFader, gkDefaultTomLowPan, gkDefaultTomLowEqBass, gkDefaultTomLowEqMid, gkDefaultTomLowEqHigh

  outleta "OutL", aDefaultTomLowL
  outleta "OutR", aDefaultTomLowR
endin
