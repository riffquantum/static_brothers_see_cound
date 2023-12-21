$BREAK_SAMPLE(Guitar1_B52'GuitarBus'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 1 AMPEG B52.wav'48)
$BREAK_SAMPLE(Guitar1_SOL_57'GuitarBus'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 1 SOLDANO 57.wav'48)
$BREAK_SAMPLE(Guitar1_SOL_451'GuitarBus'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 1 SOLDANO 451.wav'48)
$BREAK_SAMPLE(Guitar2_B52'GuitarBus'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 2 AMPEG B52.wav'48)
$BREAK_SAMPLE(Guitar2_SOL_57'GuitarBus'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 2 SOLDANO 57.wav'48)
$BREAK_SAMPLE(Guitar2_SOL_451'GuitarBus'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 2 SOLDANO 451.wav'48)

#define GUIT1 #
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = 2

  kTimeStretch = .1 + poscil(.04, 1.87) + poscil(.2, .3)
  ; kGrainSizeAdjustment = .3 ;+ poscil(.04, .87) + poscil(.2, .3)
  ; kGrainFrequencyAdjustment = 1 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1 + poscil(0.01, .1) * (1 + kPitchBend)
  ; kGrainOverlapPercentageAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
#
$SYNCLOOP_SAMPLER(Guitar1Grain'PreMixer'localSamples/How Wings Are Attached Remix/GuitarLoop1__GTR 1 SOLDANO 57.wav'$GUIT1'48'0)


instr Guitar1
  _ "Guitar1_B52", 0, stb(p3), p4, p5, p6
  ; _ "Guitar1_SOL_57", 0, stb(p3), p4, p5, p6
  ; _ "Guitar1_SOL_451", 0, stb(p3), p4, p5, p6
endin

instr Guitar2
  _ "Guitar2_B52", 0, stb(p3), p4, p5, p6
  ; _ "Guitar2_SOL_57", 0, stb(p3), p4, p5, p6
  ; _ "Guitar2_SOL_451", 0, stb(p3), p4, p5, p6
endin

$BUS(GuitarBus'PreMixer)

#include "./instruments/MoltenGuitar.orc"
