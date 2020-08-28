instrumentRoute "TR606OpenHat", "TR606KitBus"

alwayson "TR606OpenHatMixerChannel"

gkTR606OpenHatEqBass init 1.3
gkTR606OpenHatEqMid init 1
gkTR606OpenHatEqHigh init 1
gkTR606OpenHatFader init 1
gkTR606OpenHatPan init 50

giTR606OpenHatSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Open-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606_Open-Hat_1a.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Open-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/TR-606-Saturated_Open-Hat_1a.wav", 0, 0, 0 )


instr TR606OpenHat
  iSampleIndex = 0
  iIsAccented = p6 > 0 ? 1 : 0
  iIsSaturated = p7 > 0 ? 2 : 0

  iSampleIndex += iIsAccented + iIsSaturated

  aTR606OpenHatL, aTR606OpenHatR drumSample giTR606OpenHatSamples[iSampleIndex], p4, p5

  outleta "OutL", aTR606OpenHatL
  outleta "OutR", aTR606OpenHatR
endin

instr TR606OpenHatBassKnob
  gkTR606OpenHatEqBass linseg p4, p3, p5
endin

instr TR606OpenHatMidKnob
  gkTR606OpenHatEqMid linseg p4, p3, p5
endin

instr TR606OpenHatHighKnob
  gkTR606OpenHatEqHigh linseg p4, p3, p5
endin

instr TR606OpenHatFader
  gkTR606OpenHatFader linseg p4, p3, p5
endin

instr TR606OpenHatPan
  gkTR606OpenHatPan linseg p4, p3, p5
endin

instr TR606OpenHatMixerChannel
  aTR606OpenHatL inleta "InL"
  aTR606OpenHatR inleta "InR"

  aTR606OpenHatL, aTR606OpenHatR mixerChannel aTR606OpenHatL, aTR606OpenHatR, gkTR606OpenHatFader, gkTR606OpenHatPan, gkTR606OpenHatEqBass, gkTR606OpenHatEqMid, gkTR606OpenHatEqHigh

  outleta "OutL", aTR606OpenHatL
  outleta "OutR", aTR606OpenHatR
endin
