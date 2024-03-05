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
    $PROCESS_DURING_RELEASE - Boolean - If 0 then no signal will be sent
      to the effect when the effect is off. This effects the sound of release
      phases. For example, a distortion's release should still process the effect
      whereas a delay's should just ring out without processing new input.
*/

#define EFFECT_BYPASS_DEP(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'DRY_AMOUNT'WET_AMOUNT) #
  alwayson "$INSTRUMENT_NAME.Input"

  bypassRoute "$INSTRUMENT_NAME", "$DRY_ROUTE", "$WET_ROUTE"

  gk$INSTRUMENT_NAME.WetAmount init $WET_AMOUNT
  gk$INSTRUMENT_NAME.DryAmount init $DRY_AMOUNT

  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    aOutWetL, aOutWetR, aOutDryL, aOutDryR bypassSwitch aInL, aInR, gk$INSTRUMENT_NAME.DryAmount, gk$INSTRUMENT_NAME.WetAmount, "$INSTRUMENT_NAME."


    outleta "OutWetL", aOutWetL
    outleta "OutWetR", aOutWetR

    outleta "OutDryL", aOutDryL
    outleta "OutDryR", aOutDryR
  endin
#

; The old bypass route applied the wet level attenuation BEFORE the effect processed the signal.
; This does so AFTERWARDS
#define EFFECT_BYPASS(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE'DRY_AMOUNT'WET_AMOUNT'PROCESS_DURING_RELEASE) #
  alwayson "$INSTRUMENT_NAME.Input"

  ; Patch Signal to Effect
  connect "$INSTRUMENT_NAME.Input", "OutToEffectL", "$INSTRUMENT_NAME", "InL"
  connect "$INSTRUMENT_NAME.Input", "OutToEffectR", "$INSTRUMENT_NAME", "InR"

  ; Patch Effected Signal back to switch
  connect "$INSTRUMENT_NAME", "OutL", "$INSTRUMENT_NAME.Input", "InFromEffectL"
  connect "$INSTRUMENT_NAME", "OutR", "$INSTRUMENT_NAME.Input", "InFromEffectR"

  ; Send Dry signal to dry route
  connect "$INSTRUMENT_NAME.Input", "OutDryL", "$DRY_ROUTE", "InL"
  connect "$INSTRUMENT_NAME.Input", "OutDryR", "$DRY_ROUTE", "InR"

  ; Send Wet Signal to effect mixer channel
  connect "$INSTRUMENT_NAME.Input", "OutWetL", "$INSTRUMENT_NAME.MixerChannel", "InL"
  connect "$INSTRUMENT_NAME.Input", "OutWetR", "$INSTRUMENT_NAME.MixerChannel", "InR"

  ; Send mixer channel signal to wet route
  connect "$INSTRUMENT_NAME.MixerChannel", "OutL", "$WET_ROUTE", "InL"
  connect "$INSTRUMENT_NAME.MixerChannel", "OutR", "$WET_ROUTE", "InR"

  gk$INSTRUMENT_NAME.WetAmount init $WET_AMOUNT
  gk$INSTRUMENT_NAME.DryAmount init $DRY_AMOUNT

  instr $INSTRUMENT_NAME.Input
    aInL inleta "InL"
    aInR inleta "InR"

    aOutWetL = inleta("InFromEffectL") * gk$INSTRUMENT_NAME.WetAmount
    aOutWetR = inleta("InFromEffectR") * gk$INSTRUMENT_NAME.WetAmount

    aOutToEffectL = aInL
    aOutToEffectR = aInR

    kActiveEffectsInstruments active "$INSTRUMENT_NAME.", 0, 1
    kEffectsInstrumentIsActive = kActiveEffectsInstruments > 0 ? 1 : 0

    if kActiveEffectsInstruments > 0 then
      aOutDryL = aInL * gk$INSTRUMENT_NAME.DryAmount
      aOutDryR = aInR * gk$INSTRUMENT_NAME.DryAmount
    else
      aOutDryR = aInR
      aOutDryL = aInL

      if $PROCESS_DURING_RELEASE == 0 then
        aOutToEffectL *= 0
        aOutToEffectR *= 0
      endif
    endif

    outleta "OutToEffectL", aOutToEffectL
    outleta "OutToEffectR", aOutToEffectR

    outleta "OutWetL", aOutWetL
    outleta "OutWetR", aOutWetR

    outleta "OutDryL", aOutDryL
    outleta "OutDryR", aOutDryR
  endin
#
