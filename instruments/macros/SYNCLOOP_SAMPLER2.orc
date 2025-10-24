#define SYNCLOOP_SAMPLER2(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'GRAIN_AND_ADSR_SETTINGS'LENGTH_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SampleFilePath init "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.NumberOfChannels filenchnls gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.StartTime init 0
  gi$INSTRUMENT_NAME.EndTime init gi$INSTRUMENT_NAME.SampleLength

  ; gi$INSTRUMENT_NAME.EnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
  ; gi$INSTRUMENT_NAME.EnvelopeTable ftgen 1, 0, 8192, 20, 2, 1
  gi$INSTRUMENT_NAME.EnvelopeTable ftgen 0, 0, 28, 2, 0, .75, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, .25, 0
  ; gi$INSTRUMENT_NAME.EnvelopeTable = sineWave()
  ; gi$INSTRUMENT_NAME.EnvelopeTable ftgen 0, 0, 129, 5, 1, 100, 0.0001, 29

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

    if iBeatsInSample != 0 then
      iLengthOfBeat = filelen(gS$INSTRUMENT_NAME.SampleFilePath) / iBeatsInSample
      iBreakBPM = 60 / iLengthOfBeat

      kTempoFactor = (gkBPM / iBreakBPM)

      iStartTime *= iLengthOfBeat
      iEndTime *= iLengthOfBeat
    endif

    ; The best version of this would be to calculate optimum params based on
    ;  pitch and timescale changes
    ; kTimeStretch = .25


    ;Base settings for Granulizer
    kPitch *= kPitchAdjustment
    ; kGrainSize = limit(.1 * kGrainSizeAdjustment, 100/sr, 100)
    ; kGrainFrequency = (1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment)

    ; 1/((.5)/(100/50) = 4
    ; 1/((.01)/(100/50) = 200
    ; kGrainFrequency = (1/((.001)/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment)

    ; kGrainFrequency = kPitch/kTempoFactor * 200

    ; This is a pretty good setting for clean pitch shifting but I get that
    ; weird attack fade in that I don't like. What's going on there?
    ; kGrainFrequency = kPitch/kTempoFactor * 200 * kGrainFrequencyAdjustment


    ; kGrainFrequency = kPitch/kTempoFactor * 5 * kGrainFrequencyAdjustment
    ; kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    ; kGrainSize = limit(2*(1/kGrainFrequency) * kGrainSizeAdjustment, 100/sr, 100)



    kGrainFrequency = kPitch/kTempoFactor * 5 * kGrainFrequencyAdjustment
    kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    kTimeStretch *= (50/kGrainOverlapPercentage)
    kGrainSize = limit(2*(1/kGrainFrequency) * kGrainSizeAdjustment, 100/sr, 100)

    ; kGrainSize = limit(.05 * kGrainSizeAdjustment, 100/sr, 100)
    ; kGrainFrequency = 1/(kGrainSize/2)

    ; seems like grain freq of 200 is perfect for pitch of .89 so maybe there's a ratio there that will work.
    ; OH but that's not the whole story because of tempo based time stretching
    ; .01/.89
    ; 95/106.697
    ;

    kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
    kPointerRandomizer = 1 + k(rand(gk$INSTRUMENT_NAME.PointerRandomization, 0))
    kPointerRate *= kPointerRandomizer ; Adding a small random variance to the pointer can elimante some artifacts
    kPointerRate *= kTempoFactor

    iMaxOverlaps = 1000
    ; kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    ; kGrainSize = limit(.1 * kGrainSizeAdjustment, 100/sr, 100)
    ; kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
    ; kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
    ; iMaxOverlaps = 1000


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
