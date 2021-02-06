#define TWISTED_KICK(INSTRUMENT_NAME'ROUTE'SAMPLE_PATH) #
  instrumentRoute "$INSTRUMENT_NAME.", "$ROUTE"

  gS$INSTRUMENT_NAME.SampleFilePath = "$SAMPLE_PATH" ;"localSamples/CB_Kick.wav"
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
    iAmplitude = flexibleAmplitudeInput(p4)
    iAttack = .01
    iDecay = .01
    iSustain = 1
    iRelease = .5
    kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

    iPitch = flexiblePitchInput(p5)
    kPitch = iPitch / 261.6

    kTimeStretch = p6 == 0 ? 1 : p6
    kGrainSizeAdjustment = p8 == 0 ? 1 : p8
    kGrainFrequencyAdjustment = p9 == 0 ? 1 : p9
    kPitchAdjustment = p10 == 0 ? 1 : p10
    kGrainOverlapPercentageAdjustment = p11 == 0 ? 1 : p11

    kPitchBend = 0
    midipitchbend kPitchBend, 0, 15

    ;Grain Parameter Adjustments
    kTimeStretch *= .01 + poscil(.04, 1.87) + poscil(.2, .3)
    kGrainSizeAdjustment *= .3
    kGrainFrequencyAdjustment *= 3 + poscil(.04, .87) + poscil(.2, .3)
    kPitchAdjustment *= 1 + poscil(.1, .1) * (1 + kPitchBend)
    kGrainOverlapPercentageAdjustment *= 2 + poscil(.04, .87) + poscil(.2, .3)

    kTimeStretch *= gk$INSTRUMENT_NAME.TimeStretch
    kGrainSizeAdjustment *= gk$INSTRUMENT_NAME.GrainSizeAdjustment
    kGrainFrequencyAdjustment *= gk$INSTRUMENT_NAME.GrainFrequencyAdjustment
    kPitchAdjustment *= gk$INSTRUMENT_NAME.PitchAdjustment
    kGrainOverlapPercentageAdjustment *= gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment


    kPitch *= kPitchAdjustment
    kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    kGrainSize = .1 * kGrainSizeAdjustment
    kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
    kPointerRate = kTimeStretch * kGrainOverlapPercentage/100
    iMaxOverlaps = 1000

    if gi$INSTRUMENT_NAME.NumberOfChannels == 2 then
      aSignalOutL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableL, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps
      aSignalOutR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTableR, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps

      aSignalOutL = aSignalOutL * kAmplitudeEnvelope
      aSignalOutR = aSignalOutR * kAmplitudeEnvelope
    else
      aSignalOutL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, gi$INSTRUMENT_NAME.StartTime, gi$INSTRUMENT_NAME.EndTime, gi$INSTRUMENT_NAME.SampleTable, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps
      aSignalOutL *= kAmplitudeEnvelope

      aSignalOutR = aSignalOutL
    endif

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
