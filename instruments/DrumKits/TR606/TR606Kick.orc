giTR606KickSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Kick_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Kick_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Kick_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Kick_1a.wav", 0, 0, 0 )

instrumentRoute "TR606Kick", "TR606Bus"

instr TR606Kick
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606KickL, aTR606KickR drumSample giTR606KickSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606KickL
  outleta "OutR", aTR606KickR
endin

$MIXER_CHANNEL(TR606Kick)
