; TomLow
gSTomLowName = "TomLow"
gSTomLowRoute = "Mixer"
instrumentRoute gSTomLowName, gSTomLowRoute

alwayson "TomLowMixerChannel"

gkTomLowEqBass init 1
gkTomLowEqMid init 1
gkTomLowEqHigh init 1
gkTomLowFader init 1
gkTomLowPan init 50

gSTomLowSamplePath = "localSamples/Drums/R8-Drums_Tom_E7661.wav"

giTomLowSample ftgen 0, 0, 0, 1, gSTomLowSamplePath, 0, 0, 0


instr TomLow
  aOutL, aOutR drumSample giTomMidSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr TomLowBassKnob
    gkTomLowEqBass linseg p4, p3, p5
endin

instr TomLowMidKnob
    gkTomLowEqMid linseg p4, p3, p5
endin

instr TomLowHighKnob
    gkTomLowEqHigh linseg p4, p3, p5
endin

instr TomLowFader
    gkTomLowFader linseg p4, p3, p5
endin

instr TomLowPan
    gkTomLowPan linseg p4, p3, p5
endin

instr TomLowMixerChannel
  aTomLowL inleta "InL"
  aTomLowR inleta "InR"

  aTomLowL, aTomLowR mixerChannel aTomLowL, aTomLowR, gkTomLowFader, gkTomLowPan, gkTomLowEqBass, gkTomLowEqMid, gkTomLowEqHigh

  outleta "OutL", aTomLowL
  outleta "OutR", aTomLowR
endin
