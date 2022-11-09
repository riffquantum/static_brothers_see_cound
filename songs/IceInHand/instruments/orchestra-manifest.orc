; Drums
$DRUM_SAMPLE_V2(OpenHat1'DrumBus'localSamples/Drums/Alesis-HR16A_Open-Hat_27.wav'1'1'+'0'-1)
$DRUM_SAMPLE_V2(OpenHat2'DrumBus'localSamples/Drums/Alesis-HR16A_Open-Hat_28.wav'1'1'+'0'-1)
$DRUM_SAMPLE_V2(ClosedHat'DrumBus'localSamples/Drums/Alesis-HR16A_Closed-Hat_16.wav'1'1'+'0'-1)
$DRUM_SAMPLE_V2(Crash'DrumBus'localSamples/Drums/Alesis-HR16A_Crash_21.wav'0'1'+'0'-1)
$DRUM_SAMPLE_V2(Kick'DrumBus'localSamples/Drums/Alesis-HR16A_Kick_04.wav'0'0'+'0'0)
$DRUM_SAMPLE_V2(Snare'DrumBus'localSamples/Drums/Mixed-Drums_Snare_EA8519.wav'1'1'+'0'-1)
$DRUM_SAMPLE_V2(Snare2'DrumBus'localSamples/Drums/Vinylistics-3_Snare_VC25.wav'1'1'+'0'-1)
#include "Drums.orc"

; Drum Bus
$BUS(DrumBus'DrumDistInput)
$CLIP(DrumDist'DrumPostBus'DrumPostBus)
$BUS(DrumPostBus'Mixer)
alwayson "DrumDist"
;
; Samples
#include "Stab.orc"
#include "Piano.orc"

$BREAK_SAMPLE(IcemanLoop'IcemanLoopDelayInput'localSamples/IcemanLoop1.wav'12)
$BREAK_SAMPLE(IcemanLoop2'IcemanLoopDelayInput'localSamples/IcemanLoop2.wav'12)
$DELAY(IcemanLoopDelay'Mixer'Mixer'5'0.5'0.8 '1'0.0)

$BREAK_SAMPLE(IcemanFlute'Mixer'localSamples/IcemanFlute.wav'24)


; EXPERIMENTS

#define KICK_PARAMS #
  kModRamp = linseg(0, filelen("localSamples/CB_Kick.wav") * 2, 0, beatsToSeconds(1), 1)

  kTimeStretch = 1 + (oscil(1, beatsToSeconds(1)) * kModRamp)
  kGrainSizeAdjustment = linseg(1, filelen("localSamples/CB_Kick.wav") * 2, 1, beatsToSeconds(1), .5) + (oscil(.2, beatsToSeconds(2)) * kModRamp)
  kGrainFrequencyAdjustment = 1 ;+ (2 + poscil(.04, .87) + poscil(.2, .3)) * kModRamp
  kPitchAdjustment = 1 ;+ (poscil(.1, .1, -1, .5) * (1 + kPitchBend))* kModRamp
  kGrainOverlapPercentageAdjustment = .5 ;+ (poscil(.04, .87) + poscil(.2, .3))* kModRamp
#

$SYNCLOOP_SAMPLER(TwistedUpKick'DrumBus'localSamples/CB_Kick.wav'$KICK_PARAMS'0'0)

#define HAT #
  kModRamp = linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1), 1)

  kTimeStretch = oscil(1, beatsToSeconds(1)) + oscil(1, beatsToSeconds(3))
  kGrainSizeAdjustment = (.5 + oscil(.2, beatsToSeconds(2)))
  kGrainFrequencyAdjustment = 1 ;+ (2 + poscil(.04, .87) + poscil(.2, .3)) * kModRamp
  kPitchAdjustment = 1 ;+ (poscil(.1, .1, -1, .5) * (1 + kPitchBend))* kModRamp
  kGrainOverlapPercentageAdjustment = 1 ;+ (poscil(.04, .87) + poscil(.2, .3))* kModRamp


  kTimeStretch = .01 + poscil(.04, 1.87) + poscil(.2, .3)
  kGrainSizeAdjustment = .3 + poscil(.04, .87) + poscil(.2, .3)
  kGrainFrequencyAdjustment = 3 + poscil(.04, .87) + poscil(.2, .3)
  kPitchAdjustment = 1 + poscil(.01, .5) * (1 + kPitchBend)
  kGrainOverlapPercentageAdjustment = 20 + poscil(.04, .87) + poscil(.2, .3)
#

$SYNCLOOP_SAMPLER(TwistedUpHat'DrumBus'localSamples/Drums/Alesis-HR16A_Closed-Hat_16.wav'$HAT'0'0)


  #define SNARE #
  kModRamp = linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1), 1)

  kTimeStretch = oscil(1, beatsToSeconds(1), -1, .5)
  kGrainSizeAdjustment = (.5 + oscil(.2, beatsToSeconds(2)))
  kGrainFrequencyAdjustment = 1 ;+ (2 + poscil(.04, .87) + poscil(.2, .3)) * kModRamp
  kPitchAdjustment = 1 ;+ (poscil(.1, .1, -1, .5) * (1 + kPitchBend))* kModRamp
  kGrainOverlapPercentageAdjustment = 1 ;+ (poscil(.04, .87) + poscil(.2, .3))* kModRamp
#

$SYNCLOOP_SAMPLER(TwistedUpSnare'DrumBus'localSamples/Drums/Mixed-Drums_Snare_EA8519.wav'$SNARE'0'0)

$BREAK_SAMPLE(AjqLoop'Mixer'localSamples/ajq-shortloop2.wav'4.25)

#define AJQLOOP2_SETTINGS #
  kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = 1 ;+ poscil(1, .25) + poscil(.2, .3) * linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 0)
  kGrainSizeAdjustment = 1
  kGrainFrequencyAdjustment = 1; linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
  kPitchAdjustment = .5
  kGrainOverlapPercentageAdjustment = 1 ;linseg(1, beatsToSeconds(4), .5)
#
$SYNCLOOP_SAMPLER(AJQLoop2'DrumBus'localSamples/ajq-shortloop2.wav'$AJQLOOP2_SETTINGS'0'0)
