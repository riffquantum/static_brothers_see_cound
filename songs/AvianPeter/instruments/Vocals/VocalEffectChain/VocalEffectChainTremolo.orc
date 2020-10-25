bypassRoute "VocalEffectChainTremolo", "VocalEffectChainFreezerInput", "VocalEffectChainFreezerInput"

alwayson "VocalEffectChainTremoloInput"
alwayson "VocalEffectChainTremoloMixerChannel"

gkVocalEffectChainTremoloEqBass init 1
gkVocalEffectChainTremoloEqMid init 1
gkVocalEffectChainTremoloEqHigh init 1
gkVocalEffectChainTremoloFader init 1
gkVocalEffectChainTremoloPan init 50

gkVocalEffectChainTremoloDryAmount init 0
gkVocalEffectChainTremoloWetAmount init 1

giVocalEffectChainTremoloWaveShapes[] fillarray sineWave(), triangleWave()
giVocalEffectChainTremoloWaveShape init 1
gaVocalEffectChainTremoloWaveSquareness init 0
gkVocalEffectChainTremoloRate init 2
gkVocalEffectChainTremoloDepth init 1


instr VocalEffectChainTremoloInput
  aVocalEffectChainTremoloInL inleta "InL"
  aVocalEffectChainTremoloInR inleta "InR"

  aVocalEffectChainTremoloOutWetL, aVocalEffectChainTremoloOutWetR, aVocalEffectChainTremoloOutDryL, aVocalEffectChainTremoloOutDryR bypassSwitch aVocalEffectChainTremoloInL, aVocalEffectChainTremoloInR, gkVocalEffectChainTremoloDryAmount, gkVocalEffectChainTremoloWetAmount, "VocalEffectChainTremolo"

  outleta "OutWetL", aVocalEffectChainTremoloOutWetL
  outleta "OutWetR", aVocalEffectChainTremoloOutWetR

  outleta "OutDryL", aVocalEffectChainTremoloOutDryL
  outleta "OutDryR", aVocalEffectChainTremoloOutDryR
endin


instr VocalEffectChainTremolo
  aVocalEffectChainTremoloInL inleta "InL"
  aVocalEffectChainTremoloInR inleta "InR"

  kVocalEffectChainTremoloDepth = limit(gkVocalEffectChainTremoloDepth, 0, 1)
  aSquareness = (((gaVocalEffectChainTremoloWaveSquareness/100)^(1/.3))*20) + 1
  aVocalEffectChainTremoloWave = (poscil(.5, gkVocalEffectChainTremoloRate, giVocalEffectChainTremoloWaveShapes[giVocalEffectChainTremoloWaveShape])) * aSquareness
  aVocalEffectChainTremoloWave = limit(aVocalEffectChainTremoloWave, -0.5, 0.5) + 0.5
  aVocalEffectChainTremoloWave = 1 - (aVocalEffectChainTremoloWave*kVocalEffectChainTremoloDepth)

  ; optional monitor
  ; printk .01, k(aVocalEffectChainTremoloWave)

  aVocalEffectChainTremoloOutL = aVocalEffectChainTremoloInL
  aVocalEffectChainTremoloOutR = aVocalEffectChainTremoloInR

  aVocalEffectChainTremoloOutL *= aVocalEffectChainTremoloWave
  aVocalEffectChainTremoloOutR *= aVocalEffectChainTremoloWave

  outleta "OutL", aVocalEffectChainTremoloOutL
  outleta "OutR", aVocalEffectChainTremoloOutR
endin

instr VocalEffectChainTremoloBassKnob
  gkVocalEffectChainTremoloEqBass linseg p4, p3, p5
endin

instr VocalEffectChainTremoloMidKnob
  gkVocalEffectChainTremoloEqMid linseg p4, p3, p5
endin

instr VocalEffectChainTremoloHighKnob
  gkVocalEffectChainTremoloEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainTremoloFader
  gkVocalEffectChainTremoloFader linseg p4, p3, p5
endin

instr VocalEffectChainTremoloPan
  gkVocalEffectChainTremoloPan linseg p4, p3, p5
endin

instr VocalEffectChainTremoloMixerChannel
  aVocalEffectChainTremoloL inleta "InL"
  aVocalEffectChainTremoloR inleta "InR"

  aVocalEffectChainTremoloL, aVocalEffectChainTremoloR mixerChannel aVocalEffectChainTremoloL, aVocalEffectChainTremoloR, gkVocalEffectChainTremoloFader, gkVocalEffectChainTremoloPan, gkVocalEffectChainTremoloEqBass, gkVocalEffectChainTremoloEqMid, gkVocalEffectChainTremoloEqHigh

  outleta "OutL", aVocalEffectChainTremoloL
  outleta "OutR", aVocalEffectChainTremoloR
endin
