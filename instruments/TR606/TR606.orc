/* TR606
    Sampler using samples from the Roland TR-606 drum machine.

    p4 - Drum Name - String - valid values:
        kick
        snare
        closedHat
        openHat
        highTom
        lowTom
        cymbal
    p5 - coresponds to kpitch on diskin opcode
    p6 - amplitude modifier
    p7 - kill switch - Note will only output audio when this
        equals 0. Use it with a loop count and some arithmetic
        to turn notes on and off per measure.
    p8 - if 1 then it will play the "saturated" version of the sample.
        That's a version of the sample where the volume was maxed out
        on the original machine.
    p9 - if 1 then it will play the "accent" version of the sample
*/

instrumentRoute "TR606", "Mixer"
alwayson "TR606MixerChannel"

gkTR606EqBass init 1
gkTR606EqMid init 1
gkTR606EqHigh init 1
gkTR606Fader init 1
gkTR606Pan init 50

instr TR606
  SDrumName strget p4
  kPitch = p5
  kVelocity = p6
  kKillSwitch = p7
  iSaturated = p8
  iAccent = p9

  SFullPath = "instruments/TR606/Roland TR-606/"
  if (iSaturated == 1) then
    SFullPath strcat SFullPath, "Saturated/"
  else
    SFullPath strcat SFullPath, "Normal/"
  endif

  if (iAccent == 1) then
    SFullPath strcat SFullPath, "accent"
  endif

  SFullPath strcat SFullPath, SDrumName
  SFullPath strcat SFullPath, ".wav"

  if (kKillSwitch == 0) then
    a8081  diskin SFullPath, kPitch
  endif

  kres1 rms (a8081 * kVelocity)

  a8083 gain a8081, kres1

  outleta "OutL", a8083
  outleta "OutR", a8083
endin

instr TR606BassKnob
  gkTR606EqBass linseg p4, p3, p5
endin

instr TR606MidKnob
  gkTR606EqMid linseg p4, p3, p5
endin

instr TR606HighKnob
  gkTR606EqHigh linseg p4, p3, p5
endin

instr TR606Fader
  gkTR606Fader linseg p4, p3, p5
endin

instr TR606Pan
  gkTR606Pan linseg p4, p3, p5
endin

instr TR606MixerChannel
  aTR606L inleta "InL"
  aTR606R inleta "InR"

  aTR606L, aTR606R mixerChannel aTR606L, aTR606R, gkTR606Fader, gkTR606Pan, gkTR606EqBass, gkTR606EqMid, gkTR606EqHigh

  outleta "OutL", aTR606L
  outleta "OutR", aTR606R
endin
