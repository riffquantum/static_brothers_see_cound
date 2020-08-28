instrumentRoute "LinnDrumCabasa", "LinnDrumKitBus"

alwayson "LinnDrumCabasaMixerChannel"

gkLinnDrumCabasaEqBass init 1.3
gkLinnDrumCabasaEqMid init 1
gkLinnDrumCabasaEqHigh init 1
gkLinnDrumCabasaFader init 1
gkLinnDrumCabasaPan init 50

gSLinnDrumCabasaSamplePath = "localSamples/Drums/Linn-Drum_Cabasa_1.wav"
giLinnDrumCabasaSample ftgen 0, 0, 0, 1, gSLinnDrumCabasaSamplePath, 0, 0, 0

instr LinnDrumCabasa
  aLinnDrumCabasaL, aLinnDrumCabasaR drumSample giLinnDrumCabasaSample, p4, p5

  outleta "OutL", aLinnDrumCabasaL
  outleta "OutR", aLinnDrumCabasaR
endin

instr LinnDrumCabasaBassKnob
  gkLinnDrumCabasaEqBass linseg p4, p3, p5
endin

instr LinnDrumCabasaMidKnob
  gkLinnDrumCabasaEqMid linseg p4, p3, p5
endin

instr LinnDrumCabasaHighKnob
  gkLinnDrumCabasaEqHigh linseg p4, p3, p5
endin

instr LinnDrumCabasaFader
  gkLinnDrumCabasaFader linseg p4, p3, p5
endin

instr LinnDrumCabasaPan
  gkLinnDrumCabasaPan linseg p4, p3, p5
endin

instr LinnDrumCabasaMixerChannel
  aLinnDrumCabasaL inleta "InL"
  aLinnDrumCabasaR inleta "InR"

  aLinnDrumCabasaL, aLinnDrumCabasaR mixerChannel aLinnDrumCabasaL, aLinnDrumCabasaR, gkLinnDrumCabasaFader, gkLinnDrumCabasaPan, gkLinnDrumCabasaEqBass, gkLinnDrumCabasaEqMid, gkLinnDrumCabasaEqHigh

  outleta "OutL", aLinnDrumCabasaL
  outleta "OutR", aLinnDrumCabasaR
endin
