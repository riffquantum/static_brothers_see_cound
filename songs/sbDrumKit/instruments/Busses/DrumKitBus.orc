stereoRoute "DrumKitBus", "Mixer"
stereoRoute "DrumKitBus", "ReverbForDrumKit"
stereoRoute "DrumKitBus", "DelayForDrumKit"

alwayson "DrumKitBus"

gkDrumKitBusEqBass init 1.3
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

  aDrumKitBusL, aDrumKitBusR mixerChannel aDrumKitBusL, aDrumKitBusR, gkDrumKitBusFader, gkDrumKitBusPan, gkDrumKitBusEqBass, gkDrumKitBusEqMid, gkDrumKitBusEqHigh

  outleta "OutL", aDrumKitBusL
  outleta "OutR", aDrumKitBusR
endin
