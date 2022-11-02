#include "BassSynth.orc"

; Drums
$DRUM_SAMPLE(Snare'DrumBus'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)
$DRUM_SAMPLE(MuffledKick'DrumBus'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)
$BREAK_SAMPLE(PillarBreak'DrumBus'localsamples/pillarToPostBreak.wav'15.75)
$SYNCLOOP_SAMPLER(PillarBreakGrain'DrumBus'localsamples/pillarToPostBreak.wav''15.75'0)
$DRUM_SAMPLE(ClosedHat'DrumBus'localSamples/Drums/R8-Drums_Closed-Hat_E703.wav'0'1)
$BUS(DrumBus'MelodyGrainInput)
$LIVE_SYNCLOOP(DrumGrain'Mixer'Mixer')

; Samples
$BREAK_SAMPLE(VibeLine'MelodyGrainInput'localsamples/ajq - vibe out.wav'5)
$BREAK_SAMPLE(VibeRiteajqajq'MelodyGrainInput'localsamples/ajq - rite of spring theme.wav'12)
$BREAK_SAMPLE(VibeLine2'MelodyGrainInput'localsamples/atq - autumn leaves vibe and horn 1.wav'4)
$BREAK_SAMPLE(AjqShort'MelodyGrainInput'localsamples/ajq-shortloop.wav'2)
$BREAK_SAMPLE(AjqShort2'MelodyGrainInput'localsamples/ajq-shortloop2.wav'2.5)
$BREAK_SAMPLE(AjqLoop'MelodyGrainInput'localsamples/ajqLoop.wav'8)

$LIVE_SYNCLOOP(MelodyGrain'Mixer'Mixer')

$BREAK_SAMPLE(PercLoop'PercLoopReverbInput'localsamples/crazyRhythmLoop.wav'8)
$MULTI_MODE_REVERB(PercLoopReverb'Mixer'Mixer'3)

#define VIBE_LINE_GRAIN_SETTINGS #
  kTimeStretch = .03 ;+ (.1 - poscil(10, .25) + poscil(.2, .3))
  kGrainSizeAdjustment = 10 + poscil(2, .25)
  kGrainFrequencyAdjustment = 2 + (.1 - poscil(10, .25) + poscil(.2, .3))
  kPitchAdjustment = 1 ;* (1 + oscil(.025, 2))
  kGrainOverlapPercentageAdjustment = 2
#
$SYNCLOOP_SAMPLER(VibeLineGrain'Mixer'localsamples/ajq - vibe out.wav'$VIBE_LINE_GRAIN_SETTINGS'5'0)


