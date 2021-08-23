#define HAT_FLOW_GRAIN_SETTINGS #
  ;Grain Parameter Adjustments
  kTimeStretch = 1 ;+ oscil(.9, 1/beatsToSeconds(4))
  kGrainSizeAdjustment = 1.1
  kGrainFrequencyAdjustment = (2/3) / 2
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1
#
$TWISTED_UP_HAT(HatFlow'DrumKitPreBus'localSamples/Drums/Beatbox-Drums_Closed-Hat_EA7544.wav'$HAT_FLOW_GRAIN_SETTINGS)

#define Kick_FLOW_GRAIN_SETTINGS #
  iKickLength filelen "localSamples/Drums/TR-909_Kick_EA7411.wav"

  ;Grain Parameter Adjustments
  kTimeStretch = 1
  kGrainSizeAdjustment = 1 ;+ oscil(.9, 1/beatsToSeconds(4))
  kGrainFrequencyAdjustment = ((2/3) / 4) + oscil(.2, 1/beatsToSeconds(8))
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1
#
$TWISTED_UP_HAT(KickFlow'DrumKitPreBus'localSamples/Drums/TR-909_Kick_EA7411.wav'$Kick_FLOW_GRAIN_SETTINGS)

#define Ride_FLOW_GRAIN_SETTINGS #
  ;Grain Parameter Adjustments
  kTimeStretch = .8  ;+ oscil(.5, 1/beatsToSeconds(16))
  kGrainSizeAdjustment = .2 + oscil(.1, 1/beatsToSeconds(16))
  kGrainFrequencyAdjustment = 1 + oscil(.9, 1/beatsToSeconds(4))
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1
#
$TWISTED_UP_HAT(RideFlow'DrumKitPreBus'localSamples/Drums/R8-Drums_Ride_E741.wav'$Ride_FLOW_GRAIN_SETTINGS)

$DRUM_SAMPLE(Rim'DrumKitPreBus'localSamples/Drums/Electro-Drums_Rim_A8043.wav'0'1)
; $DRUM_SAMPLE(Rim'DrumKitPreBus'localSamples/Drums/Linn-Drum_Rim_7.wav'0'1)

$DRUM_SAMPLE(Snare'DrumKitPreBus'localSamples/Drums/Mixed-Drums_Snare_EA8535.wav'0'1)

$DRUM_SAMPLE(Kick'DrumKitPreBus'localSamples/Drums/TR-909_Kick_EA7411.wav'0'1)
; $DRUM_SAMPLE(Kick'DrumKitPreBus'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)


$BUS(DrumKitPreBus'DrumKitEffectChain)
$EFFECT_CHAIN(DrumKitEffectChain'DrumKitPostBus)
$BUS(DrumKitPostBus'Mixer)
