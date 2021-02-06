#define NEW_EFFECT(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.BaseDelayTime init .2
  gk$INSTRUMENT_NAME.WobbleAmount init .05
  gk$INSTRUMENT_NAME.WobbleSpeed init .1

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iDelayAttackTime = .2
    iBufferLength = 100
    iMinimumDelayTime = 50/sr

    aDelayTime = iMinimumDelayTime + (linseg(0, iDelayAttackTime, 1) * poscil(gk$INSTRUMENT_NAME.WobbleAmount, gk$INSTRUMENT_NAME.WobbleSpeed, -1, 0.5))
    aDelayTime = limit(aDelayTime, iMinimumDelayTime, iBufferLength)

    aDelayBufferOutL delayr iBufferLength
    aDelayOutL       deltapi aDelayTime
                     delayw aSignalInL

    aDelayBufferOutR delayr iBufferLength
    aDelayOutR       deltapi aDelayTime
                     delayw aSignalInR

    aSignalOutL = aDelayOutL
    aSignalOutR = aDelayOutR

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#

$NEW_EFFECT(NewEffect'Mixer'Mixer)
