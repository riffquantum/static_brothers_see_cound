instrumentRoute "LinnDrumTomLow", "LinnDrumKitBus"

alwayson "LinnDrumTomLowMixerChannel"

gkLinnDrumTomLowEqBass init 1
gkLinnDrumTomLowEqMid init 1
gkLinnDrumTomLowEqHigh init 1
gkLinnDrumTomLowFader init 1
gkLinnDrumTomLowPan init 65

gSLinnDrumTomLowSamplePath = "localSamples/Drums/R8-Drums_Tom_E7661.wav"

giLinnDrumTomLowSample ftgen 0, 0, 0, 1, gSLinnDrumTomLowSamplePath, 0, 0, 0


instr LinnDrumTomLow
  aOutL, aOutR drumSample giLinnDrumTomLowSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr LinnDrumTomLowBassKnob
    gkLinnDrumTomLowEqBass linseg p4, p3, p5
endin

instr LinnDrumTomLowMidKnob
    gkLinnDrumTomLowEqMid linseg p4, p3, p5
endin

instr LinnDrumTomLowHighKnob
    gkLinnDrumTomLowEqHigh linseg p4, p3, p5
endin

instr LinnDrumTomLowFader
    gkLinnDrumTomLowFader linseg p4, p3, p5
endin

instr LinnDrumTomLowPan
    gkLinnDrumTomLowPan linseg p4, p3, p5
endin

instr LinnDrumTomLowMixerChannel
  aLinnDrumTomLowL inleta "InL"
  aLinnDrumTomLowR inleta "InR"

  aLinnDrumTomLowL, aLinnDrumTomLowR mixerChannel aLinnDrumTomLowL, aLinnDrumTomLowR, gkLinnDrumTomLowFader, gkLinnDrumTomLowPan, gkLinnDrumTomLowEqBass, gkLinnDrumTomLowEqMid, gkLinnDrumTomLowEqHigh

  outleta "OutL", aLinnDrumTomLowL
  outleta "OutR", aLinnDrumTomLowR
endin
