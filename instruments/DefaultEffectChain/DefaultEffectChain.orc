alwayson "DefaultEffectChain"
alwayson "DefaultEffectChainMixerChannel"

stereoRoute "DefaultEffectChain", "DefaultEffectChainCompressorInput"
stereoRoute "DefaultEffectChainMixerChannel", "Mixer"

gkDefaultEffectChainEqBass init 1
gkDefaultEffectChainEqMid init 1
gkDefaultEffectChainEqHigh init 1
gkDefaultEffectChainFader init 1
gkDefaultEffectChainPan init 50

instr DefaultEffectChain
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"

  aSignalOutL = aSignalInL
  aSignalOutR = aSignalInR

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr DefaultEffectChainBassKnob
  gkDefaultEffectChainEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainMidKnob
  gkDefaultEffectChainEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainHighKnob
  gkDefaultEffectChainEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainFader
  gkDefaultEffectChainFader linseg p4, p3, p5
endin

instr DefaultEffectChainPan
  gkDefaultEffectChainPan linseg p4, p3, p5
endin

instr DefaultEffectChainMixerChannel
  aDefaultEffectChainL inleta "InL"
  aDefaultEffectChainR inleta "InR"

  aDefaultEffectChainL, aDefaultEffectChainR mixerChannel aDefaultEffectChainL, aDefaultEffectChainR, gkDefaultEffectChainFader, gkDefaultEffectChainPan, gkDefaultEffectChainEqBass, gkDefaultEffectChainEqMid, gkDefaultEffectChainEqHigh

  outleta "OutL", aDefaultEffectChainL
  outleta "OutR", aDefaultEffectChainR
endin
