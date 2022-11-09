/*
  DRUM_SAMPLE
  Creates an instrument that plays back a sample once per instrument instance. Not
  suitable for direct MIDI input.

  Global Variables:
    SamplePath - S - The path to the sample as a string.
    Sample - i - The sample loaded into a normalized table.
    Tuning - k - Every instance's pitch will be multiplied by this value

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - A pitch factor. Sample speed will be multiplied by it.
      0 defaults to 1.

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
*/

#define DRUM_SAMPLE_V1(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'SHOULD_RESPECT_P3'VELOCITY_CURVE) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
  gk$INSTRUMENT_NAME.Tuning init 1

  instr $INSTRUMENT_NAME
    aSampleL, aSampleR drumSample gi$INSTRUMENT_NAME.Sample, p4, p5 * gk$INSTRUMENT_NAME.Tuning, $SHOULD_RESPECT_P3, $VELOCITY_CURVE

    outleta "OutL", aSampleL
    outleta "OutR", aSampleR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
