#define DESCENT_TWINKLE_2_SETTINGS #
  iAttack = .01
  iDecay = .01
  iSustain = 1
  iRelease = 2

  kTimeStretch = .1 ;+ poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = 10 ;+ poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1 + line(0, 1, -.01) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 2 ;+ poscil(.04, .87) + poscil(.2, .3)
#

$SYNCLOOP_SAMPLER(DescentTwinkle2'Mixer'localSamples/gloria2.wav'$DESCENT_TWINKLE_2_SETTINGS'0'2)

