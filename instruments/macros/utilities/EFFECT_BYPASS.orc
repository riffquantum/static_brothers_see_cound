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
