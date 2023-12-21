;  trying this I dunno: https://www.musicguymixing.com/eq-kick-drum/

alwayson "KickEq"
stereoRoute "KickEq", "DrumBus"
instr KickEq
  aInL inleta "InL"
  aInR inleta "InR"

  aOutL = aInL
  aOutR = aInR

  ; ; High Pass at 20hz
  aOutL pareq aInL, 20, ampdb(-100), sqrt(.5), 1
  aOutR pareq aInR, 20, ampdb(-100), sqrt(.5), 1

  aOutL eqfil aOutL, 70, 20, ampdb(10)
  aOutR eqfil aOutR, 70, 20, ampdb(10)

  ; ; 150hz Cut
  aOutL eqfil aOutL, 150, 50, ampdb(-2)
  aOutR eqfil aOutR, 150, 50, ampdb(-2)

  ; ; 400hz Cut
  aOutL eqfil aOutL, 400, 100, ampdb(-5)
  aOutR eqfil aOutR, 400, 100, ampdb(-5)

  ; ; Boost at 3.5k for click
  aOutL eqfil aOutL, 3500, 500, ampdb(10)
  aOutR eqfil aOutR, 3500, 500, ampdb(10)

  ; ; Low Pass at 15k
  aOutL pareq aOutL, 15000, ampdb(-100), sqrt(.5), 2
  aOutR pareq aOutR, 15000, ampdb(-100), sqrt(.5), 2


  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin
