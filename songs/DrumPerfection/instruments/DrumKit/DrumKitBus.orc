stereoRoute "DrumKitBus", "DrumKitLPFInput"

alwayson "DrumKitBus"

gkDrumKitBusEqBass init 1
gkDrumKitBusEqMid init 1
gkDrumKitBusEqHigh init 1
gkDrumKitBusFader init 1
gkDrumKitBusPan init 50

instr DrumKitBusBassKnob
  gkDrumKitBusEqBass linseg p4, p3, p5
endin

instr DrumKitBusMidKnob
  gkDrumKitBusEqMid linseg p4, p3, p5
endin

instr DrumKitBusHighKnob
  gkDrumKitBusEqHigh linseg p4, p3, p5
endin

instr DrumKitBusFader
  gkDrumKitBusFader linseg p4, p3, p5
endin

instr DrumKitBusPan
  gkDrumKitBusPan linseg p4, p3, p5
endin

instr DrumKitBus
  aDrumKitBusL inleta "InL"
  aDrumKitBusR inleta "InR"

  ; aDrumKitBusL bqrez aDrumKitBusL, 1000, 1
  ; aDrumKitBusR bqrez aDrumKitBusR, 1000, 1

  aDrumKitBusL, aDrumKitBusR mixerChannel aDrumKitBusL, aDrumKitBusR, gkDrumKitBusFader, gkDrumKitBusPan, gkDrumKitBusEqBass, gkDrumKitBusEqMid, gkDrumKitBusEqHigh

  outleta "OutL", aDrumKitBusL
  outleta "OutR", aDrumKitBusR
endin
