/* TR808
    Sampler using samples from the Roland TR-808 drum machine.

    p4 - Drum Name - String - valid values:
    p5 - coresponds to kpitch on diskin opcode
    p6 - amplitude modifier
    p7 - kill switch - Note will only output audio when this
        equals 0. Use it with a loop count and some arithmetic
        to turn notes on and off per measure.
*/

instrumentRoute "TR808", "Mixer"
alwayson "TR808MixerChannel"

gkTR808EqBass init 1
gkTR808EqMid init 1
gkTR808EqHigh init 1
gkTR808Fader init 1
gkTR808Pan init 50

instr TR808
  SDrumName strget p4
  SFullPath strcat "instruments/TR808/RolandTR-808/", SDrumName
  SFullPath strcat SFullPath, ".aif"
  kKillswitch init p7

  if (kKillswitch == 0) then
    a8081  diskin SFullPath, p5
  endif

  kres1 rms (a8081 * p6)

  a8083 gain a8081, kres1

  outleta "OutL", a8083
  outleta "OutR", a8083
endin

instr TR808BassKnob
  gkTR808EqBass linseg p4, p3, p5
endin

instr TR808MidKnob
  gkTR808EqMid linseg p4, p3, p5
endin

instr TR808HighKnob
  gkTR808EqHigh linseg p4, p3, p5
endin

instr TR808Fader
  gkTR808Fader linseg p4, p3, p5
endin

instr TR808Pan
  gkTR808Pan linseg p4, p3, p5
endin

instr TR808MixerChannel
  aTR808L inleta "InL"
  aTR808R inleta "InR"

  aTR808L, aTR808R mixerChannel aTR808L, aTR808R, gkTR808Fader, gkTR808Pan, gkTR808EqBass, gkTR808EqMid, gkTR808EqHigh


  outleta "OutL", aTR808L
  outleta "OutR", aTR808R
endin
