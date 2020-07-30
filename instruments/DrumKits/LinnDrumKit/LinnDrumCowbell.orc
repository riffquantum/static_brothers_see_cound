instrumentRoute "LinnDrumCowbell", "LinnDrumKitBus"

alwayson "LinnDrumCowbellMixerChannel"

gkLinnDrumCowbellEqBass init 1.3
gkLinnDrumCowbellEqMid init 1
gkLinnDrumCowbellEqHigh init 1
gkLinnDrumCowbellFader init 1
gkLinnDrumCowbellPan init 25

gSLinnDrumCowbellSamplePath = "localSamples/Drums/Qdrums_Cowbell_EA9012.wav"
giLinnDrumCowbellSample ftgen 0, 0, 0, 1, gSLinnDrumCowbellSamplePath, 0, 0, 0

instr LinnDrumCowbell
  aLinnDrumCowbellL, aLinnDrumCowbellR drumSample giLinnDrumCowbellSample, p4, p5

  outleta "OutL", aLinnDrumCowbellL
  outleta "OutR", aLinnDrumCowbellR
endin

instr LinnDrumCowbellBassKnob
  gkLinnDrumCowbellEqBass linseg p4, p3, p5
endin

instr LinnDrumCowbellMidKnob
  gkLinnDrumCowbellEqMid linseg p4, p3, p5
endin

instr LinnDrumCowbellHighKnob
  gkLinnDrumCowbellEqHigh linseg p4, p3, p5
endin

instr LinnDrumCowbellFader
  gkLinnDrumCowbellFader linseg p4, p3, p5
endin

instr LinnDrumCowbellPan
  gkLinnDrumCowbellPan linseg p4, p3, p5
endin

instr LinnDrumCowbellMixerChannel
  aLinnDrumCowbellL inleta "InL"
  aLinnDrumCowbellR inleta "InR"

  aLinnDrumCowbellL, aLinnDrumCowbellR mixerChannel aLinnDrumCowbellL, aLinnDrumCowbellR, gkLinnDrumCowbellFader, gkLinnDrumCowbellPan, gkLinnDrumCowbellEqBass, gkLinnDrumCowbellEqMid, gkLinnDrumCowbellEqHigh

  outleta "OutL", aLinnDrumCowbellL
  outleta "OutR", aLinnDrumCowbellR
endin
