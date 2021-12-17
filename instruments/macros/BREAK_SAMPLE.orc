/*
  BREAK_SAMPLER
  Looped sample playback with speed adjusted for tempo (gkBPM).

  Global Variables:
    SamplePath - S - Path to the sample for playback.
    SampleChannels - i - Number of channels in the sample, derived from the file.
    SampleLength - i - Length of sample in seconds, derived from the file.
    SampleL - i, table - Table holding the sample's left channel.
    SampleR - i, table - Table holding the sample's right channel.
    Tuning - k - Global pitch adjustment applied to the sample by multiplication.

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Pitch for the instance expressed as a factor.
    p6 - StartBeat - Number - Time to skip in the sample expressed in beats.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $SAMPLE_PATH - String - Optional chance to override init values for global
      variables.
    $LENGTH_OF_SAMPLE_IN_BEATS - Number - Total length of sample in beats. Used
      to calculate the pitch factor to keep the sample in time.
*/

#define BREAK_SAMPLE(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.SampleChannels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath
  gk$INSTRUMENT_NAME.Tuning init 1

  if gi$INSTRUMENT_NAME.SampleChannels = 2 then
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 1
    gi$INSTRUMENT_NAME.SampleR ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleL ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
    gi$INSTRUMENT_NAME.SampleR = 0
  endif

  instr $INSTRUMENT_NAME
    iAmplitude = velocityToAmplitude(p4)
    kPitch = p5 * gk$INSTRUMENT_NAME.Tuning
    iStartBeat = p6

    aOutL, aOutR breakSampler iAmplitude, kPitch, iStartBeat, gi$INSTRUMENT_NAME.SampleLength, $LENGTH_OF_SAMPLE_IN_BEATS, gi$INSTRUMENT_NAME.SampleL, gi$INSTRUMENT_NAME.SampleR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
