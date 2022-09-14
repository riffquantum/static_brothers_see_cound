instrumentRoute "ExpectedBreak1", "Mixer"

gkExpectedBreak1Hold init 100 ;12.8
gkExpectedBreak1GrainSpacing init 54 ;54 - default setting for normal playback
gkExpectedBreak1WaveSpacing init 84 ;84 - default setting for normal playback
gkExpectedBreak1FxDepth init 0 ;0
gkExpectedBreak1FxSpeed init .8
gkExpectedBreak1Randomize init 0

/* Sound File Data */
gSExpectedBreak1sampleFilePath = "localSamples/itsExpectedBreak.wav"
giExpectedBreak1FileNumChannels filenchnls gSExpectedBreak1sampleFilePath
giExpectedBreak1FileLength filelen gSExpectedBreak1sampleFilePath
giExpectedBreak1FileSampleRate filesr gSExpectedBreak1sampleFilePath
giExpectedBreak1StartTime = 0 ;giExpectedBreak1FileLength * 0.05
giExpectedBreak1EndTime = giExpectedBreak1FileLength

if giExpectedBreak1FileNumChannels == 2 then
  giExpectedBreak1SampleTableL ftgenonce 0, 0, 0, 1, gSExpectedBreak1sampleFilePath, giExpectedBreak1StartTime, 0, 1
  giExpectedBreak1SampleTableR ftgenonce 0, 0, 0, 1, gSExpectedBreak1sampleFilePath, giExpectedBreak1StartTime, 0, 2
else
  giExpectedBreak1SampleTable ftgenonce 0, 0, 0, 1, gSExpectedBreak1sampleFilePath, giExpectedBreak1StartTime, 0, 0
endif

instr ExpectedBreak1HoldKnob
  ;Length each grain is held before moving onto the next.
  gkExpectedBreak1Hold linseg p4, p3, p5
endin

instr ExpectedBreak1GrainSpacingKnob
  ;Grain spacing in playback. Turn to right for greater spacing between played grains (slower playback). Turn left for smaller spacing (faster playback).
  gkExpectedBreak1GrainSpacing linseg p4, p3, p5
endin

instr ExpectedBreak1WaveSpacingKnob
  ;This basically controls the number of grains generated from the wave sample. This value ranges from -300% to 300%. For normal playback, set both Grain Spacing and Wave Spacing to 100%. Small values mean more grains are used for the wave (smaller wave spacing). Using negative values results in reversed playback of the grains. NOTES: Grain playback order is reversed, not the sound contained in each grain.
  gkExpectedBreak1WaveSpacing linseg p4, p3, p5
endin

instr ExpectedBreak1FxDepthKnob
  ;Amplitude of the LFO applied to the wave spacing value. Turn to right to increase the amplitude. To turn the LFO off, turn the knob maximum to left.
  gkExpectedBreak1FxDepth linseg p4, p3, p5
endin

instr ExpectedBreak1FxSpeedKnob
  ;Speed of the LFO applied to the wave spacing value. Turning to right makes the LFO faster, turning left, slower.
  gkExpectedBreak1FxSpeed linseg p4, p3, p5
endin

instr ExpectedBreak1
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5) / 261.6 ; Ratio of frequency to Middle C
  kAmplitudeEnvelope = madsr(.005, .01, 1, .01, 0, (giExpectedBreak1FileLength)) * iAmplitude

  /* MIDI Pitchbend */
  kPitchBend = 0
  midipitchbend kPitchBend
  kPitch = iPitch + kPitchBend

  kExpectedBreak1HoldAdjustment = 1
  kExpectedBreak1GrainSpacingAdjustment = 1
  kExpectedBreak1WaveSpacingAdjustment = 1
  kExpectedBreak1FxDepthAdjustment = 0
  kExpectedBreak1FxSpeedAdjustment = 1

  kExpectedBreak1Hold = gkExpectedBreak1Hold * (kExpectedBreak1HoldAdjustment/65)^3
  kExpectedBreak1GrainSpacing = gkExpectedBreak1GrainSpacing * (kExpectedBreak1GrainSpacingAdjustment/65)^2
  kExpectedBreak1WaveSpacing = gkExpectedBreak1WaveSpacing * (kExpectedBreak1WaveSpacingAdjustment/65)^2
  kExpectedBreak1FxDepth = gkExpectedBreak1FxDepth * (kExpectedBreak1FxDepthAdjustment/65)^2
  kExpectedBreak1FxSpeed = gkExpectedBreak1FxSpeed * (kExpectedBreak1FxSpeedAdjustment/65)^2

  /* Syncloop Params */
  ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
  iMaxOverlaps = 5
  kGrainSizeInMiliseconds = kExpectedBreak1Hold
  kGrainSize = kGrainSizeInMiliseconds
  kWaveSpacingOscillator oscil (kExpectedBreak1FxDepth)/100*3, kExpectedBreak1FxSpeed
  kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((kExpectedBreak1GrainSpacing*1.852/100)^2)


  /* Wavespacing Factor */
  kExpectedBreak1WaveSpacing = kExpectedBreak1WaveSpacing - 50
  if kExpectedBreak1WaveSpacing == 0 then
    kExpectedBreak1WaveSpacing = 1
  endif

  kExpectedBreak1WaveSpacing = (kExpectedBreak1WaveSpacing / 34)^3 + kWaveSpacingOscillator
  kPointerRate = (1/iMaxOverlaps) * kExpectedBreak1WaveSpacing

  /* Synthesis and Output */
  if giExpectedBreak1FileNumChannels == 2 then
      aExpectedBreak1L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giExpectedBreak1EndTime, giExpectedBreak1SampleTableL, ienvelopeTable, iMaxOverlaps
      aExpectedBreak1R syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giExpectedBreak1EndTime, giExpectedBreak1SampleTableR, ienvelopeTable, iMaxOverlaps

      aExpectedBreak1L = aExpectedBreak1L * kAmplitudeEnvelope
      aExpectedBreak1R = aExpectedBreak1R * kAmplitudeEnvelope
  else
      aExpectedBreak1L syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giExpectedBreak1EndTime, giExpectedBreak1SampleTable, ienvelopeTable, iMaxOverlaps
      aExpectedBreak1L *= kAmplitudeEnvelope
      aExpectedBreak1R = aExpectedBreak1L
  endif

  outleta "OutL", aExpectedBreak1L
  outleta "OutR", aExpectedBreak1R
endin

$MIXER_CHANNEL(ExpectedBreak1)
