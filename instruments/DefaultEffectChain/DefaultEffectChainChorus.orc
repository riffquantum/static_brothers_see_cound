alwayson "DefaultEffectChainChorusInput"
alwayson "DefaultEffectChainChorusMixerChannel"

bypassRoute "DefaultEffectChainChorus", "DefaultEffectChainTremoloInput", "DefaultEffectChainTremoloInput"

gkDefaultEffectChainChorusEqBass init 1
gkDefaultEffectChainChorusEqMid init 1
gkDefaultEffectChainChorusEqHigh init 1
gkDefaultEffectChainChorusFader init 1
gkDefaultEffectChainChorusPan init 50

gkDefaultEffectChainChorusDryAmount init 0
gkDefaultEffectChainChorusWetAmount init 1
gkDefaultEffectChainChorusAmount init 1
gkDefaultEffectChainChorusDryWet init 1
giDefaultEffectChainChorusStereoRecombinationMode = 0

instr DefaultEffectChainChorusInput
  aDefaultEffectChainChorusInL inleta "InL"
  aDefaultEffectChainChorusInR inleta "InR"

  aDefaultEffectChainChorusOutWetL, aDefaultEffectChainChorusOutWetR, aDefaultEffectChainChorusOutDryL, aDefaultEffectChainChorusOutDryR bypassSwitch aDefaultEffectChainChorusInL, aDefaultEffectChainChorusInR, gkDefaultEffectChainChorusDryAmount, gkDefaultEffectChainChorusWetAmount, "DefaultEffectChainChorus"

  outleta "OutWetL", aDefaultEffectChainChorusOutWetL
  outleta "OutWetR", aDefaultEffectChainChorusOutWetR

  outleta "OutDryL", aDefaultEffectChainChorusOutDryL
  outleta "OutDryR", aDefaultEffectChainChorusOutDryR
endin

instr DefaultEffectChainChorus
  aSignalInL inleta "InL"
  aSignalInR inleta "InR"


  kChorusAmount = gkDefaultEffectChainChorusAmount * (p4 == 0 ? 1 : p4)
  kDryWet = gkDefaultEffectChainChorusDryWet * (p5 == 0 ? 1 : p5)

  aSignalOutLL, aSignalOutLR m_chorus aSignalInL, kChorusAmount, kDryWet
  aSignalOutRL, aSignalOutRR m_chorus aSignalInR, kChorusAmount, kDryWet

  if giDefaultEffectChainChorusStereoRecombinationMode == 0 then
    aSignalOutL = aSignalOutLL
    aSignalOutR = aSignalOutRR
  else
    aSignalOutL = aSignalOutLL + aSignalOutRL
    aSignalOutR = aSignalOutLR + aSignalOutRR
  endif

  outleta "OutL", aSignalOutL
  outleta "OutR", aSignalOutR
endin

instr DefaultEffectChainChorusAmountKnob
  gkDefaultEffectChainChorusAmount linseg p4, p3, p5
endin

instr DefaultEffectChainChorusBassKnob
  gkDefaultEffectChainChorusEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainChorusMidKnob
  gkDefaultEffectChainChorusEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainChorusHighKnob
  gkDefaultEffectChainChorusEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainChorusFader
  gkDefaultEffectChainChorusFader linseg p4, p3, p5
endin

instr DefaultEffectChainChorusPan
  gkDefaultEffectChainChorusPan linseg p4, p3, p5
endin

instr DefaultEffectChainChorusMixerChannel
  aDefaultEffectChainChorusL inleta "InL"
  aDefaultEffectChainChorusR inleta "InR"

  aDefaultEffectChainChorusL, aDefaultEffectChainChorusR mixerChannel aDefaultEffectChainChorusL, aDefaultEffectChainChorusR, gkDefaultEffectChainChorusFader, gkDefaultEffectChainChorusPan, gkDefaultEffectChainChorusEqBass, gkDefaultEffectChainChorusEqMid, gkDefaultEffectChainChorusEqHigh

  outleta "OutL", aDefaultEffectChainChorusL
  outleta "OutR", aDefaultEffectChainChorusR
endin
