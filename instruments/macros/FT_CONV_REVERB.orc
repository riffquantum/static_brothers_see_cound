#define FT_CONV_REVERB(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'IMPULSE_PATH) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'.05)

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
