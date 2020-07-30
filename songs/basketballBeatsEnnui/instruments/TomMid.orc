; TomMid
gSTomMidName = "TomMid"
gSTomMidRoute = "Mixer"
instrumentRoute gSTomMidName, gSTomMidRoute

alwayson "TomMidMixerChannel"

gkTomMidEqBass init 1
gkTomMidEqMid init 1
gkTomMidEqHigh init 1
gkTomMidFader init 1
gkTomMidPan init 50

gSTomMidSamplePath = "localSamples/Drums/R8-Drums_Tom_E7662.wav"
giTomMidSample ftgen 0, 0, 0, 1, gSTomMidSamplePath, 0, 0, 0


instr TomMid
  aOutL, aOutR drumSample giTomMidSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr TomMidBassKnob
    gkTomMidEqBass linseg p4, p3, p5
endin

instr TomMidMidKnob
    gkTomMidEqMid linseg p4, p3, p5
endin

instr TomMidHighKnob
    gkTomMidEqHigh linseg p4, p3, p5
endin

instr TomMidFader
    gkTomMidFader linseg p4, p3, p5
endin

instr TomMidPan
    gkTomMidPan linseg p4, p3, p5
endin

instr TomMidMixerChannel
  aTomMidL inleta "InL"
  aTomMidR inleta "InR"

  aTomMidL, aTomMidR mixerChannel aTomMidL, aTomMidR, gkTomMidFader, gkTomMidPan, gkTomMidEqBass, gkTomMidEqMid, gkTomMidEqHigh

  outleta "OutL", aTomMidL
  outleta "OutR", aTomMidR
endin
