giTR606OpenHatSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Open-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Open-Hat_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Open-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Open-Hat_1a.wav", 0, 0, 0 )

instrumentRoute "TR606OpenHat", "TR606Bus"

instr TR606OpenHat
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606OpenHatL, aTR606OpenHatR drumSample giTR606OpenHatSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606OpenHatL
  outleta "OutR", aTR606OpenHatR
endin

$MIXER_CHANNEL(TR606OpenHat)
