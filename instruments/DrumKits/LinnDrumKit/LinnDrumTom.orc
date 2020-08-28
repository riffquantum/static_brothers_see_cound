instrumentRoute "LinnDrumTom", "LinnDrumKitBus"

alwayson "LinnDrumTomMixerChannel"

gkLinnDrumTomEqBass init 1.3
gkLinnDrumTomEqMid init 1
gkLinnDrumTomEqHigh init 1
gkLinnDrumTomFader init 1
gkLinnDrumTomPan init 50

giLinnDrumTomSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_6.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_7.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_8.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_9.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_10.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_11.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_12.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_13.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_3.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_4.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Tom_5.wav", 0, 0, 0 )

instr LinnDrumTom
  iSampleNumber = p6
  aLinnDrumTomL, aLinnDrumTomR drumSample giLinnDrumTomSamples[iSampleNumber], p4, p5

  outleta "OutL", aLinnDrumTomL
  outleta "OutR", aLinnDrumTomR
endin

instr LinnDrumTomBassKnob
  gkLinnDrumTomEqBass linseg p4, p3, p5
endin

instr LinnDrumTomMidKnob
  gkLinnDrumTomEqMid linseg p4, p3, p5
endin

instr LinnDrumTomHighKnob
  gkLinnDrumTomEqHigh linseg p4, p3, p5
endin

instr LinnDrumTomFader
  gkLinnDrumTomFader linseg p4, p3, p5
endin

instr LinnDrumTomPan
  gkLinnDrumTomPan linseg p4, p3, p5
endin

instr LinnDrumTomMixerChannel
  aLinnDrumTomL inleta "InL"
  aLinnDrumTomR inleta "InR"

  aLinnDrumTomL, aLinnDrumTomR mixerChannel aLinnDrumTomL, aLinnDrumTomR, gkLinnDrumTomFader, gkLinnDrumTomPan, gkLinnDrumTomEqBass, gkLinnDrumTomEqMid, gkLinnDrumTomEqHigh

  outleta "OutL", aLinnDrumTomL
  outleta "OutR", aLinnDrumTomR
endin
