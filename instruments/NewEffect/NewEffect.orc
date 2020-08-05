bypassRoute "NewEffect", "DefaultEffectChain", "DefaultEffectChain"

alwayson "NewEffectInput"
alwayson "NewEffectMixerChannel"
alwayson "NewEffect"

gkNewEffectEqBass init 1
gkNewEffectEqMid init 1
gkNewEffectEqHigh init 1
gkNewEffectFader init 1
gkNewEffectPan init 50

gkNewEffectDryAmmount init 0
gkNewEffectWetAmmount init 1

gkNewEffectRate init 20
gkNewEffectDepth init 1

instr NewEffectInput
  aNewEffectInL inleta "InL"
  aNewEffectInR inleta "InR"

  aNewEffectOutWetL, aNewEffectOutWetR, aNewEffectOutDryL, aNewEffectOutDryR bypassSwitch aNewEffectInL, aNewEffectInR, gkNewEffectDryAmmount, gkNewEffectWetAmmount, "NewEffect"

  outleta "OutWetL", aNewEffectOutWetL
  outleta "OutWetR", aNewEffectOutWetR

  outleta "OutDryL", aNewEffectOutDryL
  outleta "OutDryR", aNewEffectOutDryR
endin


instr NewEffect
  aNewEffectInL inleta "InL"
  aNewEffectInR inleta "InR"

  aNewEffectOutL = aNewEffectInL
  aNewEffectOutR = aNewEffectInR

  outleta "OutL", aNewEffectOutL
  outleta "OutR", aNewEffectOutR
endin

instr NewEffectBassKnob
  gkNewEffectEqBass linseg p4, p3, p5
endin

instr NewEffectMidKnob
  gkNewEffectEqMid linseg p4, p3, p5
endin

instr NewEffectHighKnob
  gkNewEffectEqHigh linseg p4, p3, p5
endin

instr NewEffectFader
  gkNewEffectFader linseg p4, p3, p5
endin

instr NewEffectPan
  gkNewEffectPan linseg p4, p3, p5
endin

instr NewEffectMixerChannel
  aNewEffectL inleta "InL"
  aNewEffectR inleta "InR"

  aNewEffectL, aNewEffectR mixerChannel aNewEffectL, aNewEffectR, gkNewEffectFader, gkNewEffectPan, gkNewEffectEqBass, gkNewEffectEqMid, gkNewEffectEqHigh

  outleta "OutL", aNewEffectL
  outleta "OutR", aNewEffectR
endin
