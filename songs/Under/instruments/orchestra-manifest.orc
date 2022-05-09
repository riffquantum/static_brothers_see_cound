#include "BassSynth.orc"

; Drums
$DRUM_SAMPLE(Snare'Mixer'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)
$DRUM_SAMPLE(MuffledKick'Mixer'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)
$BREAK_SAMPLE(PillarBreak'Mixer'localsamples/pillarToPostBreak.wav'15.75)
$SYNCLOOP_SAMPLER(PillarBreakGrain'Mixer'localsamples/pillarToPostBreak.wav''15.75'0)
$DRUM_SAMPLE(ClosedHat'Mixer'localSamples/Drums/R8-Drums_Closed-Hat_E703.wav'0'1)

; Samples
$BREAK_SAMPLE(VibeLine'Mixer'localsamples/ajq - vibe out.wav'5)
$BREAK_SAMPLE(VibeRiteajqajq'Mixer'localsamples/ajq - rite of spring theme.wav'12)
$BREAK_SAMPLE(VibeLine2'Mixer'localsamples/atq - autumn leaves vibe and horn 1.wav'4)
$BREAK_SAMPLE(AjqShort'Mixer'localsamples/ajq-shortloop.wav'2)
$BREAK_SAMPLE(AjqShort2'Mixer'localsamples/ajq-shortloop2.wav'2.5)
$BREAK_SAMPLE(AjqLoop'Mixer'localsamples/ajqLoop.wav'8)

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


