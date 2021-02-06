#define CLIP(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.PreGain init 1
  gi$INSTRUMENT_NAME.Limit init 2
  gi$INSTRUMENT_NAME.Method init 0
  gi$INSTRUMENT_NAME.ClipStart init 0.5

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    aSignalOutL clip aSignalInL * gk$INSTRUMENT_NAME.PreGain, gi$INSTRUMENT_NAME.Method, gi$INSTRUMENT_NAME.Limit, gi$INSTRUMENT_NAME.ClipStart
    aSignalOutR clip aSignalInR * gk$INSTRUMENT_NAME.PreGain, gi$INSTRUMENT_NAME.Method, gi$INSTRUMENT_NAME.Limit, gi$INSTRUMENT_NAME.ClipStart

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
