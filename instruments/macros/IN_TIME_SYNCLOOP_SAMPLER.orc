#define IN_TIME_SYNCLOOP_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_SAMPLE_IN_BEATS) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gk$INSTRUMENT_NAME.Hold init 12.8 ;12.8
  gk$INSTRUMENT_NAME.GrainSpacing init 54 ;54 - default setting for normal playback
  gk$INSTRUMENT_NAME.WaveSpacing init 84 ;84 - default setting for normal playback
  gk$INSTRUMENT_NAME.FxDepth init 0 ;0
  gk$INSTRUMENT_NAME.FxSpeed init .8
  gk$INSTRUMENT_NAME.Randomize init 0

  /* Sound File Data */
  gS$INSTRUMENT_NAME.sampleFilePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.SampleNumberOfBeats = $LENGTH_SAMPLE_IN_BEATS
  gi$INSTRUMENT_NAME.FileNumChannels filenchnls gS$INSTRUMENT_NAME.sampleFilePath
  gi$INSTRUMENT_NAME.FileLength filelen gS$INSTRUMENT_NAME.sampleFilePath
  gi$INSTRUMENT_NAME.FileSampleRate filesr gS$INSTRUMENT_NAME.sampleFilePath
  gi$INSTRUMENT_NAME.StartTime = 0
  gi$INSTRUMENT_NAME.EndTime = gi$INSTRUMENT_NAME.FileLength
  gi$INSTRUMENT_NAME.LengthOfOneBeat = gi$INSTRUMENT_NAME.FileLength / gi$INSTRUMENT_NAME.SampleNumberOfBeats
  gi$INSTRUMENT_NAME.BPM = 60 / gi$INSTRUMENT_NAME.LengthOfOneBeat
  gi$INSTRUMENT_NAME.Factor = i(gkBPM) / gi$INSTRUMENT_NAME.BPM

  if gi$INSTRUMENT_NAME.FileNumChannels == 2 then
    gi$INSTRUMENT_NAME.SampleTableL ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.sampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 1
    gi$INSTRUMENT_NAME.SampleTableR ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.sampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleTable ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.sampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 0
  endif

  instr $INSTRUMENT_NAME
    iAmplitude flexibleAmplitudeInput p4
    iPitch flexiblePitchInput p5
    iPitch = iPitch / 261.6 ; Ratio of frequency to Middle C
    /* Below are two options for amplitude envelope. */
    kAmplitudeEnvelope = madsr(.005, .01, 1, .01, 0, (gi$INSTRUMENT_NAME.FileLength)) * iAmplitude ;Sample plays for note duration
    ;kAmplitudeEnvelope linenr iAmplitude, .05, (gi$INSTRUMENT_NAME.FileLength * 1/iPitch), 1 ; Sample plays through entirely

    /* MIDI Pitchbend */
    kPitchBend = 0
    midipitchbend kPitchBend
    kPitch = iPitch + kPitchBend

    k$INSTRUMENT_NAME.HoldAdjustment = 1
    k$INSTRUMENT_NAME.GrainSpacingAdjustment = 1
    k$INSTRUMENT_NAME.WaveSpacingAdjustment = 1
    k$INSTRUMENT_NAME.FxDepthAdjustment = 0
    k$INSTRUMENT_NAME.FxSpeedAdjustment = 1

    k$INSTRUMENT_NAME.Hold = gk$INSTRUMENT_NAME.Hold ; * (k$INSTRUMENT_NAME.HoldAdjustment/65)^3
    k$INSTRUMENT_NAME.GrainSpacing = gk$INSTRUMENT_NAME.GrainSpacing ; * (k$INSTRUMENT_NAME.GrainSpacingAdjustment/65)^2
    k$INSTRUMENT_NAME.WaveSpacing = gk$INSTRUMENT_NAME.WaveSpacing ; * (k$INSTRUMENT_NAME.WaveSpacingAdjustment/65)^2
    k$INSTRUMENT_NAME.FxDepth = gk$INSTRUMENT_NAME.FxDepth ; * (k$INSTRUMENT_NAME.FxDepthAdjustment/65)^2
    k$INSTRUMENT_NAME.FxSpeed = gk$INSTRUMENT_NAME.FxSpeed ; * (k$INSTRUMENT_NAME.FxSpeedAdjustment/65)^2

    /* Syncloop Params */
    ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
    iMaxOverlaps = 5
    kGrainSizeInMiliseconds = k$INSTRUMENT_NAME.Hold
    kGrainSize = kGrainSizeInMiliseconds/1000
    kWaveSpacingOscillator oscil (k$INSTRUMENT_NAME.FxDepth)/100*3, k$INSTRUMENT_NAME.FxSpeed
    kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((k$INSTRUMENT_NAME.GrainSpacing*1.852/100)^2)


    /* Wavespacing Factor */
    k$INSTRUMENT_NAME.WaveSpacing = k$INSTRUMENT_NAME.WaveSpacing - 50
    if k$INSTRUMENT_NAME.WaveSpacing == 0 then
      k$INSTRUMENT_NAME.WaveSpacing = 1
    endif

    k$INSTRUMENT_NAME.WaveSpacing = (k$INSTRUMENT_NAME.WaveSpacing / 34)^3 + kWaveSpacingOscillator
    kPointerRate = (1/iMaxOverlaps) * k$INSTRUMENT_NAME.WaveSpacing * gi$INSTRUMENT_NAME.Factor

    /* Synthesis and Output */
    if gi$INSTRUMENT_NAME.FileNumChannels == 2 then
      aOutL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableL, ienvelopeTable, iMaxOverlaps
      aOutR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableR, ienvelopeTable, iMaxOverlaps
    else
      aOutL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTable, ienvelopeTable, iMaxOverlaps
      aOutR = aOutL
    endif

    aOutL = aOutL * kAmplitudeEnvelope
    aOutR = aOutR * kAmplitudeEnvelope

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
