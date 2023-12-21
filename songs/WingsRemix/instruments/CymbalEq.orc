;  trying this I dunno: https://www.musicguymixing.com/cymbal-eq/

alwayson "CymbalEq"
stereoRoute "CymbalEq", "DrumBus"
instr CymbalEq
  aInL inleta "InL"
  aInR inleta "InR"

  aOutL = aInL
  aOutR = aInR

  ; ; High Pass at 200hz
  aOutL pareq aInL, 200, ampdb(-100), sqrt(.5), 1
  aOutR pareq aInR, 200, ampdb(-100), sqrt(.5), 1

  aOutL eqfil aOutL, 350, 50, ampdb(5)
  aOutR eqfil aOutR, 350, 50, ampdb(5)


  ; ; 500hz Cut
  aOutL eqfil aOutL, 500, 100, ampdb(-2)
  aOutR eqfil aOutR, 500, 100, ampdb(-2)

  ; ; 4k Cut
  aOutL eqfil aOutL, 4000, 500, ampdb(-2)
  aOutR eqfil aOutR, 4000, 500, ampdb(-2)

  ; ; Boost at 10k
  aOutL eqfil aOutL, 10000, 500, ampdb(5)
  aOutR eqfil aOutR, 10000, 500, ampdb(5)



  ; ; ; 500hz Cut
  ; aOutL eqfil aOutL, 500, 100, ampdb(-8)
  ; aOutR eqfil aOutR, 500, 100, ampdb(-8)

  ; ; ; 4k Cut
  ; aOutL eqfil aOutL, 4000, 500, ampdb(-8)
  ; aOutR eqfil aOutR, 4000, 500, ampdb(-8)

  ; ; ; Boost at 10k
  ; aOutL eqfil aOutL, 10000, 500, ampdb(15)
  ; aOutR eqfil aOutR, 10000, 500, ampdb(15)



  ; ; Low Pass at 22k
  aOutL pareq aOutL, 22000, ampdb(-100), sqrt(.5), 2
  aOutR pareq aOutR, 22000, ampdb(-100), sqrt(.5), 2


  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin
