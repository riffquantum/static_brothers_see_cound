alwayson "RingModInput"
alwayson "RingModMixerChannel"

gkRingModEqBass init 1
gkRingModEqMid init 1
gkRingModEqHigh init 1
gkRingModFader init 1
gkRingModPan init 50

bypassRoute "RingMod", "Mixer", "Mixer"

gkRingModDryAmount init 1
gkRingModWetAmount init 1

gkRingModModulator1Frequency init 2000
gkRingModModulator1Amount init 1
gkRingModModulator2Frequency init 1200
gkRingModModulator2Amount init 0
gkRingModModulator3Frequency init 800
gkRingModModulator3Amount init 0
gkRingModModulator4Frequency init 440
gkRingModModulator4Amount init 0
gkRingModModulator5Frequency init 263
gkRingModModulator5Amount init 0

instr RingModInput
  aRingModInL inleta "InL"
  aRingModInR inleta "InR"

  aRingModOutWetL, aRingModOutWetR, aRingModOutDryL, aRingModOutDryR bypassSwitch aRingModInL, aRingModInR, gkRingModDryAmount, gkRingModWetAmount, "RingMod"

  outleta "OutWetL", aRingModOutWetL
  outleta "OutWetR", aRingModOutWetR

  outleta "OutDryL", aRingModOutDryL
  outleta "OutDryR", aRingModOutDryR
endin

instr RingMod
  aRingModInL inleta "InL"
  aRingModInR inleta "InR"

  aRingModOutL = aRingModInL
  aRingModOutR = aRingModInR

  aModulator = 0
  aModulator += oscil(gkRingModModulator1Amount, gkRingModModulator1Frequency)
  aModulator += oscil(gkRingModModulator2Amount, gkRingModModulator2Frequency)
  aModulator += oscil(gkRingModModulator3Amount, gkRingModModulator3Frequency)
  aModulator += oscil(gkRingModModulator4Amount, gkRingModModulator4Frequency)
  aModulator += oscil(gkRingModModulator5Amount, gkRingModModulator5Frequency)

  aRingModOutL *= aModulator
  aRingModOutR *= aModulator

  outleta "OutL", aRingModOutL
  outleta "OutR", aRingModOutR
endin

instr RingModBassKnob
  gkRingModEqBass linseg p4, p3, p5
endin

instr RingModMidKnob
  gkRingModEqMid linseg p4, p3, p5
endin

instr RingModHighKnob
  gkRingModEqHigh linseg p4, p3, p5
endin

instr RingModFader
  gkRingModFader linseg p4, p3, p5
endin

instr RingModPan
  gkRingModPan linseg p4, p3, p5
endin

instr RingModMixerChannel
  aRingModL inleta "InL"
  aRingModR inleta "InR"

  aRingModL, aRingModR mixerChannel aRingModL, aRingModR, gkRingModFader, gkRingModPan, gkRingModEqBass, gkRingModEqMid, gkRingModEqHigh

  outleta "OutL", aRingModL
  outleta "OutR", aRingModR
endin
