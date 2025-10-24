/*
  LIVE_SNDWARP
  Writes a signal to a buffer table and then applies granular synthesis to
  it with csound's syncloop opcode.

  Global Variables:
    RecordBufferL, RecordBufferR - i - Buffer tables for input
    EnvelopeTable - i - The grain envelope for playback.
    TimeStretch - k - Global modifier for time stretching applied to sample.
    PitchAdjustment - k - Global modifier for the pitch of sample playback.

  P Fields:
    p4 - Pitch - Number - Can be a midi input, a pitch class value, or a frequency in Hz.
    p5 - TimeStretch - Per instance modifier of corresponding global variable.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated.
    $WET_ROUTE - String - Name of the route for the unprocessed signal.
    $DRY_ROUTE - String - Name of the route for the processed signal.
*/


#define LIVE_SNDWARP(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.BufferLengthInSeconds init 1
  gi$INSTRUMENT_NAME.RecordBufferL ftgen 0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.RecordBufferR ftgen 0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.EnvelopeTable ftgen 2, 0, 16384, 9, 0.5, 1, 0

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1

  instr $INSTRUMENT_NAME
    ; Input signals
    aInL inleta "InL"
    aInR inleta "InR"

    ; Record input to buffers
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferR, aInR

    ; Parameter handling
    kPitch = (p4 != 0 ? p4 : 1) * gk$INSTRUMENT_NAME.PitchAdjustment
    kTimeStretch = (p5 != 0 ? p5 : 1) * gk$INSTRUMENT_NAME.TimeStretch
    iSampleStart = p6

    ; Precompute constants
    iWindowSize = sr * gi$INSTRUMENT_NAME.BufferLengthInSeconds * 0.25
    iRandom = iWindowSize * 0.2
    iOverlaps = 10
    iTimeMode = 1
    kGain = 1

    ; Optimized pointer calculation
    aPointer phasor 1 / (gi$INSTRUMENT_NAME.BufferLengthInSeconds * kTimeStretch)
    aPointer = aPointer % gi$INSTRUMENT_NAME.BufferLengthInSeconds

    ; Granular synthesis
    aOutL, aBalancerL sndwarp kGain, aPointer, kPitch, gi$INSTRUMENT_NAME.RecordBufferL, iSampleStart, iWindowSize, iRandom, iOverlaps, gi$INSTRUMENT_NAME.EnvelopeTable, iTimeMode
    aOutR, aBalancerR sndwarp kGain, aPointer, kPitch, gi$INSTRUMENT_NAME.RecordBufferR, iSampleStart, iWindowSize, iRandom, iOverlaps, gi$INSTRUMENT_NAME.EnvelopeTable, iTimeMode

    ; Balance and output
    aOutL balance aOutL, aBalancerL
    aOutR balance aOutR, aBalancerR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
