/*
  LIVE_SYNCLOOP
  Inspired by PureMagnetik's module for their Lore console:
    https://puremagnetik.com/products/lore-experimental-sound-console

  Writes a signal to a buffer table and then applies granular synthesis to
  it with csound's syncloop opcode.

  Global Variables:
    RecordBufferL, RecordBufferR - i - Buffer tables for input
    EnvelopeTable - i - The grain envelope for playback.
    TimeStretch - k - Global modifier for time stretching applied to sample.
    GrainSizeAdjustment - k - Global modifier for grain size.
    GrainFrequencyAdjustment - k - Global modifier for the grain frequency.
    PitchAdjustment - k - Global modifier for the pitch of sample playback.
    GrainOverlapPercentageAdjustment - k - Global modifier for the grain overlap percentage.

  P Fields:
    p4 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.
    p5 - TimeStretch - Per instance modifier of corresponding global variable.
    p6 - GrainSizeAdjustment -  Per instance modifier of corresponding global variable.
    p7 - GrainFrequencyAdjustment -  Per instance modifier of corresponding global variable.
    p8 - GrainOverlapPercentageAdjustment -  Per instance modifier of corresponding global variable.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.
    $GRAIN_SETTINGS - Set of variables - Optional place to override the per instance values of certain granular
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
        #\
*/


#define LIVE_SYNCLOOP(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'GRAIN_SETTINGS) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)
  gi$INSTRUMENT_NAME.BufferLengthInSeconds init 1
  gi$INSTRUMENT_NAME.RecordBufferL ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.RecordBufferR ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.EnvelopeTable ftgen 2, 0, 16384, 9, 0.5, 1, 0
  ; another option - hanning window:
  ; gi$INSTRUMENT_NAME.EnvelopeTable ftgen 1, 0, 8192, 20, 2, 1

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.GrainSizeAdjustment init .1
  gk$INSTRUMENT_NAME.GrainFrequencyAdjustment init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1
  gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment init 1

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferR, aInR

    kStartInSeconds = 0
    kEndInSeconds = gi$INSTRUMENT_NAME.BufferLengthInSeconds

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

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

