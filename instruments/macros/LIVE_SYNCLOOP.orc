/*
  LIVE_SYNCLOOP
  Based on PureMagnetik's module for their Lore console:
    https://puremagnetik.com/products/lore-experimental-sound-console

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.
*/

#define LIVE_SYNCLOOP(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
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
  gk$INSTRUMENT_NAME.Pitch init 1
  gk$INSTRUMENT_NAME.GrainOverlapPercentageAdjustment init 1

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    recordBuffer gi$INSTRUMENT_NAME.RecordBufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferR, aInR

    kStartInSeconds = 0
    kEndInSeconds = gi$INSTRUMENT_NAME.BufferLengthInSeconds

    iMaxOverlaps = 1000
    kGrainOverlapPercentage = 50
    kGrainSize = limit(.1 * gk$INSTRUMENT_NAME.GrainSizeAdjustment, 100/sr, 100)
    kGrainFrequency = 1/(kGrainSize/( 100/kGrainOverlapPercentage)) * gk$INSTRUMENT_NAME.GrainFrequencyAdjustment
    kPointerRate = gk$INSTRUMENT_NAME.TimeStretch * kGrainOverlapPercentage/100
    ; kPointerRate = gk$INSTRUMENT_NAME.TimeStretch * (1/2)
    ; above is how Lore does it but here's how my syncloop instrument does it: kTimeStretch * kGrainOverlapPercentage/100

    aOutL syncloop 1, kGrainFrequency, gk$INSTRUMENT_NAME.Pitch, kGrainSize, kPointerRate, kStartInSeconds, kEndInSeconds, gi$INSTRUMENT_NAME.RecordBufferL, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps
		aOutR syncloop 1, kGrainFrequency, gk$INSTRUMENT_NAME.Pitch, kGrainSize, kPointerRate, kStartInSeconds, kEndInSeconds, gi$INSTRUMENT_NAME.RecordBufferR, gi$INSTRUMENT_NAME.EnvelopeTable, iMaxOverlaps

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

