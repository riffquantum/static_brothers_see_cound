bypassRoute "DefaultDrumKitFreezer", "DefaultDrumKitReverb", "DefaultDrumKitReverb"

alwayson "DefaultDrumKitFreezerInput"
alwayson "DefaultDrumKitFreezerMixerChannel"

gkDefaultDrumKitFreezerWetAmmount init 1
gkDefaultDrumKitFreezerDryAmmount init 0

gkDefaultDrumKitFreezerEqBass init 1
gkDefaultDrumKitFreezerEqMid init 1
gkDefaultDrumKitFreezerEqHigh init 1
gkDefaultDrumKitFreezerFader init 1
gkDefaultDrumKitFreezerPan init 50

instr DefaultDrumKitFreezerInput
  aDefaultDrumKitFreezerInL inleta "InL"
  aDefaultDrumKitFreezerInR inleta "InR"

  aDefaultDrumKitFreezerOutWetL, aDefaultDrumKitFreezerOutWetR, aDefaultDrumKitFreezerOutDryL, aDefaultDrumKitFreezerOutDryR bypassSwitch aDefaultDrumKitFreezerInL, aDefaultDrumKitFreezerInR, gkDefaultDrumKitFreezerDryAmmount, gkDefaultDrumKitFreezerWetAmmount, "DefaultDrumKitFreezer"

  outleta "OutWetL", aDefaultDrumKitFreezerOutWetL
  outleta "OutWetR", aDefaultDrumKitFreezerOutWetR

  outleta "OutDryL", aDefaultDrumKitFreezerOutDryL
  outleta "OutDryR", aDefaultDrumKitFreezerOutDryR
endin

instr DefaultDrumKitFreezer
  aDefaultDrumKitFreezerInL inleta "InL"
  aDefaultDrumKitFreezerInR inleta "InR"
  iBeatsToLoopStart = p4
  iBeatsToLoopEnd = p5 != 0 ? p5 : p4
  iDefaultDrumKitFreezerWetRelease = p6
  iPanAmount = p7
  aTime = linseg(iBeatsToLoopStart, p3, iBeatsToLoopEnd) * 60/gkBPM
  kWetLevel madsr .001, .001, 1, iDefaultDrumKitFreezerWetRelease
  iFeedbackAmmount = 1
  iDefaultDrumKitFreezerBufferLength = 10
  kInputEnvelope = linseg(1, iBeatsToLoopStart, 1, .1, 0)

  kPanOscillator = poscil(iPanAmount * 50, 1/(aTime*2), squareWave()) + 50

  aDefaultDrumKitFreezerInL *= kInputEnvelope
  aDefaultDrumKitFreezerInR *= kInputEnvelope

  aDefaultDrumKitFreezerOutR delayBuffer aDefaultDrumKitFreezerInR, iFeedbackAmmount, iDefaultDrumKitFreezerBufferLength, aTime, kWetLevel
  aDefaultDrumKitFreezerOutL delayBuffer aDefaultDrumKitFreezerInL, iFeedbackAmmount, iDefaultDrumKitFreezerBufferLength, aTime, kWetLevel

  aDefaultDrumKitFreezerOutL, aDefaultDrumKitFreezerOutR pan aDefaultDrumKitFreezerOutL, aDefaultDrumKitFreezerOutR, kPanOscillator

  aDefaultDrumKitFreezerOutR += aDefaultDrumKitFreezerInR
  aDefaultDrumKitFreezerOutL += aDefaultDrumKitFreezerInL

  outleta "OutL", aDefaultDrumKitFreezerOutR
  outleta "OutR", aDefaultDrumKitFreezerOutL
endin

instr DefaultDrumKitFreezerBassKnob
  gkDefaultDrumKitFreezerEqBass linseg p4, p3, p5
endin

instr DefaultDrumKitFreezerMidKnob
  gkDefaultDrumKitFreezerEqMid linseg p4, p3, p5
endin

instr DefaultDrumKitFreezerHighKnob
  gkDefaultDrumKitFreezerEqHigh linseg p4, p3, p5
endin

instr DefaultDrumKitFreezerFader
  gkDefaultDrumKitFreezerFader linseg p4, p3, p5
endin

instr DefaultDrumKitFreezerPan
  gkDefaultDrumKitFreezerPan linseg p4, p3, p5
endin

instr DefaultDrumKitFreezerMixerChannel
  aDefaultDrumKitFreezerL inleta "InL"
  aDefaultDrumKitFreezerR inleta "InR"

  aDefaultDrumKitFreezerL, aDefaultDrumKitFreezerR threeBandEqStereo aDefaultDrumKitFreezerL, aDefaultDrumKitFreezerR, gkDefaultDrumKitFreezerEqBass, gkDefaultDrumKitFreezerEqMid, gkDefaultDrumKitFreezerEqHigh

  aDefaultDrumKitFreezerL, aDefaultDrumKitFreezerR pan aDefaultDrumKitFreezerL, aDefaultDrumKitFreezerR, gkDefaultDrumKitFreezerPan

  aDefaultDrumKitFreezerL *= gkDefaultDrumKitFreezerFader
  aDefaultDrumKitFreezerR *= gkDefaultDrumKitFreezerFader

  outleta "OutL", aDefaultDrumKitFreezerL
  outleta "OutR", aDefaultDrumKitFreezerR
endin
