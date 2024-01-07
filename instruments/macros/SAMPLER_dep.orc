/*
  SAMPLER_dep
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

#define SAMPLER_dep(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_OF_SAMPLE_IN_BEATS) #
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
    iAmplitude = flexibleAmplitudeInput(p4)
    kPitch = flexiblePitchInput(p5)/261.6 * gk$INSTRUMENT_NAME.Tuning
    iStartBeat = p6

    iLengthOfBeat = gi$INSTRUMENT_NAME.SampleLength /  $LENGTH_OF_SAMPLE_IN_BEATS
    iBreakBPM = 60 / iLengthOfBeat

    aAmplitudeEnvelope = madsr:a(.005, .01, 1, .01) * iAmplitude

    if $LENGTH_OF_SAMPLE_IN_BEATS > 0 then
      kPitch *= 1 / gi$INSTRUMENT_NAME.SampleLength * gkBPM / iBreakBPM
      iStartTime = iStartBeat /  $LENGTH_OF_SAMPLE_IN_BEATS
    else
      kPitch *= 1 / gi$INSTRUMENT_NAME.SampleLength
      iStartTime = iStartBeat / gi$INSTRUMENT_NAME.SampleLength
    endif

    if gi$INSTRUMENT_NAME.SampleR != 0 then
      aOutR poscil aAmplitudeEnvelope, kPitch, gi$INSTRUMENT_NAME.SampleR, iStartTime
      aOutL poscil aAmplitudeEnvelope, kPitch, gi$INSTRUMENT_NAME.SampleL, iStartTime
    else
      aOutL poscil aAmplitudeEnvelope, kPitch, gi$INSTRUMENT_NAME.SampleL, iStartTime
      aOutR = aOutL
    endif

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
