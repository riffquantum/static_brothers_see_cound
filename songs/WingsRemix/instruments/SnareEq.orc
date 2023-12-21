; trying this I dunno: https://www.musicguymixing.com/snare-eq/

alwayson "SnareEq"
stereoRoute "SnareEq", "SnareDelayInput"
instr SnareEq
  aInL inleta "InL"
  aInR inleta "InR"

  aOutL = aInL
  aOutR = aInR

  ; High Pass at 70hz
  aOutL pareq aInL, 70, ampdb(-100), sqrt(.5), 1
  aOutR pareq aInR, 70, ampdb(-100), sqrt(.5), 1

  ; ; 400hz Cut
  aOutL eqfil aOutL, 400, 200, ampdb(-2)
  aOutR eqfil aOutR, 400, 200, ampdb(-2)

  ; ; Boost at 5k for crispness
  aOutL eqfil aOutL, 5000, 500, ampdb(5)
  aOutR eqfil aOutR, 5000, 500, ampdb(5)

  ; ; Low Pass at 15k
  aOutL pareq aOutL, 15000, ampdb(-100), sqrt(.5), 2
  aOutR pareq aOutR, 15000, ampdb(-100), sqrt(.5), 2


  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin
