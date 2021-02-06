giTR606ClosedHatSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Closed-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Closed-Hat_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Closed-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Closed-Hat_1a.wav", 0, 0, 0 )

instrumentRoute "TR606ClosedHat", "TR606Bus"

instr TR606ClosedHat
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606ClosedHatL, aTR606ClosedHatR drumSample2 giTR606ClosedHatSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606ClosedHatL
  outleta "OutR", aTR606ClosedHatR
endin

$MIXER_CHANNEL(TR606ClosedHat)
