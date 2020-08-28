instrumentRoute "LinnDrumClap", "LinnDrumKitBus"

alwayson "LinnDrumClapMixerChannel"

gkLinnDrumClapEqBass init 1.3
gkLinnDrumClapEqMid init 1
gkLinnDrumClapEqHigh init 1
gkLinnDrumClapFader init 1
gkLinnDrumClapPan init 50

gSLinnDrumClapSamplePath = "localSamples/Drums/Linn-Drum_Clap_1.wav"
giLinnDrumClapSample ftgen 0, 0, 0, 1, gSLinnDrumClapSamplePath, 0, 0, 0

instr LinnDrumClap
  aLinnDrumClapL, aLinnDrumClapR drumSample giLinnDrumClapSample, p4, p5

  outleta "OutL", aLinnDrumClapL
  outleta "OutR", aLinnDrumClapR
endin

instr LinnDrumClapBassKnob
  gkLinnDrumClapEqBass linseg p4, p3, p5
endin

instr LinnDrumClapMidKnob
  gkLinnDrumClapEqMid linseg p4, p3, p5
endin

instr LinnDrumClapHighKnob
  gkLinnDrumClapEqHigh linseg p4, p3, p5
endin

instr LinnDrumClapFader
  gkLinnDrumClapFader linseg p4, p3, p5
endin

instr LinnDrumClapPan
  gkLinnDrumClapPan linseg p4, p3, p5
endin

instr LinnDrumClapMixerChannel
  aLinnDrumClapL inleta "InL"
  aLinnDrumClapR inleta "InR"

  aLinnDrumClapL, aLinnDrumClapR mixerChannel aLinnDrumClapL, aLinnDrumClapR, gkLinnDrumClapFader, gkLinnDrumClapPan, gkLinnDrumClapEqBass, gkLinnDrumClapEqMid, gkLinnDrumClapEqHigh

  outleta "OutL", aLinnDrumClapL
  outleta "OutR", aLinnDrumClapR
endin
