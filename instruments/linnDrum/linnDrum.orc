instrumentRoute "LinnDrum", "Mixer"

alwayson "LinnDrumMixerChannel"

gkLinnDrumEqBass init 1
gkLinnDrumEqMid init 1
gkLinnDrumEqHigh init 1
gkLinnDrumFader init 1
gkLinnDrumPan init 50

instr LinnDrum
  SModifier strget p4
  SFullPath strcat "instruments/linnDrum/LinnDrumLM-2/Normalized/", SModifier
  SFullPath strcat SFullPath, ".aif"
  kKillswitch init p7

  if (kKillswitch != 0) then
    kgoto end
  endif

  if (strcmp(SModifier, "HatOpen") == 0) then
    gaInterrupt1L, gaInterrupt1R  diskin SFullPath, p5

    kres1           rms (gaInterrupt1L * p6)
    kres2           rms (gaInterrupt1R * p6)

    gaInterrupt1L          gain gaInterrupt1L, kres1
    gaInterrupt1R          gain gaInterrupt1R, kres2
  else
    alinn1, alinn2  diskin SFullPath, p5

    kres1           rms (alinn1 * p6)
    kres2           rms (alinn2 * p6)

    alinn3          gain alinn1, kres1
    alinn4          gain alinn2, kres2
    outleta "OutL", alinn3
    outleta "OutR", alinn4
  endif

  end:
endin

instr LinnDrumBassKnob
  gkLinnDrumEqBass linseg p4, p3, p5
endin

instr LinnDrumMidKnob
  gkLinnDrumEqMid linseg p4, p3, p5
endin

instr LinnDrumHighKnob
  gkLinnDrumEqHigh linseg p4, p3, p5
endin

instr LinnDrumFader
  gkLinnDrumFader linseg p4, p3, p5
endin

instr LinnDrumPan
  gkLinnDrumPan linseg p4, p3, p5
endin

instr LinnDrumMixerChannel
  aLinnDrumL inleta "InL"
  aLinnDrumR inleta "InR"

  aLinnDrumL = aLinnDrumL + gaInterrupt1L
  aLinnDrumR = aLinnDrumR + gaInterrupt1R

aLinnDrumL, aLinnDrumR mixerChannel aLinnDrumL, aLinnDrumR, gkLinnDrumFader, gkLinnDrumPan, gkLinnDrumEqBass, gkLinnDrumEqMid, gkLinnDrumEqHigh
  outleta "OutL", aLinnDrumL
  outleta "OutR", aLinnDrumR
endin
