#include "./config.orc"
#include "./PreMixer.orc"
#include "./VoxSamples.orc"
#include "./Drums.orc"
#include "./Bass.orc"
#include "./GuitarSamples.orc"

; No-Input Mixer

$SAMPLER_dep(NoInput'NoInputDelayInput'localSamples/How Wings Are Attached Remix/No-Input Dry.wav'0) // No Input Track run through a delay with a stereo offset and maybe no dry
$DELAY(NoInputDelay'PreMixer'PreMixer'5'1'.75'1'.5)


; Vocal Samples






