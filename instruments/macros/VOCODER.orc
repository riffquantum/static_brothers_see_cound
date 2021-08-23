#define VOCODER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.Q init 4
  gk$INSTRUMENT_NAME.Shift init 750
  gk$INSTRUMENT_NAME.IntNoise init 1
  gk$INSTRUMENT_NAME.Mode init 0

  connect "$INSTRUMENT_NAME.Carrier", "OutL", "$INSTRUMENT_NAME", "CarrierInL"
  connect "$INSTRUMENT_NAME.Carrier", "OutR", "$INSTRUMENT_NAME", "CarrierInR"
  alwayson "$INSTRUMENT_NAME.Carrier"

  instr $INSTRUMENT_NAME.Carrier
    aSignalL inleta "InL"
    aSignalR inleta "InR"

    outleta "OutL", aSignalL
    outleta "OutR", aSignalR
  endin

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
