/*
  RING_MOD
  Creates an effect instrument that applies five bands of ring
  modulation to a signal.

  Global Variables:
    Modulator1Frequency - k - The frequency of the first modulator band.
    Modulator1Amount - k - The amplitude of the first modulator band.
    Modulator2Frequency - k - The frequency of the second modulator band.
    Modulator2Amount - k - The amplitude of the second modulator band.
    Modulator3Frequency - k - The frequency of the third modulator band.
    Modulator3Amount - k - The amplitude of the third modulator band.
    Modulator4Frequency - k - The frequency of the fourth modulator band.
    Modulator4Amount - k - The amplitude of the fourth modulator band.
    Modulator5Frequency - k - The frequency of the fifth modulator band.
    Modulator5Amount - k - The amplitude of the fifth modulator band.

  P Fields:
    none

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define RING_MOD(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

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
