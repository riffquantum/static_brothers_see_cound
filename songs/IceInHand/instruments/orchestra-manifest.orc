$DRUM_SAMPLE_2(OpenHat1'DrumBus'localSamples/Drums/Alesis-HR16A_Open-Hat_27.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(OpenHat2'DrumBus'localSamples/Drums/Alesis-HR16A_Open-Hat_28.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(ClosedHat'DrumBus'localSamples/Drums/Alesis-HR16A_Closed-Hat_16.wav'1'1'+'0'-1)
$DRUM_SAMPLE_2(Crash'DrumBus'localSamples/Drums/Alesis-HR16A_Crash_21.wav'0'1'+'0'-1)

$BREAK_SAMPLE(IcemanLoop'Mixer'localSamples/IcemanLoop1.wav'12)
$DRUM_SAMPLE_2(Kick'DrumBus'localSamples/Drums/Alesis-HR16A_Kick_04.wav'0'0'+'0'0)
$DRUM_SAMPLE_2(Snare'DrumBus'localSamples/Drums/Alesis-HR16A_Snare_47.wav'1'1'+'0'-1)

#include "Drums.orc"
#include "Stab.orc"

; Drum Bus
$BUS(DrumBus'DrumDistInput)
$CLIP(DrumDist'DrumPostBus'DrumPostBus)
$BUS(DrumPostBus'Mixer)
