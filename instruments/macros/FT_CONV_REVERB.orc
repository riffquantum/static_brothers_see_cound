/*
  FT_CONV_REVERB
  Creates an effect instrument that generates reverb via convolution for a signal.
  Uses cSounds ftconv opcode.

  Global Variables:
    None

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
    $IMPULSE_PATH - String - Path to a sample to be used as the impulse
      response. This should be an actual impulse response but it could
      be anything. ./localSamples/IMreverbs/Parking Garage.wav is an
      example.
*/

#define FT_CONV_REVERB(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'IMPULSE_PATH) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'.05)

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    SImpulsePath = "$IMPULSE_PATH"

    iImpulseTable ftgen 0, 0, 0, 1, SImpulsePath, 0, 0, 0
    iPartitionSize = 64
    iSkipSamples = 0
    iImpulseResponseLength = 0
    iSkipInit = 0

    aSignalOutL ftconv aSignalInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
    aSignalOutR ftconv aSignalInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
