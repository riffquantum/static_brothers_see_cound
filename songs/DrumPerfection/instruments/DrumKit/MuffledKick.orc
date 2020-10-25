instrumentRoute "MuffledKick", "KickMixerChannel"
alwayson "MuffledKickMixerChannel"

gkMuffledKickEqBass init 1
gkMuffledKickEqMid init 1
gkMuffledKickEqHigh init 1
gkMuffledKickFader init 1
gkMuffledKickPan init 50

gSMuffledKickSamplePath ="localSamples/Drums/Beatbox-Drums_Kick_EA7511.wav"
giMuffledKickSample ftgen 0, 0, 0, 1, gSMuffledKickSamplePath, 0, 0, 0

instr MuffledKick
  aMuffledKickSampleL, aMuffledKickSampleR drumSample giMuffledKickSample, p4, p5

  outleta "OutL", aMuffledKickSampleL
  outleta "OutR", aMuffledKickSampleR
endin

instr MuffledKickBassKnob
  gkMuffledKickEqBass linseg p4, p3, p5
endin

instr MuffledKickMidKnob
  gkMuffledKickEqMid linseg p4, p3, p5
endin

instr MuffledKickHighKnob
  gkMuffledKickEqHigh linseg p4, p3, p5
endin

instr MuffledKickFader
  gkMuffledKickFader linseg p4, p3, p5
endin

instr MuffledKickPan
  gkMuffledKickPan linseg p4, p3, p5
endin

instr MuffledKickMixerChannel
  aMuffledKickL inleta "InL"
  aMuffledKickR inleta "InR"

  aMuffledKickL, aMuffledKickR mixerChannel aMuffledKickL, aMuffledKickR, gkMuffledKickFader, gkMuffledKickPan, gkMuffledKickEqBass, gkMuffledKickEqMid, gkMuffledKickEqHigh

  outleta "OutL", aMuffledKickL
  outleta "OutR", aMuffledKickR
endin
