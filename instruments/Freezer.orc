bypassRoute "Freezer", "Mixer", "PitchShifterInput"

alwayson "FreezerInput"
alwayson "FreezerMixerChannel"

gkFreezerWetAmount init 1
gkFreezerDryAmount init 0

gkFreezerEqBass init 1
gkFreezerEqMid init 1
gkFreezerEqHigh init 1
gkFreezerFader init 1
gkFreezerPan init 50

instr FreezerInput
  aFreezerInL inleta "InL"
  aFreezerInR inleta "InR"

  aFreezerOutWetL, aFreezerOutWetR, aFreezerOutDryL, aFreezerOutDryR bypassSwitch aFreezerInL, aFreezerInR, gkFreezerDryAmount, gkFreezerWetAmount, "Freezer"

  outleta "OutWetL", aFreezerOutWetL
  outleta "OutWetR", aFreezerOutWetR

  outleta "OutDryL", aFreezerOutDryL
  outleta "OutDryR", aFreezerOutDryR
endin

instr Freezer
  aFreezerInL inleta "InL"
  aFreezerInR inleta "InR"
  iBeatsToLoopStart = p4
  iBeatsToLoopEnd = p5 != 0 ? p5 : p4
  iFreezerWetRelease = p6
  iPanAmount = p7
  aTime = linseg(iBeatsToLoopStart, p3, iBeatsToLoopEnd) * 60/gkBPM
  kWetLevel madsr .001, .001, 1, iFreezerWetRelease
  iFeedbackAmount = 1
  iFreezerBufferLength = 10
  kInputEnvelope = linseg(1, iBeatsToLoopStart, 1, .1, 0)

  kPanOscillator = poscil(iPanAmount * 50, 1/(aTime*2), squareWave()) + 50

  aFreezerInL *= kInputEnvelope
  aFreezerInR *= kInputEnvelope

  aFreezerOutR delayBuffer aFreezerInR, iFeedbackAmount, iFreezerBufferLength, aTime, kWetLevel
  aFreezerOutL delayBuffer aFreezerInL, iFeedbackAmount, iFreezerBufferLength, aTime, kWetLevel

  aFreezerOutL, aFreezerOutR pan aFreezerOutL, aFreezerOutR, kPanOscillator

  aFreezerOutR += aFreezerInR
  aFreezerOutL += aFreezerInL

  outleta "OutL", aFreezerOutR
  outleta "OutR", aFreezerOutL
endin

instr FreezerBassKnob
  gkFreezerEqBass linseg p4, p3, p5
endin

instr FreezerMidKnob
  gkFreezerEqMid linseg p4, p3, p5
endin

instr FreezerHighKnob
  gkFreezerEqHigh linseg p4, p3, p5
endin

instr FreezerFader
  gkFreezerFader linseg p4, p3, p5
endin

instr FreezerPan
  gkFreezerPan linseg p4, p3, p5
endin

instr FreezerMixerChannel
  aFreezerL inleta "InL"
  aFreezerR inleta "InR"

  aFreezerL, aFreezerR threeBandEqStereo aFreezerL, aFreezerR, gkFreezerEqBass, gkFreezerEqMid, gkFreezerEqHigh

  aFreezerL, aFreezerR pan aFreezerL, aFreezerR, gkFreezerPan

  aFreezerL *= gkFreezerFader
  aFreezerR *= gkFreezerFader

  outleta "OutL", aFreezerL
  outleta "OutR", aFreezerR
endin
