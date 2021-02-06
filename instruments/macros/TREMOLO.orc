#define TREMOLO(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.Shapes[] fillarray sineWave(), triangleWave()
  gi$INSTRUMENT_NAME.Shape init 1
  ga$INSTRUMENT_NAME.Squareness init 0
  gkDefaultEffectChainTremoloRate init 2
  gkDefaultEffectChainTremoloDepth init 1

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    kTremoloDepth = limit(gkDefaultEffectChainTremoloDepth, 0, 1)
    aSquareness = (((ga$INSTRUMENT_NAME.Squareness/100)^(1/.3))*20) + 1
    aTremoloWave = (poscil(.5, gkDefaultEffectChainTremoloRate, gi$INSTRUMENT_NAME.Shapes[gi$INSTRUMENT_NAME.Shape])) * aSquareness
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
