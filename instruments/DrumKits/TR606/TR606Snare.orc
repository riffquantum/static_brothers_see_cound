giTR606SnareSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Snare_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Snare_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Snare_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Snare_1a.wav", 0, 0, 0 )

instrumentRoute "TR606Snare", "TR606Bus"

instr TR606Snare
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606SnareL, aTR606SnareR drumSample giTR606SnareSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606SnareL
  outleta "OutR", aTR606SnareR
endin

$MIXER_CHANNEL(TR606Snare)
