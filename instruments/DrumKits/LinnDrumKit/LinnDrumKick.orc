instrumentRoute "LinnDrumKick", "LinnDrumKitBus"

alwayson "LinnDrumKickMixerChannel"

gkLinnDrumKickEqBass init 1.3
gkLinnDrumKickEqMid init 1
gkLinnDrumKickEqHigh init 1
gkLinnDrumKickFader init 1
gkLinnDrumKickPan init 50

gSLinnDrumKickSamplePath = "localSamples/Drums/Linn-Drum_Kick_1.wav"
giLinnDrumKickSample ftgen 0, 0, 0, 1, gSLinnDrumKickSamplePath, 0, 0, 0

instr LinnDrumKick
  aLinnDrumKickL, aLinnDrumKickR drumSample giLinnDrumKickSample, p4, p5

  outleta "OutL", aLinnDrumKickL
  outleta "OutR", aLinnDrumKickR
endin

instr LinnDrumKickBassKnob
  gkLinnDrumKickEqBass linseg p4, p3, p5
endin

instr LinnDrumKickMidKnob
  gkLinnDrumKickEqMid linseg p4, p3, p5
endin

instr LinnDrumKickHighKnob
  gkLinnDrumKickEqHigh linseg p4, p3, p5
endin

instr LinnDrumKickFader
  gkLinnDrumKickFader linseg p4, p3, p5
endin

instr LinnDrumKickPan
  gkLinnDrumKickPan linseg p4, p3, p5
endin

instr LinnDrumKickMixerChannel
  aLinnDrumKickL inleta "InL"
  aLinnDrumKickR inleta "InR"

  aLinnDrumKickL, aLinnDrumKickR mixerChannel aLinnDrumKickL, aLinnDrumKickR, gkLinnDrumKickFader, gkLinnDrumKickPan, gkLinnDrumKickEqBass, gkLinnDrumKickEqMid, gkLinnDrumKickEqHigh

  outleta "OutL", aLinnDrumKickL
  outleta "OutR", aLinnDrumKickR
endin
