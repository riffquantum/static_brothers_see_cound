/*
  EFFECT_BYPASS
  Creates a routing instrument and global Wet/Dry variables for use with effect instruments.
  The instruments takes an input signal and outputs wet and dry signals separately. The
  bypass switch opcode detects if the corresponding effect is active and delivers a fully
  dry signal or both modified signals appropriately.

  Global Variables:
    WetAmount - k - The volume of the affected signal.
    DryAmount - k - The volume of the unaffected signal when the
      corresponding effect is active.

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the corresponding effect
      instrument. The routing instrument will be named
      $INSTRUMENT_NAME.Input.
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define EFFECT_BYPASS(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'DRY_AMOUNT'WET_AMOUNT) #
  alwayson "$INSTRUMENT_NAME.Input"

  bypassRoute "$INSTRUMENT_NAME", "$DRY_ROUTE", "$WET_ROUTE"

  gk$INSTRUMENT_NAME.WetAmount init $WET_AMOUNT
  gk$INSTRUMENT_NAME.DryAmount init $DRY_AMOUNT

  instr $INSTRUMENT_NAME.Input
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutWetL, aSignalOutWetR, aSignalOutDryL, aSignalOutDryR bypassSwitch aSignalInL, aSignalInR, gk$INSTRUMENT_NAME.DryAmount, gk$INSTRUMENT_NAME.WetAmount, "$INSTRUMENT_NAME."

    outleta "OutWetL", aSignalOutWetL
    outleta "OutWetR", aSignalOutWetR

    outleta "OutDryL", aSignalOutDryL
    outleta "OutDryR", aSignalOutDryR
  endin
#
