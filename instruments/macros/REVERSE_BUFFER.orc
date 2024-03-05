#define REVERSE_BUFFER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'BUFFER_LENGTH) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  gi$INSTRUMENT_NAME.BufferLengthInSeconds init $BUFFER_LENGTH
  gi$INSTRUMENT_NAME.RecordBufferL ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.RecordBufferR ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  ga$INSTRUMENT_NAME.Speed init 1

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    aOutL poscil 1, -1/gi$INSTRUMENT_NAME.BufferLengthInSeconds * ga$INSTRUMENT_NAME.Speed, gi$INSTRUMENT_NAME.RecordBufferL
    aOutR poscil 1, -1/gi$INSTRUMENT_NAME.BufferLengthInSeconds * ga$INSTRUMENT_NAME.Speed, gi$INSTRUMENT_NAME.RecordBufferR

    recordBuffer gi$INSTRUMENT_NAME.RecordBufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferR, aInR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
