#define NEW_EFFECT(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.BaseDelayTime init .2
  gk$INSTRUMENT_NAME.WobbleAmount init .05
  gk$INSTRUMENT_NAME.WobbleSpeed init .1

  gk$INSTRUMENT_NAME.Q init 4
  gk$INSTRUMENT_NAME.Shift init 750
  gk$INSTRUMENT_NAME.IntNoise init 0
  gk$INSTRUMENT_NAME.Mode init 0

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    aOutL = aInL
    aOutR = aInR

    outleta "OutL", aOutL
    outleta "OutR", aOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

$NEW_EFFECT(NewEffect'Mixer'Mixer)
