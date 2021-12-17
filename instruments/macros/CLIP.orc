/*
  CLIP
  Creates an effect instrument that applies a simple clipping to signal with cSound's
  clip opcode.

  Global Variables:
    PreGain - k - Gain to be applied to the signal before clipping.
    Limit - i - Limiting value for the clipping.
    Method - i - Selects the clipping method. The methods are: (0) Bram de Jong method,
      (1) sine clipping, (2) tanh clipping.
    ClipStart - i - Method 0 only. Indicates the point at which clipping starts, in the range 0 - 1.

  P Fields:
    p4 - PreGain - Modifies global setting per instance.
    p5 - Limit - Modifies global setting per instance.
    p6 - Method - Overrides global method setting per instance. 0 defers
      to global setting. -1 selects Bram de Jong mode.
    p7 - ClipStart - Modifies global setting per instance.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define CLIP(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.PreGain init 1
  gi$INSTRUMENT_NAME.Limit init 2
  gi$INSTRUMENT_NAME.Method init 0
  gi$INSTRUMENT_NAME.ClipStart init 0.5

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    kPreGain = (p4 == 0 ? 1 : p4) * gk$INSTRUMENT_NAME.PreGain
    iLimit = (p5 == 0 ? 1 : p5) * gi$INSTRUMENT_NAME.Limit
    iMethod = (p6 == 0 ? gi$INSTRUMENT_NAME.Method : (p6 == -1 ? 0 : p6))
    iClipStart = (p7 == 0 ? 1 : p7) * gi$INSTRUMENT_NAME.ClipStart

    aSignalOutL clip aSignalInL * kPreGain, iMethod, iLimit, gi$INSTRUMENT_NAME.ClipStart
    aSignalOutR clip aSignalInR * kPreGain, iMethod, iLimit, gi$INSTRUMENT_NAME.ClipStart

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
