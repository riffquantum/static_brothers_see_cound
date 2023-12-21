#define KICK_HELIX_SETTINGS #
  kTimeStretch = .0001 + poscil(.04, 1.87) + poscil(.2, .3)
  kGrainSizeAdjustment = .3 + poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 2 + poscil(1, 1/(bts(4))) + poscil(.2, .3)
  ; kPitchAdjustment = 1 + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
#

$SYNCLOOP_SAMPLER(KickHelix'CloserVerbInput'localSamples/CB_Kick.wav'$KICK_HELIX_SETTINGS'0'0)
$SYNCLOOP_SAMPLER(KickHelix2'CloserVerbInput'localSamples/CB_Kick.wav'$KICK_HELIX_SETTINGS'0'0)
