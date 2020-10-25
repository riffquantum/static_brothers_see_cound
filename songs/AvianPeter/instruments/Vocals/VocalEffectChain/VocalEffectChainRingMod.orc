alwayson "VocalEffectChainRingModInput"
alwayson "VocalEffectChainRingModMixerChannel"

gkVocalEffectChainRingModEqBass init 1
gkVocalEffectChainRingModEqMid init 1
gkVocalEffectChainRingModEqHigh init 1
gkVocalEffectChainRingModFader init 1
gkVocalEffectChainRingModPan init 50

bypassRoute "VocalEffectChainRingMod", "VocalEffectChainTremoloInput", "VocalEffectChainTremoloInput"

gkVocalEffectChainRingModDryAmount init 1
gkVocalEffectChainRingModWetAmount init 1

gkVocalEffectChainRingModModulator1Frequency init 2000
gkVocalEffectChainRingModModulator1Amount init 1
gkVocalEffectChainRingModModulator2Frequency init 1200
gkVocalEffectChainRingModModulator2Amount init 0
gkVocalEffectChainRingModModulator3Frequency init 800
gkVocalEffectChainRingModModulator3Amount init 0
gkVocalEffectChainRingModModulator4Frequency init 440
gkVocalEffectChainRingModModulator4Amount init 0
gkVocalEffectChainRingModModulator5Frequency init 263
gkVocalEffectChainRingModModulator5Amount init 0

instr VocalEffectChainRingModInput
  aVocalEffectChainRingModInL inleta "InL"
  aVocalEffectChainRingModInR inleta "InR"

  aVocalEffectChainRingModOutWetL, aVocalEffectChainRingModOutWetR, aVocalEffectChainRingModOutDryL, aVocalEffectChainRingModOutDryR bypassSwitch aVocalEffectChainRingModInL, aVocalEffectChainRingModInR, gkVocalEffectChainRingModDryAmount, gkVocalEffectChainRingModWetAmount, "VocalEffectChainRingMod"

  outleta "OutWetL", aVocalEffectChainRingModOutWetL
  outleta "OutWetR", aVocalEffectChainRingModOutWetR

  outleta "OutDryL", aVocalEffectChainRingModOutDryL
  outleta "OutDryR", aVocalEffectChainRingModOutDryR
endin

instr VocalEffectChainRingMod
  aVocalEffectChainRingModInL inleta "InL"
  aVocalEffectChainRingModInR inleta "InR"

  aVocalEffectChainRingModOutL = aVocalEffectChainRingModInL
  aVocalEffectChainRingModOutR = aVocalEffectChainRingModInR

  aModulator = 0
  aModulator += oscil(gkVocalEffectChainRingModModulator1Amount, gkVocalEffectChainRingModModulator1Frequency)
  aModulator += oscil(gkVocalEffectChainRingModModulator2Amount, gkVocalEffectChainRingModModulator2Frequency)
  aModulator += oscil(gkVocalEffectChainRingModModulator3Amount, gkVocalEffectChainRingModModulator3Frequency)
  aModulator += oscil(gkVocalEffectChainRingModModulator4Amount, gkVocalEffectChainRingModModulator4Frequency)
  aModulator += oscil(gkVocalEffectChainRingModModulator5Amount, gkVocalEffectChainRingModModulator5Frequency)

  aVocalEffectChainRingModOutL *= aModulator
  aVocalEffectChainRingModOutR *= aModulator

  outleta "OutL", aVocalEffectChainRingModOutL
  outleta "OutR", aVocalEffectChainRingModOutR
endin

instr VocalEffectChainRingModBassKnob
  gkVocalEffectChainRingModEqBass linseg p4, p3, p5
endin

instr VocalEffectChainRingModMidKnob
  gkVocalEffectChainRingModEqMid linseg p4, p3, p5
endin

instr VocalEffectChainRingModHighKnob
  gkVocalEffectChainRingModEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainRingModFader
  gkVocalEffectChainRingModFader linseg p4, p3, p5
endin

instr VocalEffectChainRingModPan
  gkVocalEffectChainRingModPan linseg p4, p3, p5
endin

instr VocalEffectChainRingModMixerChannel
  aVocalEffectChainRingModL inleta "InL"
  aVocalEffectChainRingModR inleta "InR"

  aVocalEffectChainRingModL, aVocalEffectChainRingModR mixerChannel aVocalEffectChainRingModL, aVocalEffectChainRingModR, gkVocalEffectChainRingModFader, gkVocalEffectChainRingModPan, gkVocalEffectChainRingModEqBass, gkVocalEffectChainRingModEqMid, gkVocalEffectChainRingModEqHigh

  outleta "OutL", aVocalEffectChainRingModL
  outleta "OutR", aVocalEffectChainRingModR
endin
