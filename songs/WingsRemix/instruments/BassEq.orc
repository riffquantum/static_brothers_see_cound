alwayson "BassEq"
stereoRoute "BassEq", "BassDelayInput"
instr BassEq
  aInL inleta "InL"
  aInR inleta "InR"

  aOutL = aInL
  aOutR = aInR

  ; ; High Pass at 20hz
  aOutL pareq aInL, 20, ampdb(-100), sqrt(.5), 1
  aOutR pareq aInR, 20, ampdb(-100), sqrt(.5), 1

  aOutL eqfil aOutL, 70, 30, ampdb(-10)
  aOutR eqfil aOutR, 70, 30, ampdb(-10)

  aOutL eqfil aOutL, 130, 30, ampdb(10)
  aOutR eqfil aOutR, 130, 30, ampdb(10)

  aOutL eqfil aOutL, 5000, 1000, ampdb(10)
  aOutR eqfil aOutR, 5000, 1000, ampdb(10)

  ; ; Low Pass at 15k
  aOutL pareq aOutL, 15000, ampdb(-100), sqrt(.5), 2
  aOutR pareq aOutR, 15000, ampdb(-100), sqrt(.5), 2

  ; iLimit = ampdb(-1.5)
  ; aOutL = clip(aOutL*1.5, 0, iLimit) ;* 1/iLimit
  ; aOutR = clip(aOutR*1.5, 0, iLimit) ;* 1/iLimit


  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin
