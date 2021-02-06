#define TAPE_WOBBLE(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.BaseDelayTime init .1
  ga$INSTRUMENT_NAME.Amount init .03
  ga$INSTRUMENT_NAME.Speed init .1
  gi$INSTRUMENT_NAME.WobbleWave init triangleWave()

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iDelayAttackTime = .2
    iBufferLength = 100
    iMinimumDelayTime = 50/sr

    aDelayTime = iMinimumDelayTime + (linseg(0, iDelayAttackTime, 1) * poscil(ga$INSTRUMENT_NAME.Amount, ga$INSTRUMENT_NAME.Speed, gi$INSTRUMENT_NAME.WobbleWave, 0.5))
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

