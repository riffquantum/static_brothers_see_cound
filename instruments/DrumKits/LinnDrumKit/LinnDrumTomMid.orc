instrumentRoute "LinnDrumTomMid", "LinnDrumKitBus"

alwayson "LinnDrumTomMidMixerChannel"

gkLinnDrumTomMidEqBass init 1
gkLinnDrumTomMidEqMid init 1
gkLinnDrumTomMidEqHigh init 1
gkLinnDrumTomMidFader init 1
gkLinnDrumTomMidPan init 60

gSLinnDrumTomMidSamplePath = "localSamples/Drums/R8-Drums_Tom_E7662.wav"
giLinnDrumTomMidSample ftgen 0, 0, 0, 1, gSLinnDrumTomMidSamplePath, 0, 0, 0

instr LinnDrumTomMid
  aOutL, aOutR drumSample giLinnDrumTomMidSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr LinnDrumTomMidBassKnob
    gkLinnDrumTomMidEqBass linseg p4, p3, p5
endin

instr LinnDrumTomMidMidKnob
    gkLinnDrumTomMidEqMid linseg p4, p3, p5
endin

instr LinnDrumTomMidHighKnob
    gkLinnDrumTomMidEqHigh linseg p4, p3, p5
endin

instr LinnDrumTomMidFader
    gkLinnDrumTomMidFader linseg p4, p3, p5
endin

instr LinnDrumTomMidPan
    gkLinnDrumTomMidPan linseg p4, p3, p5
endin

instr LinnDrumTomMidMixerChannel
  aLinnDrumTomMidL inleta "InL"
  aLinnDrumTomMidR inleta "InR"

  aLinnDrumTomMidL, aLinnDrumTomMidR mixerChannel aLinnDrumTomMidL, aLinnDrumTomMidR, gkLinnDrumTomMidFader, gkLinnDrumTomMidPan, gkLinnDrumTomMidEqBass, gkLinnDrumTomMidEqMid, gkLinnDrumTomMidEqHigh

  outleta "OutL", aLinnDrumTomMidL
  outleta "OutR", aLinnDrumTomMidR
endin
