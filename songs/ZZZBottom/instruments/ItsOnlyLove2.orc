#define ITS_ONLY_LOVE_SETTINGS #
  iAttack = .001
  iDecay = .01
  iSustain = 1
  iRelease = .5

  kTimeStretch = 0 + poscil(1, .25) + poscil(.2, .3)
  kGrainSizeAdjustment = 1.2 + poscil(.04, .87) ;+ poscil(.2, .3)
  kGrainFrequencyAdjustment = .5 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1; + poscil(.1, .1) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 1 ;+ poscil(.04, .87) + poscil(.2, .3)
#

$SYNCLOOP_SAMPLER(ItsOnlyLove2'Mixer'localSamples/itsOnlyLoveBreak.wav'$ITS_ONLY_LOVE_SETTINGS'0'3.2)
giItsOnlyLove2EndTime = giItsOnlyLove2SampleLength - giItsOnlyLove2StartTime
