#define FLUTE_STRETCH_SETTINGS #
  kTimeStretch = .1
  kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kTimeStretch = 1 + poscil(1, .25) + poscil(.2, .3) * linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 0)
  kTimeStretch = .1 ;.25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kGrainSizeAdjustment = .01 ;* linseg(1, beatsToSeconds(1), 1, beatsToSeconds(3), .2)
  kGrainFrequencyAdjustment = 4 ; .5 * linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
  kPitchAdjustment = linseg(1, p3, .1)
  kGrainOverlapPercentageAdjustment = .9 ;2 * linseg(1, beatsToSeconds(3), 1, beatsToSeconds(1), 5)
#
$SYNCLOOP_SAMPLER(FluteStretch'Mixer'localSamples/IcemanFlute.wav'$FLUTE_STRETCH_SETTINGS'0'1.2)
