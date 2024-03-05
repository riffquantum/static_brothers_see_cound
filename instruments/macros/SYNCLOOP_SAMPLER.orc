/*
  SYNCLOOP_SAMPLER
  An instrument that processes and plays a sample with cSound's syncloop opcode.

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
    GrainOverlapPercentageAdjustment - k - Global modifier for the grain overlap percentage.

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.
    p6 - TimeStretch - Per instance modifier of corresponding global variable.
    p8 - GrainSizeAdjustment -  Per instance modifier of corresponding global variable.
    p9 - GrainFrequencyAdjustment -  Per instance modifier of corresponding global variable.
    p10 - PitchAdjustment -  Per instance modifier of corresponding global variable.
    p11 - GrainOverlapPercentageAdjustment -  Per instance modifier of corresponding global variable.

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
          kGrainOverlapPercentageAdjustment = 1
        #
    $LENGTH_SAMPLE_IN_BEATS - Number - The length of the sample in beats. If provided, the pointer
      rate will be modified to match the global tempo (gkBPM). A 0 value keeps the sample decoupled
      from the global tempo.
    $SAMPLE_START_TIME - Number - Time in seconds to start the sample from during table creation.
*/

#define SYNCLOOP_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'GRAIN_AND_ADSR_SETTINGS'LENGTH_SAMPLE_IN_BEATS'SAMPLE_START_TIME) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SampleFilePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.NumberOfChannels filenchnls gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.StartTime = $SAMPLE_START_TIME
  gi$INSTRUMENT_NAME.EndTime = gi$INSTRUMENT_NAME.SampleLength ;- gi$INSTRUMENT_NAME.StartTime
  gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

  if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
    gi$INSTRUMENT_NAME.SampleTableL ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 1
    gi$INSTRUMENT_NAME.SampleTableR ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleTable ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 0
  endif

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.GrainSizeAdjustment init 1
  gk$INSTRUMENT_NAME.GrainFrequencyAdjustment init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1
  gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment init 1

  instr $INSTRUMENT_NAME
    ; Pitch and Amplitude Inputs
    iAmplitude flexibleAmplitudeInput p4
    iPitch = flexiblePitchInput(p5)
    kPitch = iPitch / 261.626
    kPitchBend = 0
    midipitchbend kPitchBend, 0, 100

    ; Envelope Settings
    iAttack = .01
    iDecay = .01
    iSustain = 1
    iRelease = .1

    ; Grain Settings
    kTimeStretch = 1
    kGrainSizeAdjustment = 1
    kGrainFrequencyAdjustment = 1
    kPitchAdjustment = 1
    kGrainOverlapPercentageAdjustment = 1

    ; Override default grain and envelope settings here. Pitch, amplitude and midi
    ; pitchbend are defined above so they can be used freely in these settings.

    $GRAIN_AND_ADSR_SETTINGS

    kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude


    iBeatsInSample = $LENGTH_SAMPLE_IN_BEATS

    ; TODO: Why is there no p7? Also why is there a second
    ; p-field for pitch? We got some problems here.
    kTimeStretch *= p6 == 0 ? 1 : p6
    kGrainSizeAdjustment *= p8 == 0 ? 1 : p8
    kGrainFrequencyAdjustment *= p9 == 0 ? 1 : p9
    kPitchAdjustment *= p10 == 0 ? 1 : p10
    kGrainOverlapPercentageAdjustment *= p11 == 0 ? 1 : p11


    ; TO DO: Add a start time param. It could shift the table or something
    ; tablemix iTable, 0, ftlen(iTable), iTable, iOffset

    kTimeStretch *= gk$INSTRUMENT_NAME.TimeStretch
    kGrainSizeAdjustment *= gk$INSTRUMENT_NAME.GrainSizeAdjustment
    kGrainFrequencyAdjustment *= gk$INSTRUMENT_NAME.GrainFrequencyAdjustment
    kPitchAdjustment *= gk$INSTRUMENT_NAME.PitchAdjustment
    kGrainOverlapPercentageAdjustment *= gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment

    ;Base settings for Granulizer
    kPitch *= kPitchAdjustment
    kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    kGrainSize = limit(.1 * kGrainSizeAdjustment, 100/sr, 100)
    kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
    kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
    iMaxOverlaps = 1000

    if iBeatsInSample != 0 then
      iLengthOfBeat = filelen(gS$INSTRUMENT_NAME.SampleFilePath) / iBeatsInSample
      iBreakBPM = 60 / iLengthOfBeat

      kPointerRate *= (gkBPM / iBreakBPM)
    endif

    if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
      aSignalL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableL, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps
      aSignalR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableR, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps

      aSignalL = aSignalL * kAmplitudeEnvelope
      aSignalR = aSignalR * kAmplitudeEnvelope
    else
      aSignalL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTable, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps
      aSignalL *= kAmplitudeEnvelope

      aSignalR = aSignalL
    endif

    outleta "OutL", aSignalL
    outleta "OutR", aSignalR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#


