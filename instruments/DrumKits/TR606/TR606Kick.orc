instrumentRoute "TR606Kick", "TR606KitBus"

alwayson "TR606KickMixerChannel"

gkTR606KickEqBass init 1.3
gkTR606KickEqMid init 1
gkTR606KickEqHigh init 1
gkTR606KickFader init 1
gkTR606KickPan init 50

giTR606KickSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Kick_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Kick_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Kick_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Kick_1a.wav", 0, 0, 0 )


instr TR606Kick
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606KickL, aTR606KickR drumSample giTR606KickSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606KickL
  outleta "OutR", aTR606KickR
endin

instr TR606KickBassKnob
  gkTR606KickEqBass linseg p4, p3, p5
endin

instr TR606KickMidKnob
  gkTR606KickEqMid linseg p4, p3, p5
endin

instr TR606KickHighKnob
  gkTR606KickEqHigh linseg p4, p3, p5
endin

instr TR606KickFader
  gkTR606KickFader linseg p4, p3, p5
endin

instr TR606KickPan
  gkTR606KickPan linseg p4, p3, p5
endin

instr TR606KickMixerChannel
  aTR606KickL inleta "InL"
  aTR606KickR inleta "InR"

  aTR606KickL, aTR606KickR mixerChannel aTR606KickL, aTR606KickR, gkTR606KickFader, gkTR606KickPan, gkTR606KickEqBass, gkTR606KickEqMid, gkTR606KickEqHigh

  outleta "OutL", aTR606KickL
  outleta "OutR", aTR606KickR
endin
