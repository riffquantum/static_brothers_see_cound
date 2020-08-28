instrumentRoute "TR606TomLow", "TR606KitBus"

alwayson "TR606TomLowMixerChannel"

gkTR606TomLowEqBass init 1.3
gkTR606TomLowEqMid init 1
gkTR606TomLowEqHigh init 1
gkTR606TomLowFader init 1
gkTR606TomLowPan init 50

giTR606TomLowSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_1a.wav", 0, 0, 0 )


instr TR606TomLow
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606TomLowL, aTR606TomLowR drumSample giTR606TomLowSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606TomLowL
  outleta "OutR", aTR606TomLowR
endin

instr TR606TomLowBassKnob
  gkTR606TomLowEqBass linseg p4, p3, p5
endin

instr TR606TomLowMidKnob
  gkTR606TomLowEqMid linseg p4, p3, p5
endin

instr TR606TomLowHighKnob
  gkTR606TomLowEqHigh linseg p4, p3, p5
endin

instr TR606TomLowFader
  gkTR606TomLowFader linseg p4, p3, p5
endin

instr TR606TomLowPan
  gkTR606TomLowPan linseg p4, p3, p5
endin

instr TR606TomLowMixerChannel
  aTR606TomLowL inleta "InL"
  aTR606TomLowR inleta "InR"

  aTR606TomLowL, aTR606TomLowR mixerChannel aTR606TomLowL, aTR606TomLowR, gkTR606TomLowFader, gkTR606TomLowPan, gkTR606TomLowEqBass, gkTR606TomLowEqMid, gkTR606TomLowEqHigh

  outleta "OutL", aTR606TomLowL
  outleta "OutR", aTR606TomLowR
endin
