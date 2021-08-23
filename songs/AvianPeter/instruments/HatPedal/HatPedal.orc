stereoRoute "HatPedalMixerChannel", "DrumKitBus"
alwayson "HatPedalMixerChannel"

gkHatPedalEqBass init 1
gkHatPedalEqMid init 1
gkHatPedalEqHigh init 1
gkHatPedalFader init .75
gkHatPedalPan init 50

instr HatPedal
  iSupressNoise = p6

  event_i "i", "DefaultClosedHat", 0, p3, p4, p5
  event_i "i", "DefaultKick", 0, p3, p4, p5

  if iSupressNoise == 0 then
    event_i "i", "PhotoshopSamples", 0, 1, p4, 3
  endif
endin

instr HatPedalBassKnob
  gkHatPedalEqBass linseg p4, p3, p5
endin

instr HatPedalMidKnob
  gkHatPedalEqMid linseg p4, p3, p5
endin

instr HatPedalHighKnob
  gkHatPedalEqHigh linseg p4, p3, p5
endin

instr HatPedalFader
  gkHatPedalFader linseg p4, p3, p5
endin

instr HatPedalPan
  gkHatPedalPan linseg p4, p3, p5
endin

instr HatPedalMixerChannel
  aHatPedalL inleta "InL"
  aHatPedalR inleta "InR"

  aHatPedalL, aHatPedalR mixerChannel aHatPedalL, aHatPedalR, gkHatPedalFader, gkHatPedalPan, gkHatPedalEqBass, gkHatPedalEqMid, gkHatPedalEqHigh

  outleta "OutL", aHatPedalL
  outleta "OutR", aHatPedalR
endin
