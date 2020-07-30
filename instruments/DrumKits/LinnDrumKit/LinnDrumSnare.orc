instrumentRoute "LinnDrumSnare", "LinnDrumKitBus"

alwayson "LinnDrumSnareMixerChannel"

gkLinnDrumSnareEqBass init 1.3
gkLinnDrumSnareEqMid init 1
gkLinnDrumSnareEqHigh init 1
gkLinnDrumSnareFader init 1
gkLinnDrumSnarePan init 45

gSLinnDrumSnareSamplePath = "localSamples/Drums/Mixed-Drums_Snare_EA8512.wav"
giLinnDrumSnareSample ftgen 0, 0, 0, 1, gSLinnDrumSnareSamplePath, 0, 0, 0

instr LinnDrumSnare
  aLinnDrumSnareL, aLinnDrumSnareR drumSample giLinnDrumSnareSample, p4, p5

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
