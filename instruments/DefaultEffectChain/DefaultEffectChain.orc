alwayson "DefaultEffectChain"
alwayson "DefaultEffectChainMixerChannel"

stereoRoute "DefaultEffectChain", "DefaultEffectChainPitchShifterInput"
stereoRoute "DefaultEffectChainMixerChannel", "Mixer"

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
