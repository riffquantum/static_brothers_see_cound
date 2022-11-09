/*
  DRUM_SAMPLE_PLUS
  Expanded version of DRUM_SAMPLE. Creates an instrument that plays back a sample once per instrument instance.Suitable for direct MIDI input.

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


#define DRUM_SAMPLE_PLUS(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'SHOULD_RESPECT_P3'VELOCITY_CURVE'NORMALIZE_SIGN'PITCH_MODE'RELEASE_TIME) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.SampleChannels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath

  if gi$INSTRUMENT_NAME.SampleChannels = 2 then
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 1
    gi$INSTRUMENT_NAME.SampleR ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, $NORMALIZE_SIGN.1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
    gi$INSTRUMENT_NAME.SampleR = 0
  endif

  ga$INSTRUMENT_NAME.Tuning init 1

  instr $INSTRUMENT_NAME
    if $PITCH_MODE == 1 || p5 == 0 then
      iPitch = flexiblePitchInput(p5)/261.626
    else
      iPitch = p5
    endif

    if iPitch < 0 then
      iPitch = abs(iPitch)
      aPointer = line:a(1, gi$INSTRUMENT_NAME.SampleLength/iPitch, 0) * ga$INSTRUMENT_NAME.Tuning
    else
      aPointer = line:a(0, gi$INSTRUMENT_NAME.SampleLength/iPitch, 1) * ga$INSTRUMENT_NAME.Tuning
    endif

    ; table3 is very noisy when the pointer goes beyond the table
    ; This cuts the noise
    aPointer = limit(aPointer, 0, 1)

    iAmplitude = velocityToAmplitude(p4, $VELOCITY_CURVE)

    if $SHOULD_RESPECT_P3 == 0 then
      xtratim limit(gi$INSTRUMENT_NAME.SampleLength / iPitch - p3, 0, 100)
      aAmplitudeEnvelope linseg iAmplitude, gi$INSTRUMENT_NAME.SampleLength/iPitch, iAmplitude
    else
      aAmplitudeEnvelope linsegr iAmplitude, gi$INSTRUMENT_NAME.SampleLength/iPitch, iAmplitude, $RELEASE_TIME, 0
    endif

    aOutL table3 aPointer, gi$INSTRUMENT_NAME.SampleL, 1

    if gi$INSTRUMENT_NAME.SampleChannels = 2 then
      aOutR table3 aPointer, gi$INSTRUMENT_NAME.SampleR, 1
    else
      aOutR = aOutL
    endif

    aOutL *= aAmplitudeEnvelope
    aOutR *= aAmplitudeEnvelope

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
