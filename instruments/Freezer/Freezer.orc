bypassRoute "Freezer", "Mixer"
stereoRoute "FreezerMixerChannel", "PitchShifterInput"

alwayson "FreezerInput"
alwayson "FreezerMixerChannel"

gkFreezerWetAmmount init 1
gkFreezerDryAmmount init 0

gkFreezerEqBass init 1
gkFreezerEqMid init 1
gkFreezerEqHigh init 1
gkFreezerFader init 1
gkFreezerPan init 50

instr FreezerInput
  aFreezerInL inleta "InL"
  aFreezerInR inleta "InR"

  aFreezerOutWetL, aFreezerOutWetR, aFreezerOutDryL, aFreezerOutDryR bypassSwitch aFreezerInL, aFreezerInR, gkFreezerDryAmmount, gkFreezerWetAmmount, "Freezer"

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
  aTime = linseg(iBeatsToLoopStart, p3, iBeatsToLoopEnd) * 60/gkBPM
  kWetLevel madsr .001, .001, 1, iFreezerWetRelease
  iFeedbackAmmount = 1
  iFreezerBufferLength = 10
  kInputEnvelope =linseg(1, iBeatsToLoopStart, 1, .1, 0)

  aFreezerInL *= kInputEnvelope
  aFreezerInR *= kInputEnvelope

  aFreezerOutR delayBuffer aFreezerInR, iFeedbackAmmount, iFreezerBufferLength, aTime, kWetLevel
  aFreezerOutL delayBuffer aFreezerInL, iFeedbackAmmount, iFreezerBufferLength, aTime, kWetLevel

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
