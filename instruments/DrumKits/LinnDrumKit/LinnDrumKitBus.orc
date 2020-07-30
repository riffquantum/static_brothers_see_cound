stereoRoute "LinnDrumKitBus", "WarmDistortionInput"

alwayson "LinnDrumKitBus"

gkLinnDrumKitBusEqBass init 1
gkLinnDrumKitBusEqMid init 1
gkLinnDrumKitBusEqHigh init 1
gkLinnDrumKitBusFader init 1
gkLinnDrumKitBusPan init 50

instr LinnDrumKitBusBassKnob
  gkLinnDrumKitBusEqBass linseg p4, p3, p5
endin

instr LinnDrumKitBusMidKnob
  gkLinnDrumKitBusEqMid linseg p4, p3, p5
endin

instr LinnDrumKitBusHighKnob
  gkLinnDrumKitBusEqHigh linseg p4, p3, p5
endin

instr LinnDrumKitBusFader
  gkLinnDrumKitBusFader linseg p4, p3, p5
endin

instr LinnDrumKitBusPan
  gkLinnDrumKitBusPan linseg p4, p3, p5
endin

instr LinnDrumKitBus
  aLinnDrumKitBusL inleta "InL"
  aLinnDrumKitBusR inleta "InR"

  aLinnDrumKitBusL, aLinnDrumKitBusR mixerChannel aLinnDrumKitBusL, aLinnDrumKitBusR, gkLinnDrumKitBusFader, gkLinnDrumKitBusPan, gkLinnDrumKitBusEqBass, gkLinnDrumKitBusEqMid, gkLinnDrumKitBusEqHigh

  outleta "OutL", aLinnDrumKitBusL
  outleta "OutR", aLinnDrumKitBusR
endin
