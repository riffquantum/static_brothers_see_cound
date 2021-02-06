giTR606TomLowSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_1a.wav", 0, 0, 0 )

instrumentRoute "TR606TomLow", "TR606Bus"

instr TR606TomLow
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606TomLowL, aTR606TomLowR drumSample2 giTR606TomLowSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606TomLowL
  outleta "OutR", aTR606TomLowR
endin

$MIXER_CHANNEL(TR606TomLow)
