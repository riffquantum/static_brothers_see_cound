$BREAK_SAMPLE(IcemanLoop'SpectralDelayInput'localSamples/IcemanLoop1.wav'12)
$BREAK_SAMPLE(Tin'GrainDelayInput'localSamples/tinTinDeoRiff2.wav'8)
$BREAK_SAMPLE(IcemanLoop2'GrainDelayInput'localSamples/IcemanFlute.wav'32)
$SAMPLE_SCRUBBER(PunishScratch'SpectralDelayInput'localSamples/ill punish you.wav'0)
$SAMPLE_SCRUBBER(Drums'Mixer'localSamples/FunkyDrummerBreak.wav'32)

$LIVE_SYNCLOOP(GrainDelay'SpectralDelayInput'SpectralDelayInput')
$SPECTRAL_DELAY(SpectralDelay'Mixer'Mixer'64)
