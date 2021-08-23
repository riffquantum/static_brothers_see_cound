#define NEW_EFFECT(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.BaseDelayTime init .2
  gk$INSTRUMENT_NAME.WobbleAmount init .05
  gk$INSTRUMENT_NAME.WobbleSpeed init .1

  gk$INSTRUMENT_NAME.Q init 4
  gk$INSTRUMENT_NAME.Shift init 750
  gk$INSTRUMENT_NAME.IntNoise init 0
  gk$INSTRUMENT_NAME.Mode init 0

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aCarrierL inleta "CarrierInL"
    aCarrierR inleta "CarrierInR"

    kQ = gk$INSTRUMENT_NAME.Q
    kShift = gk$INSTRUMENT_NAME.Shift
    kIntNoise = gk$INSTRUMENT_NAME.IntNoise
    kMode = gk$INSTRUMENT_NAME.Mode

    aSignalOutL m_vc110 aCarrierL, aSignalInL, kQ, kShift, kIntNoise, kMode
    aSignalOutR m_vc110 aCarrierR, aSignalInR, kQ, kShift, kIntNoise, kMode

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

$NEW_EFFECT(NewEffect'Mixer'Mixer)
