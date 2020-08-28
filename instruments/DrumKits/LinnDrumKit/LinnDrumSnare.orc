instrumentRoute "LinnDrumSnare", "LinnDrumKitBus"

alwayson "LinnDrumSnareMixerChannel"

gkLinnDrumSnareEqBass init 1.3
gkLinnDrumSnareEqMid init 1
gkLinnDrumSnareEqHigh init 1
gkLinnDrumSnareFader init 1
gkLinnDrumSnarePan init 50

giLinnDrumSnareSamples[] fillarray \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_8.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_9.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_10.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_11.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_12.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_13.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_14.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_1.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_2.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_3.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_4.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_5.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_6.wav", 0, 0, 0 ), \
ftgen( 0, 0, 0, 1, "localSamples/Drums/Linn-Drum_Snare_7.wav", 0, 0, 0 )

instr LinnDrumSnare
  iSampleNumber = p6
  aLinnDrumSnareL, aLinnDrumSnareR drumSample giLinnDrumSnareSamples[iSampleNumber], p4, p5

  outleta "OutL", aLinnDrumSnareL
  outleta "OutR", aLinnDrumSnareR
endin

instr LinnDrumSnareBassKnob
  gkLinnDrumSnareEqBass linseg p4, p3, p5
endin

instr LinnDrumSnareMidKnob
  gkLinnDrumSnareEqMid linseg p4, p3, p5
endin

instr LinnDrumSnareHighKnob
  gkLinnDrumSnareEqHigh linseg p4, p3, p5
endin

instr LinnDrumSnareFader
  gkLinnDrumSnareFader linseg p4, p3, p5
endin

instr LinnDrumSnarePan
  gkLinnDrumSnarePan linseg p4, p3, p5
endin

instr LinnDrumSnareMixerChannel
  aLinnDrumSnareL inleta "InL"
  aLinnDrumSnareR inleta "InR"

  aLinnDrumSnareL, aLinnDrumSnareR mixerChannel aLinnDrumSnareL, aLinnDrumSnareR, gkLinnDrumSnareFader, gkLinnDrumSnarePan, gkLinnDrumSnareEqBass, gkLinnDrumSnareEqMid, gkLinnDrumSnareEqHigh

  outleta "OutL", aLinnDrumSnareL
  outleta "OutR", aLinnDrumSnareR
endin
