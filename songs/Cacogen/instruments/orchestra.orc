$DRUM_SAMPLE_N(FalseHat'DrumBus'localSamples/Drums/Electro-Drums_Closed-Hat_A8037.wav'0)
$DRUM_SAMPLE_N(CloserKick'DrumBus'localSamples/CloserKick.wav'0)
$DRUM_SAMPLE_PLUS(CloserKick2'DrumBus'localSamples/CloserKick.wav'0'1'+'0'-1)
$DRUM_SAMPLE_N(CloserSnare'DrumBus'localSamples/CloserSnare.wav'0)
$SAMPLER_PLUS(Hand'DrumBus'localSamples/HandInTheHandBreak1.wav'8'3'1'+'0'0.005)
$SAMPLER_PLUS(Hand2'DrumBus'localSamples/HandInTheHandBreak2.wav'8'3'1'+'0'0.005)
$DRUM_SAMPLE_N(Crash'DrumBus'localSamples/Drums/Alesis-HR16A_Crash_21.wav'0)
$DRUM_SAMPLE(Crash2'DrumBus'localSamples/Drums/R8-Drums_Crash_E716.wav'0)
$BUS(DrumBus'DrumBitInput)
$BITCRUSHER(DrumBit'DrumVerbInput'DrumVerbInput)
$DARKSIDE_50_REVERB(DrumVerb'Mixer'Mixer)

#define DRUMS_SETTINGS #
  ; kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  ; kTimeStretch = 1 + poscil(.7, .3) * linseg(0, beatsToSeconds(.75), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .5 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kGrainSizeAdjustment = 1
  ; kGrainFrequencyAdjustment = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
  ; kGrainFrequencyAdjustment = linseg(1, stb(.75), 1, stb(2), 2, stb(1), 10)
  ; kPitchAdjustment = 1
  ; kGrainOverlapPercentageAdjustment = 1 ;linseg(1, beatsToSeconds(4), .5)
#
$SYNCLOOP_SAMPLER2(HandTwist'DrumBus'localSamples/HandInTheHandBreak2.wav'$DRUMS_SETTINGS'8)

instr CloserKicks
  _ "CloserKick", 0, p3, p4*.7, p5*1.25
  _ "CloserKick", 0, p3, p4*.6, p5*.8
endin

#include "songs/Cacogen/instruments/config.orc"
