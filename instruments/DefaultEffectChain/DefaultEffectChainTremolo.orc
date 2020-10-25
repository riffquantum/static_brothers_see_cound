bypassRoute "DefaultEffectChainTremolo", "DefaultEffectChainFreezerInput", "DefaultEffectChainFreezerInput"

alwayson "DefaultEffectChainTremoloInput"
alwayson "DefaultEffectChainTremoloMixerChannel"

gkDefaultEffectChainTremoloEqBass init 1
gkDefaultEffectChainTremoloEqMid init 1
gkDefaultEffectChainTremoloEqHigh init 1
gkDefaultEffectChainTremoloFader init 1
gkDefaultEffectChainTremoloPan init 50

gkDefaultEffectChainTremoloDryAmount init 0
gkDefaultEffectChainTremoloWetAmount init 1

giDefaultEffectChainTremoloWaveShapes[] fillarray sineWave(), triangleWave()
giDefaultEffectChainTremoloWaveShape init 1
gaDefaultEffectChainTremoloWaveSquareness init 0
gkDefaultEffectChainTremoloRate init 2
gkDefaultEffectChainTremoloDepth init 1


instr DefaultEffectChainTremoloInput
  aDefaultEffectChainTremoloInL inleta "InL"
  aDefaultEffectChainTremoloInR inleta "InR"

  aDefaultEffectChainTremoloOutWetL, aDefaultEffectChainTremoloOutWetR, aDefaultEffectChainTremoloOutDryL, aDefaultEffectChainTremoloOutDryR bypassSwitch aDefaultEffectChainTremoloInL, aDefaultEffectChainTremoloInR, gkDefaultEffectChainTremoloDryAmount, gkDefaultEffectChainTremoloWetAmount, "DefaultEffectChainTremolo"

  outleta "OutWetL", aDefaultEffectChainTremoloOutWetL
  outleta "OutWetR", aDefaultEffectChainTremoloOutWetR

  outleta "OutDryL", aDefaultEffectChainTremoloOutDryL
  outleta "OutDryR", aDefaultEffectChainTremoloOutDryR
endin


instr DefaultEffectChainTremolo
  aDefaultEffectChainTremoloInL inleta "InL"
  aDefaultEffectChainTremoloInR inleta "InR"

  kDefaultEffectChainTremoloDepth = limit(gkDefaultEffectChainTremoloDepth, 0, 1)
  aSquareness = (((gaDefaultEffectChainTremoloWaveSquareness/100)^(1/.3))*20) + 1
  aDefaultEffectChainTremoloWave = (poscil(.5, gkDefaultEffectChainTremoloRate, giDefaultEffectChainTremoloWaveShapes[giDefaultEffectChainTremoloWaveShape])) * aSquareness
  aDefaultEffectChainTremoloWave = limit(aDefaultEffectChainTremoloWave, -0.5, 0.5) + 0.5
  aDefaultEffectChainTremoloWave = 1 - (aDefaultEffectChainTremoloWave*kDefaultEffectChainTremoloDepth)

  ; optional monitor
  ; printk .01, k(aDefaultEffectChainTremoloWave)

  aDefaultEffectChainTremoloOutL = aDefaultEffectChainTremoloInL
  aDefaultEffectChainTremoloOutR = aDefaultEffectChainTremoloInR

  aDefaultEffectChainTremoloOutL *= aDefaultEffectChainTremoloWave
  aDefaultEffectChainTremoloOutR *= aDefaultEffectChainTremoloWave

  outleta "OutL", aDefaultEffectChainTremoloOutL
  outleta "OutR", aDefaultEffectChainTremoloOutR
endin

instr DefaultEffectChainTremoloBassKnob
  gkDefaultEffectChainTremoloEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainTremoloMidKnob
  gkDefaultEffectChainTremoloEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainTremoloHighKnob
  gkDefaultEffectChainTremoloEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainTremoloFader
  gkDefaultEffectChainTremoloFader linseg p4, p3, p5
endin

instr DefaultEffectChainTremoloPan
  gkDefaultEffectChainTremoloPan linseg p4, p3, p5
endin

instr DefaultEffectChainTremoloMixerChannel
  aDefaultEffectChainTremoloL inleta "InL"
  aDefaultEffectChainTremoloR inleta "InR"

  aDefaultEffectChainTremoloL, aDefaultEffectChainTremoloR mixerChannel aDefaultEffectChainTremoloL, aDefaultEffectChainTremoloR, gkDefaultEffectChainTremoloFader, gkDefaultEffectChainTremoloPan, gkDefaultEffectChainTremoloEqBass, gkDefaultEffectChainTremoloEqMid, gkDefaultEffectChainTremoloEqHigh

  outleta "OutL", aDefaultEffectChainTremoloL
  outleta "OutR", aDefaultEffectChainTremoloR
endin
