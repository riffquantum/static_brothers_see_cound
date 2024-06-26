#include "../../../instruments/LayeredBassSynth.orc"

; #include "WhoIsHeLoop/WhoIsHeLoop.orc"
$BREAK_SAMPLE(WhoIsHeLoop'Mixer'songs/Withers/instruments/WhoIsHeLoop/WhoIsHeLoop.wav'16)
$BREAK_SAMPLE(WhoIsHeLoopMelody'WhoPitchShifterInput'songs/Withers/instruments/WhoIsHeLoop/WhoIsHeLoop.wav'16)
$PITCH_SHIFTER(WhoPitchShifter'WhoWarpInput'WhoWarpInput)
$LIVE_SNDWARP(WhoWarp'WhoMinceInput'WhoMinceInput)
$LIVE_MINCER(WhoMince'Mixer'Mixer)


; "localSamples/Drums/TR-808_Kick_005.wav"
; "localSamples/Drums/TR-808_Kick_41.wav"
$DRUM_SAMPLE_V2(EightOhEightKick'DrumBus'localSamples/Drums/TR-808_Kick_41.wav'0'0'+'0'0)
$DRUM_SAMPLE_V2(LinnKick'DrumBus'localSamples/Drums/Linn-Drum-Processed_Kick_1SubDull.wav'0'0'+'0'0)
; $DRUM_SAMPLE_V2(Kick'DrumBus'localSamples/Drums/Alesis-HR16A_Kick_04.wav'0'0'+'0'0)
#include "Kick.orc"

; "localSamples/Drums/R8-Drums_Snare_E7743.wav"
; "localSamples/Drums/Mixed-Drums_Snare_EA8529.wav"

$DRUM_SAMPLE_V2(Snare'DrumBus'localSamples/Drums/Mixed-Drums_Snare_EA8519.wav'1'1'+'0'-1)
$DRUM_SAMPLE_V2(ClosedHat'DrumBus'localSamples/Drums/Alesis-HR16A_Closed-Hat_16.wav'1'1'+'0'-1)

; Drum Bus
$BUS(DrumBus'DrumDistInput)
$CLIP(DrumDist'DrumPostBus'DrumPostBus)
$BUS(DrumPostBus'Mixer)
alwayson "DrumDist"
