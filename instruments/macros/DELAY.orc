#define DELAY(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'BUFFER_LENGTH'TIME'FEEDBACK_AMOUNT'LEVEL'STEREO_OFFSET) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  gi$INSTRUMENT_NAME.BufferLength init $BUFFER_LENGTH
  ga$INSTRUMENT_NAME.Time init $TIME
  gk$INSTRUMENT_NAME.FeedbackAmount init $FEEDBACK_AMOUNT
  gk$INSTRUMENT_NAME.Level init $LEVEL
  gk$INSTRUMENT_NAME.StereoOffset init $STEREO_OFFSET
  gi$INSTRUMENT_NAME.Release init .1

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aDelayTimeL = ga$INSTRUMENT_NAME.Time + gk$INSTRUMENT_NAME.StereoOffset
    aDelayTimeR = ga$INSTRUMENT_NAME.Time - gk$INSTRUMENT_NAME.StereoOffset

    aDelaySignalL delayBuffer aSignalInL, gk$INSTRUMENT_NAME.FeedbackAmount, gi$INSTRUMENT_NAME.BufferLength, aDelayTimeL, gk$INSTRUMENT_NAME.Level
    aDelaySignalR delayBuffer aSignalInR, gk$INSTRUMENT_NAME.FeedbackAmount, gi$INSTRUMENT_NAME.BufferLength, aDelayTimeR, gk$INSTRUMENT_NAME.Level

    kEnvelope = madsr(.01, .01, 1, gi$INSTRUMENT_NAME.Release)

    aSignalOutL = aSignalInL + aDelaySignalL * kEnvelope
    aSignalOutR = aSignalInR + aDelaySignalR * kEnvelope

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
