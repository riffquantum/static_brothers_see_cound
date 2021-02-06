#define RING_MOD(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.Modulator1Frequency init 2000
  gk$INSTRUMENT_NAME.Modulator1Amount init 1
  gk$INSTRUMENT_NAME.Modulator2Frequency init 1200
  gk$INSTRUMENT_NAME.Modulator2Amount init 0
  gk$INSTRUMENT_NAME.Modulator3Frequency init 800
  gk$INSTRUMENT_NAME.Modulator3Amount init 0
  gk$INSTRUMENT_NAME.Modulator4Frequency init 440
  gk$INSTRUMENT_NAME.Modulator4Amount init 0
  gk$INSTRUMENT_NAME.Modulator5Frequency init 263
  gk$INSTRUMENT_NAME.Modulator5Amount init 0

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    aModulator = 0
    aModulator += oscil(gk$INSTRUMENT_NAME.Modulator1Amount, gk$INSTRUMENT_NAME.Modulator1Frequency)
    aModulator += oscil(gk$INSTRUMENT_NAME.Modulator2Amount, gk$INSTRUMENT_NAME.Modulator2Frequency)
    aModulator += oscil(gk$INSTRUMENT_NAME.Modulator3Amount, gk$INSTRUMENT_NAME.Modulator3Frequency)
    aModulator += oscil(gk$INSTRUMENT_NAME.Modulator4Amount, gk$INSTRUMENT_NAME.Modulator4Frequency)
    aModulator += oscil(gk$INSTRUMENT_NAME.Modulator5Amount, gk$INSTRUMENT_NAME.Modulator5Frequency)

    aSignalOutL *= aModulator
    aSignalOutR *= aModulator

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
