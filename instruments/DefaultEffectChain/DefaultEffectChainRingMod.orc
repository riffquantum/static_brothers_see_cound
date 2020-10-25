alwayson "DefaultEffectChainRingModInput"
alwayson "DefaultEffectChainRingModMixerChannel"

gkDefaultEffectChainRingModEqBass init 1
gkDefaultEffectChainRingModEqMid init 1
gkDefaultEffectChainRingModEqHigh init 1
gkDefaultEffectChainRingModFader init 1
gkDefaultEffectChainRingModPan init 50

bypassRoute "DefaultEffectChainRingMod", "DefaultEffectChainChorusInput", "DefaultEffectChainTremoloInput"

gkDefaultEffectChainRingModDryAmount init 1
gkDefaultEffectChainRingModWetAmount init 1

gkDefaultEffectChainRingModModulator1Frequency init 2000
gkDefaultEffectChainRingModModulator1Amount init 1
gkDefaultEffectChainRingModModulator2Frequency init 1200
gkDefaultEffectChainRingModModulator2Amount init 0
gkDefaultEffectChainRingModModulator3Frequency init 800
gkDefaultEffectChainRingModModulator3Amount init 0
gkDefaultEffectChainRingModModulator4Frequency init 440
gkDefaultEffectChainRingModModulator4Amount init 0
gkDefaultEffectChainRingModModulator5Frequency init 263
gkDefaultEffectChainRingModModulator5Amount init 0

instr DefaultEffectChainRingModInput
  aDefaultEffectChainRingModInL inleta "InL"
  aDefaultEffectChainRingModInR inleta "InR"

  aDefaultEffectChainRingModOutWetL, aDefaultEffectChainRingModOutWetR, aDefaultEffectChainRingModOutDryL, aDefaultEffectChainRingModOutDryR bypassSwitch aDefaultEffectChainRingModInL, aDefaultEffectChainRingModInR, gkDefaultEffectChainRingModDryAmount, gkDefaultEffectChainRingModWetAmount, "DefaultEffectChainRingMod"

  outleta "OutWetL", aDefaultEffectChainRingModOutWetL
  outleta "OutWetR", aDefaultEffectChainRingModOutWetR

  outleta "OutDryL", aDefaultEffectChainRingModOutDryL
  outleta "OutDryR", aDefaultEffectChainRingModOutDryR
endin

instr DefaultEffectChainRingMod
  aDefaultEffectChainRingModInL inleta "InL"
  aDefaultEffectChainRingModInR inleta "InR"

  aDefaultEffectChainRingModOutL = aDefaultEffectChainRingModInL
  aDefaultEffectChainRingModOutR = aDefaultEffectChainRingModInR

  aModulator = 0
  aModulator += oscil(gkDefaultEffectChainRingModModulator1Amount, gkDefaultEffectChainRingModModulator1Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator2Amount, gkDefaultEffectChainRingModModulator2Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator3Amount, gkDefaultEffectChainRingModModulator3Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator4Amount, gkDefaultEffectChainRingModModulator4Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator5Amount, gkDefaultEffectChainRingModModulator5Frequency)

  aDefaultEffectChainRingModOutL *= aModulator
  aDefaultEffectChainRingModOutR *= aModulator

  outleta "OutL", aDefaultEffectChainRingModOutL
  outleta "OutR", aDefaultEffectChainRingModOutR
endin

instr DefaultEffectChainRingModBassKnob
  gkDefaultEffectChainRingModEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainRingModMidKnob
  gkDefaultEffectChainRingModEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainRingModHighKnob
  gkDefaultEffectChainRingModEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainRingModFader
  gkDefaultEffectChainRingModFader linseg p4, p3, p5
endin

instr DefaultEffectChainRingModPan
  gkDefaultEffectChainRingModPan linseg p4, p3, p5
endin

instr DefaultEffectChainRingModMixerChannel
  aDefaultEffectChainRingModL inleta "InL"
  aDefaultEffectChainRingModR inleta "InR"

  aDefaultEffectChainRingModL, aDefaultEffectChainRingModR mixerChannel aDefaultEffectChainRingModL, aDefaultEffectChainRingModR, gkDefaultEffectChainRingModFader, gkDefaultEffectChainRingModPan, gkDefaultEffectChainRingModEqBass, gkDefaultEffectChainRingModEqMid, gkDefaultEffectChainRingModEqHigh

  outleta "OutL", aDefaultEffectChainRingModL
  outleta "OutR", aDefaultEffectChainRingModR
endin
