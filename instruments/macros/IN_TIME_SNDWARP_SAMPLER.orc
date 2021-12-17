/*
  IN_TIME_SNDWARP_SAMPLER
  An instrument that processes and plays a sample with cSound's sndwarp opcode and
  applies time stretching to scale to gkBPM.

  Global Variables:
    SamplePath - S - Path to sample for playback.
    Channels - i - Number of channels in the sample, derived from file.
    SampleLength - i - Length of sample in seconds, derived from file.
    SampleLengthInBeats - i - Length of sample in beats.
    LengthOfBeat - i - One beat in seconds within the sample.
    BPM - i - The BPM of the sample.
    Factor - i - Ratio of global playback BPM to sample BPM
    Sample - i, table - A table containing the sample
    EnvelopeTable - i, table - A table containing the grain envelope

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.
    p6 - StartTime - Time to start sample playback from.
    p7 - EndTime - Length of the sample to play back.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $SAMPLE_PATH - String - A path to the sample for playback.
    $LENGTH_SAMPLE_IN_BEATS - Number - The length of the sample in beats.

*/

#define IN_TIME_SNDWARP_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SamplePath init "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.Channels filenchnls gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SamplePath
  gi$INSTRUMENT_NAME.SampleLengthInBeats init $LENGTH_SAMPLE_IN_BEATS
  gi$INSTRUMENT_NAME.LengthOfBeat init gi$INSTRUMENT_NAME.SampleLength / gi$INSTRUMENT_NAME.SampleLengthInBeats
  gi$INSTRUMENT_NAME.BPM init 60 /gi$INSTRUMENT_NAME.LengthOfBeat
  gi$INSTRUMENT_NAME.Factor init i(gkBPM) / gi$INSTRUMENT_NAME.BPM
  gi$INSTRUMENT_NAME.Sample ftgen 0, 0, 0, 1, gS$INSTRUMENT_NAME.SamplePath, 0, 0, 0
  gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  instr $INSTRUMENT_NAME
    iAmplitude = flexibleAmplitudeInput(p4)
    kAmplitudeEnvelope = madsr(.005, .01, 1, .01) * iAmplitude
    iFrequency = flexiblePitchInput(p5) / 261.6 ; Ratio of frequency to Middle C
    iGrainAmplitude = 1
    iStartTime = p6
    iTimeStretch = p7
    iTimeStretch = iTimeStretch == 0 ? 1/gi$INSTRUMENT_NAME.Factor : 1/gi$INSTRUMENT_NAME.Factor * iTimeStretch
    iWindowSize = 3000
    iWindowRandomization = iWindowSize * 2
    iOverlaps = 50
    iTimeMode = 0

    if gi$INSTRUMENT_NAME.Channels == 2 then
      aOutL, aOutR sndwarpst iGrainAmplitude, iTimeStretch, iFrequency, gi$INSTRUMENT_NAME.Sample, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, gi$INSTRUMENT_NAME.EnvelopeTable, iTimeMode
    else
      aOutL sndwarp iGrainAmplitude, iTimeStretch, iFrequency, gi$INSTRUMENT_NAME.Sample, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, gi$INSTRUMENT_NAME.EnvelopeTable, iTimeMode
      aOutR = aOutL
    endif

    aOutL = kAmplitudeEnvelope * aOutL
    aOutR = kAmplitudeEnvelope * aOutR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
