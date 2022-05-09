giTR606CymbalSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Cymbal_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Cymbal_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Cymbal_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Cymbal_1a.wav", 0, 0, 0 )

instrumentRoute "TR606Cymbal", "TR606Bus"

instr TR606Cymbal
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606CymbalL, aTR606CymbalR drumSample giTR606CymbalSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606CymbalL
  outleta "OutR", aTR606CymbalR
endin

$MIXER_CHANNEL(TR606Cymbal)
