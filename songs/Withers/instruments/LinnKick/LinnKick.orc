instrumentRoute "LinnKick", "KickMixerChannel"
alwayson "LinnKickMixerChannel"

gkLinnKickEqBass init 1
gkLinnKickEqMid init 1
gkLinnKickEqHigh init 1
gkLinnKickFader init 1
gkLinnKickPan init 50

gSLinnKickSamplePath ="localSamples/Drums/Linn-Drum-Processed_Kick_1SubDull.wav"
giLinnKickSample ftgen 0, 0, 0, 1, gSLinnKickSamplePath, 0, 0, 0

instr LinnKick
  aLinnKickSampleL, aLinnKickSampleR drumSample giLinnKickSample, p4, p5

  outleta "OutL", aLinnKickSampleL
  outleta "OutR", aLinnKickSampleR
endin

instr LinnKickBassKnob
  gkLinnKickEqBass linseg p4, p3, p5
endin

instr LinnKickMidKnob

  gkLinnKickEqMid linseg p4, p3, p5
endin

instr LinnKickHighKnob
  gkLinnKickEqHigh linseg p4, p3, p5
endin

instr LinnKickFader
  gkLinnKickFader linseg p4, p3, p5
endin

instr LinnKickPan
  gkLinnKickPan linseg p4, p3, p5
endin

instr LinnKickMixerChannel
  aLinnKickL inleta "InL"
  aLinnKickR inleta "InR"

  aLinnKickL, aLinnKickR mixerChannel aLinnKickL, aLinnKickR, gkLinnKickFader, gkLinnKickPan, gkLinnKickEqBass, gkLinnKickEqMid, gkLinnKickEqHigh

  outleta "OutL", aLinnKickL
  outleta "OutR", aLinnKickR
endin
