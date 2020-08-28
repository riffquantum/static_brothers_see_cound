instrumentRoute "TR606ClosedHat", "TR606KitBus"

alwayson "TR606ClosedHatMixerChannel"

gkTR606ClosedHatEqBass init 1.3
gkTR606ClosedHatEqMid init 1
gkTR606ClosedHatEqHigh init 1
gkTR606ClosedHatFader init 1
gkTR606ClosedHatPan init 50

giTR606ClosedHatSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Closed-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Closed-Hat_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Closed-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Closed-Hat_1a.wav", 0, 0, 0 )


instr TR606ClosedHat
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606ClosedHatL, aTR606ClosedHatR drumSample giTR606ClosedHatSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606ClosedHatL
  outleta "OutR", aTR606ClosedHatR
endin

instr TR606ClosedHatBassKnob
  gkTR606ClosedHatEqBass linseg p4, p3, p5
endin

instr TR606ClosedHatMidKnob
  gkTR606ClosedHatEqMid linseg p4, p3, p5
endin

instr TR606ClosedHatHighKnob
  gkTR606ClosedHatEqHigh linseg p4, p3, p5
endin

instr TR606ClosedHatFader
  gkTR606ClosedHatFader linseg p4, p3, p5
endin

instr TR606ClosedHatPan
  gkTR606ClosedHatPan linseg p4, p3, p5
endin

instr TR606ClosedHatMixerChannel
  aTR606ClosedHatL inleta "InL"
  aTR606ClosedHatR inleta "InR"

  aTR606ClosedHatL, aTR606ClosedHatR mixerChannel aTR606ClosedHatL, aTR606ClosedHatR, gkTR606ClosedHatFader, gkTR606ClosedHatPan, gkTR606ClosedHatEqBass, gkTR606ClosedHatEqMid, gkTR606ClosedHatEqHigh

  outleta "OutL", aTR606ClosedHatL
  outleta "OutR", aTR606ClosedHatR
endin
