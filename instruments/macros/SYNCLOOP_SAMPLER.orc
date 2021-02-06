#define SYNCLOOP_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'GRAIN_SETTINGS'LENGTH_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SampleFilePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.NumberOfChannels filenchnls gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.StartTime = 0
  gi$INSTRUMENT_NAME.EndTime = gi$INSTRUMENT_NAME.SampleLength - gi$INSTRUMENT_NAME.StartTime
  gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
  gi$INSTRUMENT_NAME.SampleRate filesr gS$INSTRUMENT_NAME.SampleFilePath

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
    iAmplitude flexibleAmplitudeInput p4
    iAttack = .01
    iDecay = .01
    iSustain = 1
    iRelease = .1
    kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

    iPitch = flexiblePitchInput(p5)
    kPitch = iPitch / 261.626

    iBeatsInSample = $LENGTH_SAMPLE_IN_BEATS

    ; SSettingsString = {{$GRAIN_SETTINGS}} ; This defaulting scheme doesn't work currently because '$' returns the parent macro name instead of the value
    ; prints "%n%nSettings String: "
    ; prints SSettingsString
    ; if strcmp("", SSettingsString) == 0 then
    ;   kTimeStretch = 1
    ;   kGrainSizeAdjustment = 1
    ;   kGrainFrequencyAdjustment = 1
    ;   kPitchAdjustment = 1
    ;   kGrainOverlapPercentageAdjustment = 1
    ; else
    ;   $GRAIN_SETTINGS
    ; endif

    $GRAIN_SETTINGS

    kTimeStretch *= p6 == 0 ? 1 : p6
    kGrainSizeAdjustment *= p8 == 0 ? 1 : p8
    kGrainFrequencyAdjustment *= p9 == 0 ? 1 : p9
    kPitchAdjustment *= p10 == 0 ? 1 : p10
    kGrainOverlapPercentageAdjustment *= p11 == 0 ? 1 : p11

    kPitchBend = 0
    midipitchbend kPitchBend, 0, 100

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
