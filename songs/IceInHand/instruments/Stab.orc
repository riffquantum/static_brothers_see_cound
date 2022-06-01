#define STAB_SETTINGS #
  iRelease = .75
  ; kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  ; kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kTimeStretch = .25
  kGrainSizeAdjustment = 1
  kGrainFrequencyAdjustment = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), .93)
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = linseg(1, beatsToSeconds(4), .5)
#
$SYNCLOOP_SAMPLER(Stab'IcemanLoopDelayInput'localSamples/windDemonStab1.wav'$STAB_SETTINGS'0'0)
