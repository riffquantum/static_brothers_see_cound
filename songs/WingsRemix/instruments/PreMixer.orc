stereoRoute "PreMixer", "Mixer"
alwayson "PreMixer"

instr PreMixer
  aInL inleta "InL"
  aInR inleta "InR"

  aOutL = aInL
  aOutR = aInR

  ; iLimit = ampdb(10)
  ; aOutL = clip(aOutL, 0, iLimit) ;* 1/iLimit
  ; aOutR = clip(aOutR, 0, iLimit)

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin
