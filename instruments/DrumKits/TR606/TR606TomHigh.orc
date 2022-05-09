giTR606TomHighSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Tom_2a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Tom_2a.wav", 0, 0, 0 )

instrumentRoute "TR606TomHigh", "TR606Bus"

instr TR606TomHigh
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606TomHighL, aTR606TomHighR drumSample giTR606TomHighSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606TomHighL
  outleta "OutR", aTR606TomHighR
endin

$MIXER_CHANNEL(TR606TomHigh)
