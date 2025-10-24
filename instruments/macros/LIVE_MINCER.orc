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


#define LIVE_MINCER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)
  gi$INSTRUMENT_NAME.BufferLengthInSeconds init 1
  gi$INSTRUMENT_NAME.RecordBufferL ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.RecordBufferR ftgen	0, 0, (gi$INSTRUMENT_NAME.BufferLengthInSeconds * sr), 2, 0
  gi$INSTRUMENT_NAME.EnvelopeTable ftgen 2, 0, 16384, 9, 0.5, 1, 0
  ; another option - hanning window:
  ; gi$INSTRUMENT_NAME.EnvelopeTable ftgen 1, 0, 8192, 20, 2, 1

  gk$INSTRUMENT_NAME.TimeStretch init 1
  gk$INSTRUMENT_NAME.PitchAdjustment init 1
  gk$INSTRUMENT_NAME.DelayTime init 0.1

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    recordBuffer gi$INSTRUMENT_NAME.RecordBufferL, aInL
    recordBuffer gi$INSTRUMENT_NAME.RecordBufferR, aInR


    kPitch = p4 == 0 ? 1 : p4
    kTimeStretch = p5 == 0 ? 1 : p5

    kPitch *= gk$INSTRUMENT_NAME.PitchAdjustment
    kTimeStretch *= gk$INSTRUMENT_NAME.TimeStretch

    iFFTSize = 2048
    iDecimation = 4
    kPhaseLocking = 0

    aPointer = phasor(1/gi$INSTRUMENT_NAME.BufferLengthInSeconds) * gi$INSTRUMENT_NAME.BufferLengthInSeconds - gk$INSTRUMENT_NAME.DelayTime
    aPointer = aPointer * 1/kTimeStretch % gi$INSTRUMENT_NAME.BufferLengthInSeconds

    aOutL mincer aPointer, 1, kPitch, gi$INSTRUMENT_NAME.RecordBufferL, kPhaseLocking, iFFTSize, iDecimation
    aOutR mincer aPointer, 1, kPitch, gi$INSTRUMENT_NAME.RecordBufferR, kPhaseLocking, iFFTSize, iDecimation

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

