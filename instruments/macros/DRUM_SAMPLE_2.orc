/*
  DRUM_SAMPLE_2
  Expanded version of DRUM_SAMPLE. Creates an instrument that plays back a sample once per instrument instance. Not
  suitable for direct MIDI input.

  Global Variables:
    SamplePath - S - The path to the sample as a string.
    Sample - i - The sample loaded into a normalized table.
    Tuning - k - Every instance's pitch will be multiplied by this value

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Depending on $PITCH_MODE either a simple pitch factor
      or a flexible pitch value (MIDI, pitch class, or Hz)

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $ROUTE - String - The route for the instrument's output
    $SAMPLE_PATH - String - A path to an audio sample
    $SHOULD_RESPECT_P3 - 1 or 0 - If 1 then the sample will play for the
      duration of the note instance (p3). If 0 then the sample will play once
      in its entirety.
    $VELOCITY_CURVE - Number >= 0 - Velocity will be adjusted along a curve.
      Use 1 for a linear result. Use a number below
      1 for a slow start and fast finish curve (droop). Use a number
      above one for a fast start and slow finish curve (hump).
    $NORMALIZE_SIGN - +/- - Determiens whether or not the sample table should
      be normalized. Use '-' if you really want the drums to knock.
    $PITCH_MODE - 1 or 0 - Determines if p5 should expect a simple pitch factor
      or a flexible pitch value (MIDI, pitch class, or Hz).
    $RELEASE_TIME - Number, -1 defaults to 0.01 - Set the release time for the sample's envelope.
*/


#define DRUM_SAMPLE_2(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'SHOULD_RESPECT_P3'VELOCITY_CURVE'NORMALIZE_SIGN'PITCH_MODE'RELEASE_TIME) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
  gk$INSTRUMENT_NAME.Tuning init 1

  instr $INSTRUMENT_NAME
    if $PITCH_MODE == 1 then
      iPitch = flexiblePitchInput(p5)/261.626
    else
      iPitch = p5
    endif

    aSampleL, aSampleR drumSample gi$INSTRUMENT_NAME.Sample, p4, p5 * gk$INSTRUMENT_NAME.Tuning, $SHOULD_RESPECT_P3, $VELOCITY_CURVE, $RELEASE_TIME

    outleta "OutL", aSampleL
    outleta "OutR", aSampleR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
