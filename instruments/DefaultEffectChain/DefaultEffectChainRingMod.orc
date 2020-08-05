alwayson "DefaultEffectChainRingModInput"
alwayson "DefaultEffectChainRingModMixerChannel"

gkDefaultEffectChainRingModEqBass init 1
gkDefaultEffectChainRingModEqMid init 1
gkDefaultEffectChainRingModEqHigh init 1
gkDefaultEffectChainRingModFader init 1
gkDefaultEffectChainRingModPan init 50

bypassRoute "DefaultEffectChainRingMod", "DefaultEffectChainTremoloInput", "DefaultEffectChainTremoloInput"

gkDefaultEffectChainRingModDryAmmount init 1
gkDefaultEffectChainRingModWetAmmount init 1

gkDefaultEffectChainRingModModulator1Frequency init 2000
gkDefaultEffectChainRingModModulator1Ammount init 1
gkDefaultEffectChainRingModModulator2Frequency init 1200
gkDefaultEffectChainRingModModulator2Ammount init 0
gkDefaultEffectChainRingModModulator3Frequency init 800
gkDefaultEffectChainRingModModulator3Ammount init 0
gkDefaultEffectChainRingModModulator4Frequency init 440
gkDefaultEffectChainRingModModulator4Ammount init 0
gkDefaultEffectChainRingModModulator5Frequency init 263
gkDefaultEffectChainRingModModulator5Ammount init 0

instr DefaultEffectChainRingModInput
  aDefaultEffectChainRingModInL inleta "InL"
  aDefaultEffectChainRingModInR inleta "InR"

  aDefaultEffectChainRingModOutWetL, aDefaultEffectChainRingModOutWetR, aDefaultEffectChainRingModOutDryL, aDefaultEffectChainRingModOutDryR bypassSwitch aDefaultEffectChainRingModInL, aDefaultEffectChainRingModInR, gkDefaultEffectChainRingModDryAmmount, gkDefaultEffectChainRingModWetAmmount, "DefaultEffectChainRingMod"

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
  aModulator += oscil(gkDefaultEffectChainRingModModulator1Ammount, gkDefaultEffectChainRingModModulator1Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator2Ammount, gkDefaultEffectChainRingModModulator2Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator3Ammount, gkDefaultEffectChainRingModModulator3Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator4Ammount, gkDefaultEffectChainRingModModulator4Frequency)
  aModulator += oscil(gkDefaultEffectChainRingModModulator5Ammount, gkDefaultEffectChainRingModModulator5Frequency)

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
