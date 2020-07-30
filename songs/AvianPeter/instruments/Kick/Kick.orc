stereoRoute "KickMixerChannel", "DrumKitBus"
alwayson "KickMixerChannel"

gkKickEqBass init 1
gkKickEqMid init 1
gkKickEqHigh init 1
gkKickFader init .75
gkKickPan init 50

instr Kick
  iSupressNoise = p6

  event_i "i", "DefaultKick", 0, p3, p4, p5

  if iSupressNoise == 0 then
    event_i "i", "PhotoshopSamples", 0, 1, p4, 4
  endif
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
