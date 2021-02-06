#define SETTINGS_FOR_SyncLoopSamplerTemplate2 #
  kTimeStretch = 1 * (.1 - poscil(10, .25) + poscil(.2, .3))
  kGrainSizeAdjustment = 1
  kGrainFrequencyAdjustment = 1
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1
#
$SYNCLOOP_SAMPLER(SyncLoopSamplerTemplate2'DefaultEffectChain'localSamples/windDemonStab1.wav'$SETTINGS_FOR_SyncLoopSamplerTemplate2'0)
