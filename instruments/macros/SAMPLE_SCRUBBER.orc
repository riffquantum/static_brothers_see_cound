/*
  SAMPLE_SCRUBBER
  Sample playback controlled by a global pointer. Meant to traverse samples in
  strange surprising ways or to simulate DJ scratching.

  Global Variables:
    SamplePath - S - Path to the sample for playback.
    SampleChannels - i - Number of channels in the sample, derived from the file.
    SampleLength - i - Length of sample in seconds, derived from the file.
    SampleL - i, table - Table holding the sample's left channel.
    SampleR - i, table - Table holding the sample's right channel.
    Tuning - k - Global pitch adjustment applied to the sample by multiplication.
    NormalizePointer - i - If non-zero, then the pointer will work as a percentage
      expressed between 0 and 1. If zero and sample length is unspecified then the
      pointer will be in seconds. If zero and sample length is specificied then the
      pointer will be in beats.
    WrapTable - i - If non-zero then the pointer will loop over the sample when it goes
      beyond the sample length.
    Pointer - a - The pointer for sample playback. This instrument requires active
      control of this value for it's performance. It's numerical value should be appropriate
      for the timing mode (Normalized 0-1, seconds, or beats). A simple example would be
      to use the phasor opcode. You could simply play the sample as with
        ga$INSTRUMENT_NAME.Pointer = phasor(1/{sample length}) * {sample length}
      or more complex manipulations could be achieved by defining lines that move
      forward and backward over the sample:
        ga$INSTRUMENT_NAME.Pointer = linseg:a(0, 1, {sample length}/2, .5, 0, .5, {sample length})

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Pitch for the instance expressed as a factor. Multiplies
      the pointer position.
    p6 - StartBeat - Number - Time to skip in the sample expressed in beats. Is
      added to the pointer position.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $SAMPLE_PATH - String - Optional chance to override init values for global
      variables.
    $LENGTH_OF_SAMPLE_IN_BEATS - Number - Total length of sample in beats. Used
      to calculate the pitch factor to keep the sample in time.
*/

#define SAMPLE_SCRUBBER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.SampleChannels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath
  gk$INSTRUMENT_NAME.Tuning init 1

  gi$INSTRUMENT_NAME.NormalizePointer init 0
  gi$INSTRUMENT_NAME.WrapTable init 0

  gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 1
  if gi$INSTRUMENT_NAME.SampleChannels = 2 then
    gi$INSTRUMENT_NAME.SampleR ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 2
  endif

  ga$INSTRUMENT_NAME.Pointer init 0

  instr $INSTRUMENT_NAME
    iAmplitude = velocityToAmplitude(p4)
    aAmplitudeEnvelope = madsr:a(.005, .01, 1, .01) * iAmplitude
    kPitch = (p5 == 0 ? 1 : p5) * gk$INSTRUMENT_NAME.Tuning
    iStartBeat = p6

    iSampleLengthInBeats = $LENGTH_OF_SAMPLE_IN_BEATS

    aPointer = (ga$INSTRUMENT_NAME.Pointer + iStartBeat) * kPitch

    if gi$INSTRUMENT_NAME.NormalizePointer != 0 then
      aPointer = aPointer
    elseif iSampleLengthInBeats > 0 then
      aPointer /= $LENGTH_OF_SAMPLE_IN_BEATS
    else
      aPointer /= gi$INSTRUMENT_NAME.SampleLength
    endif

    if gi$INSTRUMENT_NAME.WrapTable != 0 then
      aPointer = aPointer % 1
    endif

    aOutL table aPointer, gi$INSTRUMENT_NAME.SampleL, 1

    if gi$INSTRUMENT_NAME.SampleChannels = 2 then
      aOutR table aPointer, gi$INSTRUMENT_NAME.SampleR, 1
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
