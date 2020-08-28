instrumentRoute "TR606Cymbal", "TR606KitBus"

alwayson "TR606CymbalMixerChannel"

gkTR606CymbalEqBass init 1.3
gkTR606CymbalEqMid init 1
gkTR606CymbalEqHigh init 1
gkTR606CymbalFader init 1
gkTR606CymbalPan init 50

giTR606CymbalSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Cymbal_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Cymbal_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Cymbal_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Cymbal_1a.wav", 0, 0, 0 )


instr TR606Cymbal
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606CymbalL, aTR606CymbalR drumSample giTR606CymbalSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606CymbalL
  outleta "OutR", aTR606CymbalR
endin

instr TR606CymbalBassKnob
  gkTR606CymbalEqBass linseg p4, p3, p5
endin

instr TR606CymbalMidKnob
  gkTR606CymbalEqMid linseg p4, p3, p5
endin

instr TR606CymbalHighKnob
  gkTR606CymbalEqHigh linseg p4, p3, p5
endin

instr TR606CymbalFader
  gkTR606CymbalFader linseg p4, p3, p5
endin

instr TR606CymbalPan
  gkTR606CymbalPan linseg p4, p3, p5
endin

instr TR606CymbalMixerChannel
  aTR606CymbalL inleta "InL"
  aTR606CymbalR inleta "InR"

  aTR606CymbalL, aTR606CymbalR mixerChannel aTR606CymbalL, aTR606CymbalR, gkTR606CymbalFader, gkTR606CymbalPan, gkTR606CymbalEqBass, gkTR606CymbalEqMid, gkTR606CymbalEqHigh

  outleta "OutL", aTR606CymbalL
  outleta "OutR", aTR606CymbalR
endin
