/*
  DELAY_WITH_PATCH
  Creates an effect instrument that applies delay to a signal and provides a patch for further
  affecting the delay signal recursively. Patch in a pitchshifter for a descending
  delay or something cool like that.

  I originally designed it to make a granular delay. An example of that usage would be:
    $DELAY_WITH_PATCH(PatchDelay'Mixer'Mixer'GranularSynthInput)
    $LIVE_SYNCLOOP(GranularSynth'PatchDelayPatch'PatchDelayPatch')

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
    $PATCH_ROUTE - String - The route for the instrument's Patch output
*/

#define DELAY_WITH_PATCH(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'PATCH_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  gi$INSTRUMENT_NAME.BufferLength init 5
  ga$INSTRUMENT_NAME.Time init .5
  gk$INSTRUMENT_NAME.FeedbackAmount init .7
  gk$INSTRUMENT_NAME.Level init 1
  gk$INSTRUMENT_NAME.StereoOffset init 0
  gi$INSTRUMENT_NAME.Release init .1

  connect "$INSTRUMENT_NAME", "PatchOutL", "$PATCH_ROUTE", "InL"
  connect "$INSTRUMENT_NAME", "PatchOutR", "$PATCH_ROUTE", "InR"

  connect "$INSTRUMENT_NAME.Patch", "OutL", "$INSTRUMENT_NAME", "PatchInL"
  connect "$INSTRUMENT_NAME.Patch", "OutR", "$INSTRUMENT_NAME", "PatchInR"

  alwayson "$INSTRUMENT_NAME.Patch"
  instr $INSTRUMENT_NAME.Patch
    ; We could achieve this affect without this extra instrument but
    ; it big time simplifies routing by conforming to route
    ; name conventions.
    aInL inleta "InL"
    aInR inleta "InR"

    outleta "OutL", aInL
    outleta "OutR", aInR
  endin

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    aDelayTimeL = limit(ga$INSTRUMENT_NAME.Time + gk$INSTRUMENT_NAME.StereoOffset, ksmps/sr, gi$INSTRUMENT_NAME.BufferLength)
    aDelayTimeR = limit(ga$INSTRUMENT_NAME.Time - gk$INSTRUMENT_NAME.StereoOffset, ksmps/sr, gi$INSTRUMENT_NAME.BufferLength)

    aDelayBufferOutL delayr gi$INSTRUMENT_NAME.BufferLength
    aDelayBufferOutR delayr gi$INSTRUMENT_NAME.BufferLength

    aDelayOutL  deltapi aDelayTimeL
    aDelayOutR  deltapi aDelayTimeR

    aPatchInL inleta "PatchInL"
    aPatchInR inleta "PatchInR"

    delayw aInL + (aPatchInL * gk$INSTRUMENT_NAME.FeedbackAmount)
    delayw aInR + (aPatchInR * gk$INSTRUMENT_NAME.FeedbackAmount)

    kEnvelope = madsr(.01, .01, 1, gi$INSTRUMENT_NAME.Release)

    aOutR = aPatchInR * gk$INSTRUMENT_NAME.Level
    aOutL = aPatchInL * gk$INSTRUMENT_NAME.Level

    outleta "PatchOutL", aDelayOutL
    outleta "PatchOutR", aDelayOutR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
