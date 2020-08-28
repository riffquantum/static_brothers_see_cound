instrumentRoute "LinnDrumRim", "LinnDrumKitBus"

alwayson "LinnDrumRimMixerChannel"

gkLinnDrumRimEqBass init 1.3
gkLinnDrumRimEqMid init 1
gkLinnDrumRimEqHigh init 1
gkLinnDrumRimFader init 1
gkLinnDrumRimPan init 50

giLinnDrumRimSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_8.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_9.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_10.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_11.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_12.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_3.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_4.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_5.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_6.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Rim_7.wav", 0, 0, 0 )

instr LinnDrumRim
  iSampleNumber = p6
  aLinnDrumRimL, aLinnDrumRimR drumSample giLinnDrumRimSamples[iSampleNumber], p4, p5

  outleta "OutL", aLinnDrumRimL
  outleta "OutR", aLinnDrumRimR
endin

instr LinnDrumRimBassKnob
  gkLinnDrumRimEqBass linseg p4, p3, p5
endin

instr LinnDrumRimMidKnob
  gkLinnDrumRimEqMid linseg p4, p3, p5
endin

instr LinnDrumRimHighKnob
  gkLinnDrumRimEqHigh linseg p4, p3, p5
endin

instr LinnDrumRimFader
  gkLinnDrumRimFader linseg p4, p3, p5
endin

instr LinnDrumRimPan
  gkLinnDrumRimPan linseg p4, p3, p5
endin

instr LinnDrumRimMixerChannel
  aLinnDrumRimL inleta "InL"
  aLinnDrumRimR inleta "InR"

  aLinnDrumRimL, aLinnDrumRimR mixerChannel aLinnDrumRimL, aLinnDrumRimR, gkLinnDrumRimFader, gkLinnDrumRimPan, gkLinnDrumRimEqBass, gkLinnDrumRimEqMid, gkLinnDrumRimEqHigh

  outleta "OutL", aLinnDrumRimL
  outleta "OutR", aLinnDrumRimR
endin
