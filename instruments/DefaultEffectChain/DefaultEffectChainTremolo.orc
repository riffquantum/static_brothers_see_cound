bypassRoute "DefaultEffectChainTremolo", "DefaultEffectChainFreezerInput", "DefaultEffectChainFreezerInput"

alwayson "DefaultEffectChainTremoloInput"
alwayson "DefaultEffectChainTremoloMixerChannel"

gkDefaultEffectChainTremoloEqBass init 1
gkDefaultEffectChainTremoloEqMid init 1
gkDefaultEffectChainTremoloEqHigh init 1
gkDefaultEffectChainTremoloFader init 1
gkDefaultEffectChainTremoloPan init 50

gkDefaultEffectChainTremoloDryAmmount init 0
gkDefaultEffectChainTremoloWetAmmount init 1

gkDefaultEffectChainTremoloRate init 5
gkDefaultEffectChainTremoloDepth init 1


instr DefaultEffectChainTremoloInput
  aDefaultEffectChainTremoloInL inleta "InL"
  aDefaultEffectChainTremoloInR inleta "InR"

  aDefaultEffectChainTremoloOutWetL, aDefaultEffectChainTremoloOutWetR, aDefaultEffectChainTremoloOutDryL, aDefaultEffectChainTremoloOutDryR bypassSwitch aDefaultEffectChainTremoloInL, aDefaultEffectChainTremoloInR, gkDefaultEffectChainTremoloDryAmmount, gkDefaultEffectChainTremoloWetAmmount, "DefaultEffectChainTremolo"

  outleta "OutWetL", aDefaultEffectChainTremoloOutWetL
  outleta "OutWetR", aDefaultEffectChainTremoloOutWetR

  outleta "OutDryL", aDefaultEffectChainTremoloOutDryL
  outleta "OutDryR", aDefaultEffectChainTremoloOutDryR
endin


instr DefaultEffectChainTremolo
  aDefaultEffectChainTremoloInL inleta "InL"
  aDefaultEffectChainTremoloInR inleta "InR"

  aDefaultEffectChainTremoloOutL = aDefaultEffectChainTremoloInL
  aDefaultEffectChainTremoloOutR = aDefaultEffectChainTremoloInR

  gkDefaultEffectChainTremoloDepth = limit(gkDefaultEffectChainTremoloDepth, 0, 1)
  aDefaultEffectChainTremoloWave = poscil(gkDefaultEffectChainTremoloDepth, gkDefaultEffectChainTremoloRate) + (1 - gkDefaultEffectChainTremoloDepth)

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
