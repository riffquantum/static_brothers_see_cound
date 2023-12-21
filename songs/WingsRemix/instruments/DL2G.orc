#define DL2G_SETTINGS #
  ; kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  ; kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kTimeStretch = 1
  kGrainSizeAdjustment = linseg(00.1, bts(1), 2)
  kGrainFrequencyAdjustment = linseg(00.1, bts(1), 2)
  kPitchAdjustment = .9
  kGrainOverlapPercentageAdjustment = linseg(1, beatsToSeconds(4), .5)
#
$SYNCLOOP_SAMPLER(DL2G_KICK'KickEq'localSamples/How Wings Are Attached Remix/DrumLoop2__KICK SENN.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_OH'DrumBus'localSamples/How Wings Are Attached Remix/DrumLoop2__OH.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_ROOMS'DrumBus'localSamples/How Wings Are Attached Remix/DrumLoop2__ROOMS.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_TOM1'DrumBus'localSamples/How Wings Are Attached Remix/DrumLoop2__TOM 1.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_TOM2'DrumBus'localSamples/How Wings Are Attached Remix/DrumLoop2__TOM 2.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_RIDE'CymbalEq'localSamples/How Wings Are Attached Remix/DrumLoop2__RIDE.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_CHINA'CymbalEq'localSamples/How Wings Are Attached Remix/DrumLoop2__CHINA.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_HH'CymbalEq'localSamples/How Wings Are Attached Remix/DrumLoop2__HH.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_SNAREBOTTOM'SnareBus'localSamples/How Wings Are Attached Remix/DrumLoop2__SNARE BOTTOM.wav'$DL2G_SETTINGS'32'0.02)
$SYNCLOOP_SAMPLER(DL2G_SNARETOP'SnareBus'localSamples/How Wings Are Attached Remix/DrumLoop2__SNARE TOP.wav'$DL2G_SETTINGS'32'0.02)
