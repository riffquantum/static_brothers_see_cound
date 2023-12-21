alwayson "DrumEq"
stereoRoute "DrumEq", "DrumGrainInput"
instr DrumEq
  aInL inleta "InL"
  aInR inleta "InR"

  aOutL = aInL
  aOutR = aInR

  ; "saturation"?
  ; aOutL = compress(aOutL, aOutL, 0, 60, 60, 4, 0.0001, .5, .05) * 4
  ; aOutR = compress(aOutR, aOutR, 0, 60, 60, 4, 0.0001, .5, .05) * 4

  ; iLimit = ampdb(-2)
  ; aOutL = clip(aOutL*1.5, 0, iLimit) ;* 1/iLimit
  ; aOutR = clip(aOutR*1.5, 0, iLimit) ;* 1/iLimit

  ; aOutR pdclip aOutR, .25, 0
  ; aOutL pdclip aOutL, .25, 0

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin
