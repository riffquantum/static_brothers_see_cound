bypassRoute "VocalEffectChainFreezer", "VocalEffectChainDelayInput", "VocalEffectChainDelayInput"

alwayson "VocalEffectChainFreezerInput"
alwayson "VocalEffectChainFreezerMixerChannel"

gkVocalEffectChainFreezerWetAmount init 1
gkVocalEffectChainFreezerDryAmount init 0

gkVocalEffectChainFreezerEqBass init 1
gkVocalEffectChainFreezerEqMid init 1
gkVocalEffectChainFreezerEqHigh init 1
gkVocalEffectChainFreezerFader init 1
gkVocalEffectChainFreezerPan init 50

instr VocalEffectChainFreezerInput
  aVocalEffectChainFreezerInL inleta "InL"
  aVocalEffectChainFreezerInR inleta "InR"

  aVocalEffectChainFreezerOutWetL, aVocalEffectChainFreezerOutWetR, aVocalEffectChainFreezerOutDryL, aVocalEffectChainFreezerOutDryR bypassSwitch aVocalEffectChainFreezerInL, aVocalEffectChainFreezerInR, gkVocalEffectChainFreezerDryAmount, gkVocalEffectChainFreezerWetAmount, "VocalEffectChainFreezer"

  outleta "OutWetL", aVocalEffectChainFreezerOutWetL
  outleta "OutWetR", aVocalEffectChainFreezerOutWetR

  outleta "OutDryL", aVocalEffectChainFreezerOutDryL
  outleta "OutDryR", aVocalEffectChainFreezerOutDryR
endin

instr VocalEffectChainFreezer
  aVocalEffectChainFreezerInL inleta "InL"
  aVocalEffectChainFreezerInR inleta "InR"
  iBeatsToLoopStart = p4
  iBeatsToLoopEnd = p5 != 0 ? p5 : p4
  iVocalEffectChainFreezerWetRelease = p6
  iPanAmount = p7
  aTime = linseg(iBeatsToLoopStart, p3, iBeatsToLoopEnd) * 60/gkBPM
  kWetLevel madsr .001, .001, 1, iVocalEffectChainFreezerWetRelease
  iFeedbackAmount = 1
  iVocalEffectChainFreezerBufferLength = 10
  kInputEnvelope = linseg(1, iBeatsToLoopStart, 1, .1, 0)

  kPanOscillator = poscil(iPanAmount * 50, 1/(aTime*2), squareWave()) + 50

  aVocalEffectChainFreezerInL *= kInputEnvelope
  aVocalEffectChainFreezerInR *= kInputEnvelope

  aVocalEffectChainFreezerOutR delayBuffer aVocalEffectChainFreezerInR, iFeedbackAmount, iVocalEffectChainFreezerBufferLength, aTime, kWetLevel
  aVocalEffectChainFreezerOutL delayBuffer aVocalEffectChainFreezerInL, iFeedbackAmount, iVocalEffectChainFreezerBufferLength, aTime, kWetLevel

  aVocalEffectChainFreezerOutL, aVocalEffectChainFreezerOutR pan aVocalEffectChainFreezerOutL, aVocalEffectChainFreezerOutR, kPanOscillator

  aVocalEffectChainFreezerOutR += aVocalEffectChainFreezerInR
  aVocalEffectChainFreezerOutL += aVocalEffectChainFreezerInL

  outleta "OutL", aVocalEffectChainFreezerOutR
  outleta "OutR", aVocalEffectChainFreezerOutL
endin

instr VocalEffectChainFreezerBassKnob
  gkVocalEffectChainFreezerEqBass linseg p4, p3, p5
endin

instr VocalEffectChainFreezerMidKnob
  gkVocalEffectChainFreezerEqMid linseg p4, p3, p5
endin

instr VocalEffectChainFreezerHighKnob
  gkVocalEffectChainFreezerEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainFreezerFader
  gkVocalEffectChainFreezerFader linseg p4, p3, p5
endin

instr VocalEffectChainFreezerPan
  gkVocalEffectChainFreezerPan linseg p4, p3, p5
endin

instr VocalEffectChainFreezerMixerChannel
  aVocalEffectChainFreezerL inleta "InL"
  aVocalEffectChainFreezerR inleta "InR"

  aVocalEffectChainFreezerL, aVocalEffectChainFreezerR threeBandEqStereo aVocalEffectChainFreezerL, aVocalEffectChainFreezerR, gkVocalEffectChainFreezerEqBass, gkVocalEffectChainFreezerEqMid, gkVocalEffectChainFreezerEqHigh

  aVocalEffectChainFreezerL, aVocalEffectChainFreezerR pan aVocalEffectChainFreezerL, aVocalEffectChainFreezerR, gkVocalEffectChainFreezerPan

  aVocalEffectChainFreezerL *= gkVocalEffectChainFreezerFader
  aVocalEffectChainFreezerR *= gkVocalEffectChainFreezerFader

  outleta "OutL", aVocalEffectChainFreezerL
  outleta "OutR", aVocalEffectChainFreezerR
endin
