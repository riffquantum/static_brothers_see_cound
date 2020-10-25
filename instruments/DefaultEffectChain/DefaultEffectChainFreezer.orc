bypassRoute "DefaultEffectChainFreezer", "DefaultEffectChainDelayInput", "DefaultEffectChainDelayInput"

alwayson "DefaultEffectChainFreezerInput"
alwayson "DefaultEffectChainFreezerMixerChannel"

gkDefaultEffectChainFreezerWetAmount init 1
gkDefaultEffectChainFreezerDryAmount init 0

gkDefaultEffectChainFreezerEqBass init 1
gkDefaultEffectChainFreezerEqMid init 1
gkDefaultEffectChainFreezerEqHigh init 1
gkDefaultEffectChainFreezerFader init 1
gkDefaultEffectChainFreezerPan init 50

instr DefaultEffectChainFreezerInput
  aDefaultEffectChainFreezerInL inleta "InL"
  aDefaultEffectChainFreezerInR inleta "InR"

  aDefaultEffectChainFreezerOutWetL, aDefaultEffectChainFreezerOutWetR, aDefaultEffectChainFreezerOutDryL, aDefaultEffectChainFreezerOutDryR bypassSwitch aDefaultEffectChainFreezerInL, aDefaultEffectChainFreezerInR, gkDefaultEffectChainFreezerDryAmount, gkDefaultEffectChainFreezerWetAmount, "DefaultEffectChainFreezer"

  outleta "OutWetL", aDefaultEffectChainFreezerOutWetL
  outleta "OutWetR", aDefaultEffectChainFreezerOutWetR

  outleta "OutDryL", aDefaultEffectChainFreezerOutDryL
  outleta "OutDryR", aDefaultEffectChainFreezerOutDryR
endin

instr DefaultEffectChainFreezer
  aDefaultEffectChainFreezerInL inleta "InL"
  aDefaultEffectChainFreezerInR inleta "InR"
  iBeatsToLoopStart = p4
  iBeatsToLoopEnd = p5 != 0 ? p5 : p4
  iDefaultEffectChainFreezerWetRelease = p6
  iPanAmount = p7
  aTime = linseg(iBeatsToLoopStart, p3, iBeatsToLoopEnd) * 60/gkBPM
  kWetLevel madsr .001, .001, 1, iDefaultEffectChainFreezerWetRelease
  iFeedbackAmount = 1
  iDefaultEffectChainFreezerBufferLength = 10
  kInputEnvelope = linseg(1, iBeatsToLoopStart, 1, .1, 0)

  kPanOscillator = poscil(iPanAmount * 50, 1/(aTime*2), squareWave()) + 50

  aDefaultEffectChainFreezerInL *= kInputEnvelope
  aDefaultEffectChainFreezerInR *= kInputEnvelope

  aDefaultEffectChainFreezerOutR delayBuffer aDefaultEffectChainFreezerInR, iFeedbackAmount, iDefaultEffectChainFreezerBufferLength, aTime, kWetLevel
  aDefaultEffectChainFreezerOutL delayBuffer aDefaultEffectChainFreezerInL, iFeedbackAmount, iDefaultEffectChainFreezerBufferLength, aTime, kWetLevel

  aDefaultEffectChainFreezerOutL, aDefaultEffectChainFreezerOutR pan aDefaultEffectChainFreezerOutL, aDefaultEffectChainFreezerOutR, kPanOscillator

  aDefaultEffectChainFreezerOutR += aDefaultEffectChainFreezerInR
  aDefaultEffectChainFreezerOutL += aDefaultEffectChainFreezerInL

  outleta "OutL", aDefaultEffectChainFreezerOutR
  outleta "OutR", aDefaultEffectChainFreezerOutL
endin

instr DefaultEffectChainFreezerBassKnob
  gkDefaultEffectChainFreezerEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainFreezerMidKnob
  gkDefaultEffectChainFreezerEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainFreezerHighKnob
  gkDefaultEffectChainFreezerEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainFreezerFader
  gkDefaultEffectChainFreezerFader linseg p4, p3, p5
endin

instr DefaultEffectChainFreezerPan
  gkDefaultEffectChainFreezerPan linseg p4, p3, p5
endin

instr DefaultEffectChainFreezerMixerChannel
  aDefaultEffectChainFreezerL inleta "InL"
  aDefaultEffectChainFreezerR inleta "InR"

  aDefaultEffectChainFreezerL, aDefaultEffectChainFreezerR threeBandEqStereo aDefaultEffectChainFreezerL, aDefaultEffectChainFreezerR, gkDefaultEffectChainFreezerEqBass, gkDefaultEffectChainFreezerEqMid, gkDefaultEffectChainFreezerEqHigh

  aDefaultEffectChainFreezerL, aDefaultEffectChainFreezerR pan aDefaultEffectChainFreezerL, aDefaultEffectChainFreezerR, gkDefaultEffectChainFreezerPan

  aDefaultEffectChainFreezerL *= gkDefaultEffectChainFreezerFader
  aDefaultEffectChainFreezerR *= gkDefaultEffectChainFreezerFader

  outleta "OutL", aDefaultEffectChainFreezerL
  outleta "OutR", aDefaultEffectChainFreezerR
endin
