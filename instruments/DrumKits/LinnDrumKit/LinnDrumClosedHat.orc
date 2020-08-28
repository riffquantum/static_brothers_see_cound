instrumentRoute "LinnDrumClosedHat", "LinnDrumKitBus"

alwayson "LinnDrumClosedHatMixerChannel"

gkLinnDrumClosedHatEqBass init 1.3
gkLinnDrumClosedHatEqMid init 1
gkLinnDrumClosedHatEqHigh init 1
gkLinnDrumClosedHatFader init 1
gkLinnDrumClosedHatPan init 50

giLinnDrumClosedHatSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_3.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_4.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_5.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_6.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Closed-Hat_7.wav", 0, 0, 0 )

instr LinnDrumClosedHat
  iSampleNumber = p6
  aLinnDrumClosedHatL, aLinnDrumClosedHatR drumSample giLinnDrumClosedHatSamples[iSampleNumber], p4, p5

  outleta "OutL", aLinnDrumClosedHatL
  outleta "OutR", aLinnDrumClosedHatR
endin

instr LinnDrumClosedHatBassKnob
  gkLinnDrumClosedHatEqBass linseg p4, p3, p5
endin

instr LinnDrumClosedHatMidKnob
  gkLinnDrumClosedHatEqMid linseg p4, p3, p5
endin

instr LinnDrumClosedHatHighKnob
  gkLinnDrumClosedHatEqHigh linseg p4, p3, p5
endin

instr LinnDrumClosedHatFader
  gkLinnDrumClosedHatFader linseg p4, p3, p5
endin

instr LinnDrumClosedHatPan
  gkLinnDrumClosedHatPan linseg p4, p3, p5
endin

instr LinnDrumClosedHatMixerChannel
  aLinnDrumClosedHatL inleta "InL"
  aLinnDrumClosedHatR inleta "InR"

  aLinnDrumClosedHatL, aLinnDrumClosedHatR mixerChannel aLinnDrumClosedHatL, aLinnDrumClosedHatR, gkLinnDrumClosedHatFader, gkLinnDrumClosedHatPan, gkLinnDrumClosedHatEqBass, gkLinnDrumClosedHatEqMid, gkLinnDrumClosedHatEqHigh

  outleta "OutL", aLinnDrumClosedHatL
  outleta "OutR", aLinnDrumClosedHatR
endin
