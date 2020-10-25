instrumentRoute "Kick", "DrumKitBus"

alwayson "KickMixerChannel"

gkKickEqBass init 1.3
gkKickEqMid init 1
gkKickEqHigh init 1
gkKickFader init 1
gkKickPan init 50

gSKickSamplePath = "localsamples/CB_Kick.wav"
giKickSample ftgen 0, 0, 0, 1, gSKickSamplePath, 0, 0, 0

instr Kick
  aKickL, aKickR drumSample giKickSample, p4, p5

  outleta "OutL", aKickL
  outleta "OutR", aKickR
endin

instr KickBassKnob
  gkKickEqBass linseg p4, p3, p5
endin

instr KickMidKnob
  gkKickEqMid linseg p4, p3, p5
endin

instr KickHighKnob
  gkKickEqHigh linseg p4, p3, p5
endin

instr KickFader
  gkKickFader linseg p4, p3, p5
endin

instr KickPan
  gkKickPan linseg p4, p3, p5
endin

instr KickMixerChannel
  aKickL inleta "InL"
  aKickR inleta "InR"

  aKickL, aKickR mixerChannel aKickL, aKickR, gkKickFader, gkKickPan, gkKickEqBass, gkKickEqMid, gkKickEqHigh

  outleta "OutL", aKickL
  outleta "OutR", aKickR
endin
