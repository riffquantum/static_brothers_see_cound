stereoRoute "DefaultDrumKitBus", "DefaultDrumKitDistortionInput"

alwayson "DefaultDrumKitBus"

gkDefaultDrumKitBusEqBass init 1
gkDefaultDrumKitBusEqMid init 1
gkDefaultDrumKitBusEqHigh init 1
gkDefaultDrumKitBusFader init 1
gkDefaultDrumKitBusPan init 50

instr DefaultDrumKitBusBassKnob
  gkDefaultDrumKitBusEqBass linseg p4, p3, p5
endin

instr DefaultDrumKitBusMidKnob
  gkDefaultDrumKitBusEqMid linseg p4, p3, p5
endin

instr DefaultDrumKitBusHighKnob
  gkDefaultDrumKitBusEqHigh linseg p4, p3, p5
endin

instr DefaultDrumKitBusFader
  gkDefaultDrumKitBusFader linseg p4, p3, p5
endin

instr DefaultDrumKitBusPan
  gkDefaultDrumKitBusPan linseg p4, p3, p5
endin

instr DefaultDrumKitBus
  aDefaultDrumKitBusL inleta "InL"
  aDefaultDrumKitBusR inleta "InR"

  aDefaultDrumKitBusL, aDefaultDrumKitBusR mixerChannel aDefaultDrumKitBusL, aDefaultDrumKitBusR, gkDefaultDrumKitBusFader, gkDefaultDrumKitBusPan, gkDefaultDrumKitBusEqBass, gkDefaultDrumKitBusEqMid, gkDefaultDrumKitBusEqHigh

  outleta "OutL", aDefaultDrumKitBusL
  outleta "OutR", aDefaultDrumKitBusR
endin
