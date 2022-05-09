#define DRUMS_SETTINGS #
  ; kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  ; kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kTimeStretch = .5 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kGrainSizeAdjustment = 1
  kGrainFrequencyAdjustment = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1 ;linseg(1, beatsToSeconds(4), .5)
#
$SYNCLOOP_SAMPLER(Drums'DrumBus'instruments/breakBeatInstruments/jbShoutBreakClean.wav'$DRUMS_SETTINGS'0'0)
