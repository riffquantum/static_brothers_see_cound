#define TAPE_WOBBLE(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  ga$INSTRUMENT_NAME.Amount init .03
  ga$INSTRUMENT_NAME.Speed init .1
  gi$INSTRUMENT_NAME.WobbleWave init sineWave()
  gi$INSTRUMENT_NAME.BufferLength init 1

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iDelayAttackTime = .2
    iBufferLength = gi$INSTRUMENT_NAME.BufferLength * 1000
    iMinimumDelayTime = 50/sr

    aAmount = ga$INSTRUMENT_NAME.Amount / 2

    aAttackTime = linseg(0, iDelayAttackTime, 1)
    aOscillator = poscil(aAmount, ga$INSTRUMENT_NAME.Speed, gi$INSTRUMENT_NAME.WobbleWave, .75) + (aAmount)

    aDelayTime = (aAttackTime * aOscillator)
    aDelayTime = limit(aDelayTime, iMinimumDelayTime, (iBufferLength/1000) - iMinimumDelayTime)

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

