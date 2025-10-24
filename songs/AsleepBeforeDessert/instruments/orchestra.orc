#define ASLEEP_IN_THE_DESSERT_GRAIN #
  kTimeStretch = 1 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
  kGrainSizeAdjustment = 10 * (poscil(.2, .25+p7))
  kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1
#

$SYNCLOOP_SAMPLER(AsleepBeforeDessert'AsleepBeforeDessertEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop2.wav'$ASLEEP_IN_THE_DESSERT_GRAIN'0'0)
$SYNCLOOP_SAMPLER(AsleepBeforeDessertBuzz'AsleepBeforeDessertEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop2.wav'$ASLEEP_IN_THE_DESSERT_GRAIN'0'0)


$EFFECT_CHAIN(AsleepBeforeDessertEffectChain'Mixer)


$SAMPLER(DarkoVoxWhole'Mixer'songs/AsleepBeforeDessert/What a Wonderful World Darko vocals.wav'0'2)
$SAMPLER(iAliveVoxWhole'Mixer'songs/AsleepBeforeDessert/what a wonderful world_ialive vox.wav'0'2)

$SAMPLER(DarkoVoxVerse1'Mixer'songs/AsleepBeforeDessert/darko vox chopped verse 1.wav'0'2)
$SAMPLER(DarkoVoxChorus'Mixer'songs/AsleepBeforeDessert/darko vox chorus.wav'0'2)
$SAMPLER(DarkoVoxVerse2'Mixer'songs/AsleepBeforeDessert/darko vox verse 2.wav'0'2)

$SAMPLER(iAliveVox'Mixer'songs/AsleepBeforeDessert/ialive vox - chopped.wav'0'2)
