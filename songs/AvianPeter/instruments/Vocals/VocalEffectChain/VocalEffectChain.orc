alwayson "VocalEffectChain"
alwayson "VocalEffectChainMixerChannel"

stereoRoute "VocalEffectChain", "VocalEffectChainCompressorInput"
stereoRoute "VocalEffectChainMixerChannel", "Mixer"

gkVocalEffectChainEqBass init 1
gkVocalEffectChainEqMid init 1
gkVocalEffectChainEqHigh init 1
gkVocalEffectChainFader init 1
gkVocalEffectChainPan init 50

instr VocalEffectChain
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"

  aSignalOutL = aSignalInL
  aSignalOutR = aSignalInR

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr VocalEffectChainBassKnob
  gkVocalEffectChainEqBass linseg p4, p3, p5
endin

instr VocalEffectChainMidKnob
  gkVocalEffectChainEqMid linseg p4, p3, p5
endin

instr VocalEffectChainHighKnob
  gkVocalEffectChainEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainFader
  gkVocalEffectChainFader linseg p4, p3, p5
endin

instr VocalEffectChainPan
  gkVocalEffectChainPan linseg p4, p3, p5
endin

instr VocalEffectChainMixerChannel
  aVocalEffectChainL inleta "InL"
  aVocalEffectChainR inleta "InR"

  aVocalEffectChainL, aVocalEffectChainR mixerChannel aVocalEffectChainL, aVocalEffectChainR, gkVocalEffectChainFader, gkVocalEffectChainPan, gkVocalEffectChainEqBass, gkVocalEffectChainEqMid, gkVocalEffectChainEqHigh

  outleta "OutL", aVocalEffectChainL
  outleta "OutR", aVocalEffectChainR
endin
