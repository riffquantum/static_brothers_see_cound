instrumentRoute "LinnDrumTambourine", "LinnDrumKitBus"

alwayson "LinnDrumTambourineMixerChannel"

gkLinnDrumTambourineEqBass init 1.3
gkLinnDrumTambourineEqMid init 1
gkLinnDrumTambourineEqHigh init 1
gkLinnDrumTambourineFader init 1
gkLinnDrumTambourinePan init 50

gSLinnDrumTambourineSamplePath = "localSamples/Drums/Linn-Drum_Tambourine_1.wav"
giLinnDrumTambourineSample ftgen 0, 0, 0, 1, gSLinnDrumTambourineSamplePath, 0, 0, 0

instr LinnDrumTambourine
  aLinnDrumTambourineL, aLinnDrumTambourineR drumSample giLinnDrumTambourineSample, p4, p5

  outleta "OutL", aLinnDrumTambourineL
  outleta "OutR", aLinnDrumTambourineR
endin

instr LinnDrumTambourineBassKnob
  gkLinnDrumTambourineEqBass linseg p4, p3, p5
endin

instr LinnDrumTambourineMidKnob
  gkLinnDrumTambourineEqMid linseg p4, p3, p5
endin

instr LinnDrumTambourineHighKnob
  gkLinnDrumTambourineEqHigh linseg p4, p3, p5
endin

instr LinnDrumTambourineFader
  gkLinnDrumTambourineFader linseg p4, p3, p5
endin

instr LinnDrumTambourinePan
  gkLinnDrumTambourinePan linseg p4, p3, p5
endin

instr LinnDrumTambourineMixerChannel
  aLinnDrumTambourineL inleta "InL"
  aLinnDrumTambourineR inleta "InR"

  aLinnDrumTambourineL, aLinnDrumTambourineR mixerChannel aLinnDrumTambourineL, aLinnDrumTambourineR, gkLinnDrumTambourineFader, gkLinnDrumTambourinePan, gkLinnDrumTambourineEqBass, gkLinnDrumTambourineEqMid, gkLinnDrumTambourineEqHigh

  outleta "OutL", aLinnDrumTambourineL
  outleta "OutR", aLinnDrumTambourineR
endin
