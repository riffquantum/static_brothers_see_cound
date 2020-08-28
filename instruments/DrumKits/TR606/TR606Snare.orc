instrumentRoute "TR606Snare", "TR606KitBus"

alwayson "TR606SnareMixerChannel"

gkTR606SnareEqBass init 1.3
gkTR606SnareEqMid init 1
gkTR606SnareEqHigh init 1
gkTR606SnareFader init 1
gkTR606SnarePan init 50

giTR606SnareSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Snare_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Snare_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Snare_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Snare_1a.wav", 0, 0, 0 )


instr TR606Snare
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606SnareL, aTR606SnareR drumSample giTR606SnareSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606SnareL
  outleta "OutR", aTR606SnareR
endin

instr TR606SnareBassKnob
  gkTR606SnareEqBass linseg p4, p3, p5
endin

instr TR606SnareMidKnob
  gkTR606SnareEqMid linseg p4, p3, p5
endin

instr TR606SnareHighKnob
  gkTR606SnareEqHigh linseg p4, p3, p5
endin

instr TR606SnareFader
  gkTR606SnareFader linseg p4, p3, p5
endin

instr TR606SnarePan
  gkTR606SnarePan linseg p4, p3, p5
endin

instr TR606SnareMixerChannel
  aTR606SnareL inleta "InL"
  aTR606SnareR inleta "InR"

  aTR606SnareL, aTR606SnareR mixerChannel aTR606SnareL, aTR606SnareR, gkTR606SnareFader, gkTR606SnarePan, gkTR606SnareEqBass, gkTR606SnareEqMid, gkTR606SnareEqHigh

  outleta "OutL", aTR606SnareL
  outleta "OutR", aTR606SnareR
endin
