instrumentRoute "TR606TomHigh", "TR606KitBus"

alwayson "TR606TomHighMixerChannel"

gkTR606TomHighEqBass init 1.3
gkTR606TomHighEqMid init 1
gkTR606TomHighEqHigh init 1
gkTR606TomHighFader init 1
gkTR606TomHighPan init 50

giTR606TomHighSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_2a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_2a.wav", 0, 0, 0 )


instr TR606TomHigh
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606TomHighL, aTR606TomHighR drumSample giTR606TomHighSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606TomHighL
  outleta "OutR", aTR606TomHighR
endin

instr TR606TomHighBassKnob
  gkTR606TomHighEqBass linseg p4, p3, p5
endin

instr TR606TomHighMidKnob
  gkTR606TomHighEqMid linseg p4, p3, p5
endin

instr TR606TomHighHighKnob
  gkTR606TomHighEqHigh linseg p4, p3, p5
endin

instr TR606TomHighFader
  gkTR606TomHighFader linseg p4, p3, p5
endin

instr TR606TomHighPan
  gkTR606TomHighPan linseg p4, p3, p5
endin

instr TR606TomHighMixerChannel
  aTR606TomHighL inleta "InL"
  aTR606TomHighR inleta "InR"

  aTR606TomHighL, aTR606TomHighR mixerChannel aTR606TomHighL, aTR606TomHighR, gkTR606TomHighFader, gkTR606TomHighPan, gkTR606TomHighEqBass, gkTR606TomHighEqMid, gkTR606TomHighEqHigh

  outleta "OutL", aTR606TomHighL
  outleta "OutR", aTR606TomHighR
endin
