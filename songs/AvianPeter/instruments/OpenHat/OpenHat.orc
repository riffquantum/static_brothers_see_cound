stereoRoute "OpenHatMixerChannel", "DrumKitBus"
alwayson "OpenHatMixerChannel"

gkOpenHatEqBass init 1
gkOpenHatEqMid init 1
gkOpenHatEqHigh init 1
gkOpenHatFader init .75
gkOpenHatPan init 50

instr OpenHat
  iSupressNoise = p6

  event_i "i", "DefaultOpenHat", 0, p3, p4, p5

  if iSupressNoise == 0 then
    event_i "i", "PhotoshopSamples", 0, 1, p4, 5
  endif
endin

instr OpenHatBassKnob
  gkOpenHatEqBass linseg p4, p3, p5
endin

instr OpenHatMidKnob
  gkOpenHatEqMid linseg p4, p3, p5
endin

instr OpenHatHighKnob
  gkOpenHatEqHigh linseg p4, p3, p5
endin

instr OpenHatFader
  gkOpenHatFader linseg p4, p3, p5
endin

instr OpenHatPan
  gkOpenHatPan linseg p4, p3, p5
endin

instr OpenHatMixerChannel
  aOpenHatL inleta "InL"
  aOpenHatR inleta "InR"

  aOpenHatL, aOpenHatR mixerChannel aOpenHatL, aOpenHatR, gkOpenHatFader, gkOpenHatPan, gkOpenHatEqBass, gkOpenHatEqMid, gkOpenHatEqHigh

  outleta "OutL", aOpenHatL
  outleta "OutR", aOpenHatR
endin
