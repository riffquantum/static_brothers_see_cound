alwayson "NewEffect"
alwayson "NewEffectMixerChannel"

gkNewEffectEqBass init 1
gkNewEffectEqMid init 1
gkNewEffectEqHigh init 1
gkNewEffectFader init 1
gkNewEffectPan init 50
instrumentRoute "NewEffect", "Mixer"

instr NewEffect
  ; midiMonitor
  aNewEffectInL inleta "InL"
  aNewEffectInR inleta "InR"

  aModulator = oscil(1, 2000)

  aNewEffectOutL = aNewEffectInL
  aNewEffectOutR = aNewEffectInR

  aNewEffectOutL = aNewEffectOutL + aNewEffectOutL * poscil(1, 500)
  aNewEffectOutR = aNewEffectOutR + aNewEffectOutR * poscil(1, 500)

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
