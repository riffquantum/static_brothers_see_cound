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

#define PARTIKKEL_SAMPLER(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH'LENGTH_SAMPLE_IN_BEATS'SAMPLE_START_TIME) #
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

  gi$INSTRUMENT_NAME.Sine		ftgen	0, 0, 65537, 10, 1
  gi$INSTRUMENT_NAME.Cosine	ftgen	0, 0, 8193, 9, 1, 1, 90

  instr $INSTRUMENT_NAME
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

    kGrainDuration = 10 // ((1/kGrainFrequency) * 1000) + 50
    kGrainFrequency = 2000
    aGrainFrequency = kGrainFrequency
    kDistribution = 0 // whether or not there should be random distribution
    iDistributionProfile = -1 // could be a table of values to randomized the grain distribution
    aSync = 0 // A signal that should have single sample long pulses for synchronizing
    kEnvelope2Amount = 0
    iEnvelope2 = -1
    iAttackEnvelope = -1
    iDecayEnvelope = -1
    kSustainTime = 0.5
    kAttackDecayRatio = 0.5
    kAmplitude = iAmplitude
    iGainMasks = -1 // table of gain values to be applied per grain
    kTranspositionScaling = kPitch //* (1/gi$INSTRUMENT_NAME.SampleLength)
    kTranspositionSweepShape = 0 // 0 means no sweep
    iSweepStartValues = -1
    iSweepEndValues = -1
    aFrequencyModulationPerGrain = 0
    iFrequencyModulationModifiers = -1
    kFrequencyModulationEnvelopeTable = -1
    iCosine = gi$INSTRUMENT_NAME.Cosine
    kTrainletFundamental = kGrainFrequency
    kPartialsPerTrainlet = 1
    kChroma = 1
    iChannelMasks = -1
    kRandomMask = 0
    kWaveformL1 = gi$INSTRUMENT_NAME.SampleTableL
    kWaveformR1 = gi$INSTRUMENT_NAME.SampleTableR
    kWaveformL2 = gi$INSTRUMENT_NAME.SampleTableL
    kWaveformR2 = gi$INSTRUMENT_NAME.SampleTableR
    kWaveformL3 = gi$INSTRUMENT_NAME.SampleTableL
    kWaveformR3 = gi$INSTRUMENT_NAME.SampleTableR
    kWaveformL4 = gi$INSTRUMENT_NAME.SampleTableL
    kWaveformR4 = gi$INSTRUMENT_NAME.SampleTableR
    iWaveformAmplitudesTable = -1 //ftgenonce(0,0,8,-2,0,4,1,1,0,0,1)
    ; aSamplePosition1 = poscil:a(1, 1/gi$INSTRUMENT_NAME.SampleLength * gi$INSTRUMENT_NAME.SampleLength, sawtoothWaveUpAndDown()) // phasor(1/gi$INSTRUMENT_NAME.SampleLength) * gi$INSTRUMENT_NAME.SampleLength
    aSamplePosition1 = phasor((1/gi$INSTRUMENT_NAME.SampleLength))
    aSamplePosition2 = aSamplePosition1 * .5
    aSamplePosition3 = aSamplePosition1
    aSamplePosition4 = aSamplePosition1
    kWaveKey1 = 1
    kWaveKey2 = 1
    kWaveKey3 = 1
    kWaveKey4 = 1
    iMaxGrains = 100

    print i(iPitch)
    print i(kTranspositionScaling)


    aSignalL partikkel \
      aGrainFrequency, \
      kDistribution, \
      iDistributionProfile, \
      aSync, \
      kEnvelope2Amount, \
      iEnvelope2, \
      iAttackEnvelope, \
      iDecayEnvelope, \
      kSustainTime, \
      kAttackDecayRatio, \
      kGrainDuration, \
      kAmplitude, \
      iGainMasks, \
      kTranspositionScaling, \
      kTranspositionSweepShape, \
      iSweepStartValues, \
      iSweepEndValues, \
      aFrequencyModulationPerGrain, \
      iFrequencyModulationModifiers, \
      kFrequencyModulationEnvelopeTable, \
      iCosine, \
      kTrainletFundamental, \
      kPartialsPerTrainlet, \
      kChroma, \
      iChannelMasks, \
      kRandomMask, \
      kWaveformL1, kWaveformL2, kWaveformL3, kWaveformL4, \
      iWaveformAmplitudesTable, \
      aSamplePosition1, aSamplePosition2, aSamplePosition3, aSamplePosition4, \
      kWaveKey1, kWaveKey2, kWaveKey3, kWaveKey4, \
      iMaxGrains

    aSignalL = aSignalL * kAmplitudeEnvelope

    if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
      aSignalR partikkel \
      aGrainFrequency, \
      kDistribution, \
      iDistributionProfile, \
      aSync, \
      kEnvelope2Amount, \
      iEnvelope2, \
      iAttackEnvelope, \
      iDecayEnvelope, \
      kSustainTime, \
      kAttackDecayRatio, \
      kGrainDuration, \
      kAmplitude, \
      iGainMasks, \
      kTranspositionScaling, \
      kTranspositionSweepShape, \
      iSweepStartValues, \
      iSweepEndValues, \
      aFrequencyModulationPerGrain, \
      iFrequencyModulationModifiers, \
      kFrequencyModulationEnvelopeTable, \
      iCosine, \
      kTrainletFundamental, \
      kPartialsPerTrainlet, \
      kChroma, \
      iChannelMasks, \
      kRandomMask, \
      kWaveformR1, kWaveformR2, kWaveformR3, kWaveformR4, \
      iWaveformAmplitudesTable, \
      aSamplePosition1, aSamplePosition2, aSamplePosition3, aSamplePosition4, \
      kWaveKey1, kWaveKey2, kWaveKey3, kWaveKey4, \
      iMaxGrains

      aSignalR = aSignalR * kAmplitudeEnvelope
    else
      aSignalR = aSignalL
    endif

    outleta "OutL", aSignalL
    outleta "OutR", aSignalR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
