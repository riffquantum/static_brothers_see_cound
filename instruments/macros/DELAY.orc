/*
  DELAY
  Creates an effect instrument that applies delay to a signal.

  Global Variables:
    BufferLength - i - Maximum length for delay buffer.
    Time - a - Delay time.
    FeedbackAmount - k - Feedback amount for delay.
    Level - k - Level for delay.
    StereoOffset - k - Modifies delay time applied to left and right channels in
      opposite directions.
    Release - i - Release time for instance.

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
    BUFFER_LENGTH - Number - Sets initial value for corresponding global variable.
    TIME - Number - Sets initial value for corresponding global variable.
    FEEDBACK_AMOUNT - Number - Sets initial value for corresponding global variable.
    LEVEL - Number - Sets initial value for corresponding global variable.
    STEREO_OFFSET - Number - Sets initial value for corresponding global variable.
*/

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

    aSignalOutR = aDelaySignalR * kEnvelope
    aSignalOutL = aDelaySignalL * kEnvelope

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
