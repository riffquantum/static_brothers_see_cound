/*
  TREMOLO
  Creates an effect instrument that applies an amplitude tremolo
  to a signal.

  Global Variables:
    Shapes - i - An array of waveforms for use as the modulator
      wave.
    Shape - i - Index of the waveform in the Shapes array.
    Squareness - a - Modifies the chosen wave to be more or less square.
    TremoloRate - k - Frequency of the modulating wave.
    TremoloDepth - k - Amplitude of the modulating wave.

  P Fields:
    none

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define TREMOLO(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.Shapes[] fillarray sineWave(), triangleWave()
  gi$INSTRUMENT_NAME.Shape init 1
  ga$INSTRUMENT_NAME.Squareness init 0
  gk$INSTRUMENT_NAME.TremoloRate init 2
  gk$INSTRUMENT_NAME.TremoloDepth init 1

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    kTremoloDepth = limit(gk$INSTRUMENT_NAME.TremoloDepth, 0, 1)
    aSquareness = (((ga$INSTRUMENT_NAME.Squareness/100)^(1/.3))*20) + 1
    aTremoloWave = (poscil(.5, gk$INSTRUMENT_NAME.TremoloRate, gi$INSTRUMENT_NAME.Shapes[gi$INSTRUMENT_NAME.Shape])) * aSquareness
    aTremoloWave = limit(aTremoloWave, -0.5, 0.5) + 0.5
    aTremoloWave = 1 - (aTremoloWave * kTremoloDepth)

    ; optional monitor
    ; printk .01, k(a$INSTRUMENT_NAME.)

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    aSignalOutL *= aTremoloWave
    aSignalOutR *= aTremoloWave

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
