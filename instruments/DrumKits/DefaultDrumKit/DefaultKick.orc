instrumentRoute "DefaultKick", "DefaultDrumKitBus"

alwayson "DefaultKickMixerChannel"

gkDefaultKickEqBass init 1.3
gkDefaultKickEqMid init 1
gkDefaultKickEqHigh init 1
gkDefaultKickFader init 1
gkDefaultKickPan init 50

gSDefaultKickSamplePath = "localsamples/CB_Kick.wav"
giDefaultKickSample ftgen 0, 0, 0, 1, gSDefaultKickSamplePath, 0, 0, 0

instr DefaultKick
  aDefaultKickL, aDefaultKickR drumSample giDefaultKickSample, p4, p5

  outleta "OutL", aDefaultKickL
  outleta "OutR", aDefaultKickR
endin

instr DefaultKickBassKnob
  gkDefaultKickEqBass linseg p4, p3, p5
endin

instr DefaultKickMidKnob
  gkDefaultKickEqMid linseg p4, p3, p5
endin

instr DefaultKickHighKnob
  gkDefaultKickEqHigh linseg p4, p3, p5
endin

instr DefaultKickFader
  gkDefaultKickFader linseg p4, p3, p5
endin

instr DefaultKickPan
  gkDefaultKickPan linseg p4, p3, p5
endin

instr DefaultKickMixerChannel
  aDefaultKickL inleta "InL"
  aDefaultKickR inleta "InR"

  aDefaultKickL, aDefaultKickR mixerChannel aDefaultKickL, aDefaultKickR, gkDefaultKickFader, gkDefaultKickPan, gkDefaultKickEqBass, gkDefaultKickEqMid, gkDefaultKickEqHigh

  outleta "OutL", aDefaultKickL
  outleta "OutR", aDefaultKickR
endin
