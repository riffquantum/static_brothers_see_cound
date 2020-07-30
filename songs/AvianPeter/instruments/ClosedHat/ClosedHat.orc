stereoRoute "ClosedHatMixerChannel", "DrumKitBus"
alwayson "ClosedHatMixerChannel"

gkClosedHatEqBass init 1
gkClosedHatEqMid init 1
gkClosedHatEqHigh init 1
gkClosedHatFader init .75
gkClosedHatPan init 50

instr ClosedHat
  iSupressNoise = p6



  event_i "i", "DefaultClosedHat", 0, p3, p4, p5

  if iSupressNoise == 0 then
    event_i "i", "PhotoshopSamples", 0, 1, p4, 0
  endif
endin

instr ClosedHatBassKnob
  gkClosedHatEqBass linseg p4, p3, p5
endin

instr ClosedHatMidKnob
  gkClosedHatEqMid linseg p4, p3, p5
endin

instr ClosedHatHighKnob
  gkClosedHatEqHigh linseg p4, p3, p5
endin

instr ClosedHatFader
  gkClosedHatFader linseg p4, p3, p5
endin

instr ClosedHatPan
  gkClosedHatPan linseg p4, p3, p5
endin

instr ClosedHatMixerChannel
  aClosedHatL inleta "InL"
  aClosedHatR inleta "InR"

  aClosedHatL, aClosedHatR mixerChannel aClosedHatL, aClosedHatR, gkClosedHatFader, gkClosedHatPan, gkClosedHatEqBass, gkClosedHatEqMid, gkClosedHatEqHigh

  outleta "OutL", aClosedHatL
  outleta "OutR", aClosedHatR
endin
