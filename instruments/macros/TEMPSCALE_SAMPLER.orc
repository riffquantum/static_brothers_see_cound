/*
  SNDWARP_SAMPLER
  An instrument that processes and plays a sample with cSound's sndwarp opcode.

  Global Variables:
    SampleFilePath - S - Path to sample for playback.
    NumberOfChanne2ls - i - Number of channels in sample, derived from file.
    SampleLength - i - Length of sample in seconds, derived from file.
    StartTime - i - Starting point within file to sample.
    EndTime - i - End point within file to sample.
    EnvelopeTable - i - The grain envelope for playback.
    SampleRate - i - The sample rate of the sample, derived from file.
    SampleTableL - i - If sample is stereo, the table for the left channel.
    SampleTableR - i - If sample is stereo, the table for the right channel.
    SampleTable - i - If sample is monoo, the table for the sample.
    TimeStretch - k - Global modifier for time stretching applied to sample.
    GrainSizeAdjustment - k - Global modifier for grain size.
    GrainFrequencyAdjustment - k - Global modifier for the grain frequency.
    PitchAdjustment - k - Global modifier for the pitch of sample playback.
    OverlapPercentageAdjustment - k - Global modifier for the grain overlap percentage.

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.
    p6 - TimeStretch - Per instance modifier of corresponding global variable.
    p8 - GrainSizeAdjustment -  Per instance modifier of corresponding global variable.
    p9 - GrainFrequencyAdjustment -  Per instance modifier of corresponding global variable.
    p10 - PitchAdjustment -  Per instance modifier of corresponding global variable.
    p11 - OverlapPercentageAdjustment -  Per instance modifier of corresponding global variable.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $ROUTE - String - The route for the instrument.
    $SAMPLE_PATH - String - A path to the sample for playback.
    $GRAIN_AND_ADSR_SETTINGS - Set of variables - Optional place to override the per instance values of certain granular
      synethesis variables and ADSR values. Example:
        #define EXAMPLE_SETTINGS #
          iAttack = .01
          iDecay = .01
          iSustain = 1
          iRelease = .1

          kTimeStretch = 1
          kGrainSizeAdjustment = 1
          kGrainFrequencyAdjustment = 1
          kPitchAdjustment = 1
          kOverlapPercentageAdjustment = 1
        #
    $LENGTH_SAMPLE_IN_BEATS - Number - The length of the sample in beats. If provided, the pointer
      rate will be modified to match the global tempo (gkBPM). A 0 value keeps the sample decoupled
      from the global tempo.
    $SAMPLE_START_TIME - Number - Time in seconds to start the sample from during table creation.
*/

#define MINCER_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_SAMPLE_IN_BEATS'SAMPLE_START_TIME) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SampleFilePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.NumberOfChannels filenchnls gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.StartTime = $SAMPLE_START_TIME
  gi$INSTRUMENT_NAME.EndTime = gi$INSTRUMENT_NAME.SampleLength ;- gi$INSTRUMENT_NAME.StartTime
  gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
  gi$INSTRUMENT_NAME.SampleRate filesr gS$INSTRUMENT_NAME.SampleFilePath

  if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
    gi$INSTRUMENT_NAME.SampleTableL ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 1
    gi$INSTRUMENT_NAME.SampleTableR ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleTable ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 0
  endif

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1

  instr $INSTRUMENT_NAME
    iFFTSize = 2048
    iDecimation = 4
    kPhaseLocking = p6

    ; Pitch and Amplitude Inputs
    iAmplitude flexibleAmplitudeInput p4
    iPitch = flexiblePitchInput(p5)
    kPitch = iPitch / 261.626
    kPitchBend = 0
    midipitchbend kPitchBend, 0, 100
    kPitch *= gk$INSTRUMENT_NAME.PitchAdjustment

    kTimeStretch = (p6 == 0 ? 1 : p6) * gk$INSTRUMENT_NAME.TimeStretch

    ; Envelope Settings
    iAttack = .01
    iDecay = .01
    iSustain = 1
    iRelease = .1
    kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

    iBeatsInSample = $LENGTH_SAMPLE_IN_BEATS

    aTimeWarpPointer = phasor(1/gi$INSTRUMENT_NAME.SampleLength) * gi$INSTRUMENT_NAME.SampleLength

    if iBeatsInSample != 0 then
      iLengthOfBeat = filelen(gS$INSTRUMENT_NAME.SampleFilePath) / iBeatsInSample
      iBreakBPM = 60 / iLengthOfBeat

      kTimeStretch *= (gkBPM / iBreakBPM)
    endif

    aTimeWarpPointer = aTimeWarpPointer * 1/kTimeStretch % gi$INSTRUMENT_NAME.SampleLength

    if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
      aSignalL mincer aTimeWarpPointer, 1, kPitch, gi$INSTRUMENT_NAME.SampleTableL, kPhaseLocking, iFFTSize, iDecimation
      aSignalR mincer aTimeWarpPointer, 1, kPitch, gi$INSTRUMENT_NAME.SampleTableR, kPhaseLocking, iFFTSize, iDecimation

      aSignalL = aSignalL * kAmplitudeEnvelope
      aSignalR = aSignalR * kAmplitudeEnvelope
    else
      aSignalL mincer aTimeWarpPointer, 1, kPitch, gi$INSTRUMENT_NAME.SampleTableL, kPhaseLocking, iFFTSize, iDecimation
      aSignalR = aSignalL
    endif

    outleta "OutL", aSignalL
    outleta "OutR", aSignalR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
