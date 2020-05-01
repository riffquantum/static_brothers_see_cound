stereoRoute "KickBus", "DrumKitBus"

alwayson "KickBus"

gkKickBusEqBass init 2
gkKickBusEqMid init 1
gkKickBusEqHigh init 1
gkKickBusFader init 1
gkKickBusPan init 50

instr KickBusBassKnob
  gkKickBusEqBass linseg p4, p3, p5
endin

instr KickBusMidKnob

  gkKickBusEqMid linseg p4, p3, p5
endin

instr KickBusHighKnob
  gkKickBusEqHigh linseg p4, p3, p5
endin

instr KickBusFader
  gkKickBusFader linseg p4, p3, p5
endin

instr KickBusPan
  gkKickBusPan linseg p4, p3, p5
endin

instr KickBus
  aKickBusL inleta "KickBusInL"
  aKickBusR inleta "KickBusInR"

  aKickBusL, aKickBusR mixerChannel aKickBusL, aKickBusR, gkKickBusFader, gkKickBusPan, gkKickBusEqBass, gkKickBusEqMid, gkKickBusEqHigh

  outleta "KickBusOutL", aKickBusL
  outleta "KickBusOutR", aKickBusR
endin