#define SYNCLOOP_SAMPLER2(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'GRAIN_AND_ADSR_SETTINGS'LENGTH_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SampleFilePath init "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.NumberOfChannels filenchnls gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.StartTime init 0
  gi$INSTRUMENT_NAME.EndTime init gi$INSTRUMENT_NAME.SampleLength
  gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
  gi$INSTRUMENT_NAME.SampleRate filesr gS$INSTRUMENT_NAME.SampleFilePath

  if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
    gi$INSTRUMENT_NAME.SampleTableL ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, 0, 0, 1
    gi$INSTRUMENT_NAME.SampleTableR ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, 0, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleTableL ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, 0, 0, 0
  endif

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.GrainSizeAdjustment init 1
  gk$INSTRUMENT_NAME.GrainFrequencyAdjustment init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1
  gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment init 1
  gk$INSTRUMENT_NAME.PointerRandomization init .01

  instr $INSTRUMENT_NAME
    ; Pitch and Amplitude Inputs
    iAmplitude flexibleAmplitudeInput p4
    iPitch = flexiblePitchInput(p5)
    kPitch = iPitch / 261.626
    kPitchBend = 0
    midipitchbend kPitchBend, 0, 100

    ; Envelope Settings
    iAttack = .01
    iDecay = .01
    iSustain = 1
    iRelease = .1

    ; Grain Settings
    kTimeStretch = 1
    kGrainSizeAdjustment = 1
    kGrainFrequencyAdjustment = 1
    kPitchAdjustment = 1
    kGrainOverlapPercentageAdjustment = 1

    ; Override default grain and envelope settings here. Pitch, amplitude and midi
    ; pitchbend are defined above so they can be used freely in these settings.
    $GRAIN_AND_ADSR_SETTINGS

    kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

    iBeatsInSample = $LENGTH_SAMPLE_IN_BEATS

    ; TODO: Why is there no p7? Also why is there a second
    ; p-field for pitch? We got some problems here.
    iStartTime = p6 + gi$INSTRUMENT_NAME.StartTime
    kTimeStretch *= p7 == 0 ? 1 : p7
    kGrainSizeAdjustment *= p8 == 0 ? 1 : p8
    kGrainFrequencyAdjustment *= p9 == 0 ? 1 : p9
    kGrainOverlapPercentageAdjustment *= p10 == 0 ? 1 : p10
    iEndTime = p11 + gi$INSTRUMENT_NAME.EndTime

    kTimeStretch *= gk$INSTRUMENT_NAME.TimeStretch
    kGrainSizeAdjustment *= gk$INSTRUMENT_NAME.GrainSizeAdjustment
    kGrainFrequencyAdjustment *= gk$INSTRUMENT_NAME.GrainFrequencyAdjustment
    kPitchAdjustment *= gk$INSTRUMENT_NAME.PitchAdjustment
    kGrainOverlapPercentageAdjustment *= gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment

    ;Base settings for Granulizer
    kPitch *= kPitchAdjustment
    kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    ; kGrainSize = limit(.1 * kGrainSizeAdjustment, 100/sr, 100)
    ; kGrainFrequency = (1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment)

    kGrainFrequency = (1/(.1/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment)
    kGrainSize = limit(2*(1/kGrainFrequency) * kGrainSizeAdjustment, 100/sr, 100)


    kPointerRate = (kTimeStretch * kGrainOverlapPercentage/100)
    kPointerRandomizer = 1 + k(rand(gk$INSTRUMENT_NAME.PointerRandomization, 0))
    kPointerRate *= kPointerRandomizer ; Adding a small random variance to the pointer can elimante some artifacts
    iMaxOverlaps = 1000

    ; kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    ; kGrainSize = limit(.1 * kGrainSizeAdjustment, 100/sr, 100)
    ; kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
    ; kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
    ; iMaxOverlaps = 1000

    if iBeatsInSample != 0 then
      iLengthOfBeat = filelen(gS$INSTRUMENT_NAME.SampleFilePath) / iBeatsInSample
      iBreakBPM = 60 / iLengthOfBeat

      kPointerRate *= (gkBPM / iBreakBPM)

      iStartTime *= iLengthOfBeat
      iEndTime *= iLengthOfBeat
    endif

    if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
      aSignalL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableL, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps, iStartTime
      aSignalR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableR, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps, iStartTime

      aSignalL = aSignalL * kAmplitudeEnvelope
      aSignalR = aSignalR * kAmplitudeEnvelope
    else
      aSignalL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableL, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps, iStartTime
      aSignalL *= kAmplitudeEnvelope

      aSignalR = aSignalL
    endif

    outleta "OutL", aSignalL
    outleta "OutR", aSignalR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
