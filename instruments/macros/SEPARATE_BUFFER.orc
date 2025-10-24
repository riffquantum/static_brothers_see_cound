# define SEPARATE_BUFFER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'GRAIN_SETTINGS) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)
  gi$INSTRUMENT_NAME.BufferLengthInSeconds init 1
  gi$INSTRUMENT_NAME.RecordBufferL ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.RecordBufferR ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.EnvelopeTable ftgen 2, 0, 16384, 9, 0.5, 1, 0

  ; another option - hanning window:
  ; gi$INSTRUMENT_NAME.EnvelopeTable ftgen 1, 0, 8192, 20, 2, 1

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.GrainSizeAdjustment init 1
  gk$INSTRUMENT_NAME.GrainFrequencyAdjustment init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1
  gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment init 1


  connect "$INSTRUMENT_NAME.Input", "OutDryL", "$INSTRUMENT_NAME.Buffer", "InL"
  connect "$INSTRUMENT_NAME.Input", "OutDryR", "$INSTRUMENT_NAME.Buffer", "InR"

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferR, aInR

    kStartInSeconds = 0
    kEndInSeconds = gi$INSTRUMENT_NAME.BufferLengthInSeconds

    iAttack = .1
    iDecay = .01
    iSustain = 1
    iRelease = .1
    aAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease)

    ; Grain Settings
    kPitch = 1
    kTimeStretch = 1
    kGrainSizeAdjustment = 1
    kGrainFrequencyAdjustment = 1
    kPitchAdjustment = 1
    kGrainOverlapPercentageAdjustment = 1

    $GRAIN_SETTINGS

    kPitch *= p4 == 0 ? 1 : p4
    kTimeStretch *= p5 == 0 ? 1 : p5
    kGrainSizeAdjustment *= p6 == 0 ? 1 : p6
    kGrainFrequencyAdjustment *= p7 == 0 ? 1 : p7
    kGrainOverlapPercentageAdjustment *= p8 == 0 ? 1 : p8

    kPitch *= gk$INSTRUMENT_NAME.PitchAdjustment
    kTimeStretch *= gk$INSTRUMENT_NAME.TimeStretch
    kGrainSizeAdjustment *= gk$INSTRUMENT_NAME.GrainSizeAdjustment
    kGrainFrequencyAdjustment *= gk$INSTRUMENT_NAME.GrainFrequencyAdjustment
    kGrainOverlapPercentageAdjustment *= gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment

    iMaxOverlaps = 1000
    kGrainOverlapPercentage = 50 * kGrainOverlapPercentageAdjustment
    kGrainSize = limit(.1 * kGrainSizeAdjustment, 100/sr, 100)
    kGrainFrequency = 1/(kGrainSize/( 100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
    kPointerRate = kTimeStretch * kGrainOverlapPercentage/100

    aOutL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, kStartInSeconds, kEndInSeconds, gi$INSTRUMENT_NAME.RecordBufferL, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps
		aOutR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, kStartInSeconds, kEndInSeconds, gi$INSTRUMENT_NAME.RecordBufferR, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps

    aOutL *= aAmplitudeEnvelope
    aOutR *= aAmplitudeEnvelope

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  instr $INSTRUMENT_NAME.Buffer
    aInL inleta "InL"
    aInR inleta "InR"

    recordBuffer gi$INSTRUMENT_NAME.BufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.BufferR, aInR
  endin
#
