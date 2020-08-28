stereoRoute "TR606KitBus", "WarmDistortionInput"

alwayson "TR606KitBus"

gkTR606KitBusEqBass init 1
gkTR606KitBusEqMid init 1
gkTR606KitBusEqHigh init 1
gkTR606KitBusFader init 1
gkTR606KitBusPan init 50

instr TR606KitBusBassKnob
  gkTR606KitBusEqBass linseg p4, p3, p5
endin

instr TR606KitBusMidKnob
  gkTR606KitBusEqMid linseg p4, p3, p5
endin

instr TR606KitBusHighKnob
  gkTR606KitBusEqHigh linseg p4, p3, p5
endin

instr TR606KitBusFader
  gkTR606KitBusFader linseg p4, p3, p5
endin

instr TR606KitBusPan
  gkTR606KitBusPan linseg p4, p3, p5
endin

instr TR606KitBus
  aTR606KitBusL inleta "InL"
  aTR606KitBusR inleta "InR"

  aTR606KitBusL, aTR606KitBusR mixerChannel aTR606KitBusL, aTR606KitBusR, gkTR606KitBusFader, gkTR606KitBusPan, gkTR606KitBusEqBass, gkTR606KitBusEqMid, gkTR606KitBusEqHigh

  outleta "OutL", aTR606KitBusL
  outleta "OutR", aTR606KitBusR
endin
