$DRUM_SAMPLE_V1(Snare'SnareFx'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)
$EFFECT_CHAIN(SnareFx'DrumKitBus)

$DRUM_SAMPLE_V1(MuffledKick'MuffledKickFx'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)
$EFFECT_CHAIN(MuffledKickFx'DrumKitBus)


$BUS(DrumKitBus'DrumKitFx)
$EFFECT_CHAIN(DrumKitFx'DrumKitPostBus)
$BUS(DrumKitPostBus'Mixer)
