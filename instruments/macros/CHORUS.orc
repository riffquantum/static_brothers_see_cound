#define CHORUS(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  gk$INSTRUMENT_NAME.Amount init 1
  gk$INSTRUMENT_NAME.DryWet init 1
  gi$INSTRUMENT_NAME.StereoRecombinationMode = 0

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    kChorusAmount = gk$INSTRUMENT_NAME.Amount * (p4 == 0 ? 1 : p4)
    kDryWet = gk$INSTRUMENT_NAME.DryWet * (p5 == 0 ? 1 : p5)

    aSignalOutLL, aSignalOutLR m_chorus aSignalInL, kChorusAmount, kDryWet
    aSignalOutRL, aSignalOutRR m_chorus aSignalInR, kChorusAmount, kDryWet

    if gi$INSTRUMENT_NAME.StereoRecombinationMode == 0 then
      aSignalOutL = aSignalOutLL
      aSignalOutR = aSignalOutRR
    else
      aSignalOutL = aSignalOutLL + aSignalOutRL
      aSignalOutR = aSignalOutLR + aSignalOutRR
    endif

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
