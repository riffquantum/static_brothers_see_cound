/* fruityGranulizer
    An Attempt to copy the fruity granulizer VST.
*/

#define FRUITY_GRANULIZER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'GRAIN_AND_ADSR_SETTINGS'LENGTH_SAMPLE_IN_BEATS'SAMPLE_START_TIME) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gk$INSTRUMENT_NAME.Attack init 1
  gk$INSTRUMENT_NAME.Hold init 10 ;12.8
  gk$INSTRUMENT_NAME.GrainSpacing init 54 ;54 - default setting for normal playback
  gk$INSTRUMENT_NAME.WaveSpacing init 84 ;84 - default setting for normal playback
  gk$INSTRUMENT_NAME.FxDepth init 0 ;0
  gk$INSTRUMENT_NAME.FxSpeed init .8
  gk$INSTRUMENT_NAME.Randomize init 0
  gi$INSTRUMENT_NAME.StartTime init $SAMPLE_START_TIME

  ; $GRAIN_AND_ADSR_SETTINGS

  gS$INSTRUMENT_NAME.SampleFilePath = "$SAMPLE_PATH"
  gi$INSTRUMENT_NAME.NumberOfChannels filenchnls gS$INSTRUMENT_NAME.SampleFilePath
  gi$INSTRUMENT_NAME.SampleLength filelen gS$INSTRUMENT_NAME.SampleFilePath

  if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
    gi$INSTRUMENT_NAME.SampleTableL ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 1
    gi$INSTRUMENT_NAME.SampleTableR ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 2
  else
    gi$INSTRUMENT_NAME.SampleTable ftgenonce 0, 0, 0, 1, gS$INSTRUMENT_NAME.SampleFilePath, gi$INSTRUMENT_NAME.StartTime, 0, 0
  endif


  instr $INSTRUMENT_NAME
    iAmplitude flexibleAmplitudeInput p4
    kPitch = flexiblePitchInput(p5)

    /* Syncloop Params */
    ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
    iMaxOverlaps = 5
    kGrainSizeInMiliseconds = 40
    kGrainSize = kGrainSizeInMiliseconds/1000
    kWaveSpacingOscillator oscil (gk$INSTRUMENT_NAME.FxDepth)/100*3, gk$INSTRUMENT_NAME.FxSpeed
    kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((gk$INSTRUMENT_NAME.GrainSpacing*1.852/100)^2)

    /* Wavespacing Factor */
    kWaveSpacing = gk$INSTRUMENT_NAME.WaveSpacing ;- 50
    if kWaveSpacing == 0 then
      kWaveSpacing = 1
    endif

    kWaveSpacing = (kWaveSpacing / 34)^3 ;+ kWaveSpacingOscillator
    kPointerRate = (1/iMaxOverlaps) * kWaveSpacing

    if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
        aOutL syncloop iAmplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.SampleLength, gi$INSTRUMENT_NAME.SampleTableL, ienvelopeTable, iMaxOverlaps
        aOutR syncloop iAmplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.SampleLength, gi$INSTRUMENT_NAME.SampleTableR, ienvelopeTable, iMaxOverlaps
    else
        aOutL syncloop iAmplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.SampleLength, gi$INSTRUMENT_NAME.SampleTable, ienvelopeTable, iMaxOverlaps
        aOutR = aOutL
    endif

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
