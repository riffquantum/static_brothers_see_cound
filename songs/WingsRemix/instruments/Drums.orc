#include "./instruments/DL1.orc"
#include "./instruments/DL2.orc"
#include "./instruments/DL2G.orc"
#include "./instruments/DL2Alt.orc"
#include "./instruments/DL3.orc"
#include "./instruments/KickHelix.orc"
#include "./instruments/CymbalEq.orc"
#include "./instruments/KickEq.orc"
#include "./instruments/SnareEq.orc"
#include "./instruments/DrumEq.orc"

$BUS(SnareBus'SnareEq)
$REVERSE_DELAY(SnareDelay'DrumBus'BassDelayInput'4)
$BUS(DrumBus'DrumEq)
$LIVE_SYNCLOOP(DrumGrain'PreMixer'PreMixer')
$DRUM_SAMPLE_PLUS(FalseHat'CloserVerbInput'localSamples/Drums/Electro-Drums_Closed-Hat_A8037.wav'0'1'+'0'-1)
$DRUM_SAMPLE_PLUS(CloserKick'PreMixer'localSamples/How Wings Are Attached Remix/CloserKick.wav'0'1'+'0'-1)
$DRUM_SAMPLE_PLUS(CloserSnare'CloserVerbInput'localSamples/How Wings Are Attached Remix/CloserSnare.wav'0'1'+'0'-1)
$DISTORTED_808_KICK(Dist808'PreMixer'localSamples/Drums/TR-808_Kick_41.wav)
$DARKSIDE_50_REVERB(CloserVerb'PreMixer'PreMixer)
$DARKSIDE_50_REVERB(CloserVerb2'PreMixer'PreMixer)
$BREAK_SAMPLE(AmenBreak'PreMixer'localSamples/amenBreak.wav'16)
