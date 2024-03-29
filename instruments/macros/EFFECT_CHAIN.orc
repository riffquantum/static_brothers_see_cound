/*
  EFFECT_CHAIN
  Creates a standardized effect chain with one of a bunch of effects for
  quick, convenient effect chains. The mixer channel for the chain occurs
  after all effect instruments.

  Macro Arguments:
    $EFFECT_CHAIN_NAME - String - Name for the effect chain. All effect instrument
      names and routes will be based on it.
    $ROUTE - String - The route for the final output of the chain.
*/

#define EFFECT_CHAIN(EFFECT_CHAIN_NAME'ROUTE) #
  alwayson "$EFFECT_CHAIN_NAME"
  stereoRoute "$EFFECT_CHAIN_NAME", "$EFFECT_CHAIN_NAME.TapeWobbleInput"
  stereoRoute "$EFFECT_CHAIN_NAME.MixerChannel", "$ROUTE"

  instr $EFFECT_CHAIN_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $TAPE_WOBBLE($EFFECT_CHAIN_NAME.TapeWobble'$EFFECT_CHAIN_NAME.CompressorInput'$EFFECT_CHAIN_NAME.CompressorInput)
  $COMPRESSOR($EFFECT_CHAIN_NAME.Compressor'$EFFECT_CHAIN_NAME.PitchShifterInput'$EFFECT_CHAIN_NAME.PitchShifterInput)
  $PITCH_SHIFTER($EFFECT_CHAIN_NAME.PitchShifter'$EFFECT_CHAIN_NAME.K35LpfInput'$EFFECT_CHAIN_NAME.K35LpfInput)
  $K35_LPF($EFFECT_CHAIN_NAME.K35Lpf'$EFFECT_CHAIN_NAME.LowPassFilterInput'$EFFECT_CHAIN_NAME.LowPassFilterInput)
  $LOW_PASS_FILTER($EFFECT_CHAIN_NAME.LowPassFilter'$EFFECT_CHAIN_NAME.ClipInput'$EFFECT_CHAIN_NAME.ClipInput)
  $CLIP($EFFECT_CHAIN_NAME.Clip'$EFFECT_CHAIN_NAME.DistortionInput'$EFFECT_CHAIN_NAME.DistortionInput)
  $DISTORTION($EFFECT_CHAIN_NAME.Distortion'$EFFECT_CHAIN_NAME.MultiStageDistortionInput'$EFFECT_CHAIN_NAME.MultiStageDistortionInput)
  $MULTI_STAGE_DISTORTION($EFFECT_CHAIN_NAME.MultiStageDistortion'$EFFECT_CHAIN_NAME.WarmDistortionInput'$EFFECT_CHAIN_NAME.WarmDistortionInput)
  $WARM_DISTORTION($EFFECT_CHAIN_NAME.WarmDistortion'$EFFECT_CHAIN_NAME.RingModInput'$EFFECT_CHAIN_NAME.RingModInput)
  $RING_MOD($EFFECT_CHAIN_NAME.RingMod'$EFFECT_CHAIN_NAME.ChorusInput'$EFFECT_CHAIN_NAME.ChorusInput)
  $CHORUS($EFFECT_CHAIN_NAME.Chorus'$EFFECT_CHAIN_NAME.TremoloInput'$EFFECT_CHAIN_NAME.TremoloInput)
  $TREMOLO($EFFECT_CHAIN_NAME.Tremolo'$EFFECT_CHAIN_NAME.FreezerInput'$EFFECT_CHAIN_NAME.FreezerInput)
  $FREEZER($EFFECT_CHAIN_NAME.Freezer'$EFFECT_CHAIN_NAME.DelayInput'$EFFECT_CHAIN_NAME.DelayInput)
  $DELAY($EFFECT_CHAIN_NAME.Delay'$EFFECT_CHAIN_NAME.ReverbInput'$EFFECT_CHAIN_NAME.ReverbInput'5'0.25'0.8 '1'0.0)
  $MULTI_MODE_REVERB($EFFECT_CHAIN_NAME.Reverb'$EFFECT_CHAIN_NAME.MixerChannel'$EFFECT_CHAIN_NAME.MixerChannel'3)

  $MIXER_CHANNEL($EFFECT_CHAIN_NAME)
#
