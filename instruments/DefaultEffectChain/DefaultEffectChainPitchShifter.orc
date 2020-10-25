alwayson "DefaultEffectChainPitchShifterInput"
alwayson "DefaultEffectChainPitchShifterMixerChannel"

gkDefaultEffectChainPitchShifterWetAmount init 1
gkDefaultEffectChainPitchShifterDryAmount init 0

gkDefaultEffectChainPitchShifterEqBass init 1
gkDefaultEffectChainPitchShifterEqMid init 1
gkDefaultEffectChainPitchShifterEqHigh init 1
gkDefaultEffectChainPitchShifterFader init 1
gkDefaultEffectChainPitchShifterPan init 50

bypassRoute "DefaultEffectChainPitchShifter", "DefaultEffectChainLowPassFilterInput", "DefaultEffectChainLowPassFilterInput"

instr DefaultEffectChainPitchShifterInput
  aDefaultEffectChainPitchShifterInL inleta "InL"
  aDefaultEffectChainPitchShifterInR inleta "InR"

  aDefaultEffectChainPitchShifterOutWetL, aDefaultEffectChainPitchShifterOutWetR, aDefaultEffectChainPitchShifterOutDryL, aDefaultEffectChainPitchShifterOutDryR bypassSwitch aDefaultEffectChainPitchShifterInL, aDefaultEffectChainPitchShifterInR, gkDefaultEffectChainPitchShifterDryAmount, gkDefaultEffectChainPitchShifterWetAmount, "DefaultEffectChainPitchShifter"

  outleta "OutWetL", aDefaultEffectChainPitchShifterOutWetL
  outleta "OutWetR", aDefaultEffectChainPitchShifterOutWetR

  outleta "OutDryL", aDefaultEffectChainPitchShifterOutDryL
  outleta "OutDryR", aDefaultEffectChainPitchShifterOutDryR
endin

instr DefaultEffectChainPitchShifter
  aDefaultEffectChainPitchShifterInL inleta "InL"
  aDefaultEffectChainPitchShifterInR inleta "InR"
  iStartingPitch = p4
  iEndingPitch = p5 != 0 ? p5 : p4
  iDefaultEffectChainPitchShifterWetRelease = p6
  kPitchShift = linseg(iStartingPitch, p3, iEndingPitch)
  kWetLevel madsr .001, .001, 1, iDefaultEffectChainPitchShifterWetRelease

  aDefaultEffectChainPitchShifterOutL pitchShifter aDefaultEffectChainPitchShifterInL, kPitchShift, 1, 1
  aDefaultEffectChainPitchShifterOutR pitchShifter aDefaultEffectChainPitchShifterInR, kPitchShift, 1, 1

  ; aDefaultEffectChainPitchShifterOutR += aDefaultEffectChainPitchShifterInR
  ; aDefaultEffectChainPitchShifterOutL += aDefaultEffectChainPitchShifterInL

  outleta "OutL", aDefaultEffectChainPitchShifterOutR
  outleta "OutR", aDefaultEffectChainPitchShifterOutL
endin

instr DefaultEffectChainPitchShifterBassKnob
  gkDefaultEffectChainPitchShifterEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainPitchShifterMidKnob
  gkDefaultEffectChainPitchShifterEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainPitchShifterHighKnob
  gkDefaultEffectChainPitchShifterEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainPitchShifterFader
  gkDefaultEffectChainPitchShifterFader linseg p4, p3, p5
endin

instr DefaultEffectChainPitchShifterPan
  gkDefaultEffectChainPitchShifterPan linseg p4, p3, p5
endin

instr DefaultEffectChainPitchShifterMixerChannel
  aDefaultEffectChainPitchShifterL inleta "InL"
  aDefaultEffectChainPitchShifterR inleta "InR"

  aDefaultEffectChainPitchShifterL, aDefaultEffectChainPitchShifterR threeBandEqStereo aDefaultEffectChainPitchShifterL, aDefaultEffectChainPitchShifterR, gkDefaultEffectChainPitchShifterEqBass, gkDefaultEffectChainPitchShifterEqMid, gkDefaultEffectChainPitchShifterEqHigh

  aDefaultEffectChainPitchShifterL, aDefaultEffectChainPitchShifterR pan aDefaultEffectChainPitchShifterL, aDefaultEffectChainPitchShifterR, gkDefaultEffectChainPitchShifterPan

  aDefaultEffectChainPitchShifterL *= gkDefaultEffectChainPitchShifterFader
  aDefaultEffectChainPitchShifterR *= gkDefaultEffectChainPitchShifterFader

  outleta "OutL", aDefaultEffectChainPitchShifterL
  outleta "OutR", aDefaultEffectChainPitchShifterR
endin
