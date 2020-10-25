alwayson "VocalEffectChainPitchShifterInput"
alwayson "VocalEffectChainPitchShifterMixerChannel"

gkVocalEffectChainPitchShifterWetAmount init .8
gkVocalEffectChainPitchShifterDryAmount init 1
gkVocalEffectChainPitchShifterPitch init 1
giVocalEffectChainPitchShifterWetRelease init .1

gkVocalEffectChainPitchShifterEqBass init 1
gkVocalEffectChainPitchShifterEqMid init 1
gkVocalEffectChainPitchShifterEqHigh init 1
gkVocalEffectChainPitchShifterFader init 1
gkVocalEffectChainPitchShifterPan init 50

bypassRoute "VocalEffectChainPitchShifter", "VocalEffectChainLowPassFilterInput", "VocalEffectChainLowPassFilterInput"

instr VocalEffectChainPitchShifterInput
  aVocalEffectChainPitchShifterInL inleta "InL"
  aVocalEffectChainPitchShifterInR inleta "InR"

  aVocalEffectChainPitchShifterOutWetL, aVocalEffectChainPitchShifterOutWetR, aVocalEffectChainPitchShifterOutDryL, aVocalEffectChainPitchShifterOutDryR bypassSwitch aVocalEffectChainPitchShifterInL, aVocalEffectChainPitchShifterInR, gkVocalEffectChainPitchShifterDryAmount, gkVocalEffectChainPitchShifterWetAmount, "VocalEffectChainPitchShifter"

  outleta "OutWetL", aVocalEffectChainPitchShifterOutWetL
  outleta "OutWetR", aVocalEffectChainPitchShifterOutWetR

  outleta "OutDryL", aVocalEffectChainPitchShifterOutDryL
  outleta "OutDryR", aVocalEffectChainPitchShifterOutDryR
endin

instr VocalEffectChainPitchShifter
  aVocalEffectChainPitchShifterInL inleta "InL"
  aVocalEffectChainPitchShifterInR inleta "InR"
  kPitch = p4 * gkVocalEffectChainPitchShifterPitch
  kWetLevel madsr .001, .001, 1, giVocalEffectChainPitchShifterWetRelease

  aVocalEffectChainPitchShifterOutL pitchShifter aVocalEffectChainPitchShifterInL, kPitch, 1, 1
  aVocalEffectChainPitchShifterOutR pitchShifter aVocalEffectChainPitchShifterInR, kPitch, 1, 1

  ; aVocalEffectChainPitchShifterOutR += aVocalEffectChainPitchShifterInR
  ; aVocalEffectChainPitchShifterOutL += aVocalEffectChainPitchShifterInL

  outleta "OutL", aVocalEffectChainPitchShifterOutR
  outleta "OutR", aVocalEffectChainPitchShifterOutL
endin

instr VocalEffectChainPitchShifterBassKnob
  gkVocalEffectChainPitchShifterEqBass linseg p4, p3, p5
endin

instr VocalEffectChainPitchShifterMidKnob
  gkVocalEffectChainPitchShifterEqMid linseg p4, p3, p5
endin

instr VocalEffectChainPitchShifterHighKnob
  gkVocalEffectChainPitchShifterEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainPitchShifterFader
  gkVocalEffectChainPitchShifterFader linseg p4, p3, p5
endin

instr VocalEffectChainPitchShifterPan
  gkVocalEffectChainPitchShifterPan linseg p4, p3, p5
endin

instr VocalEffectChainPitchShifterMixerChannel
  aVocalEffectChainPitchShifterL inleta "InL"
  aVocalEffectChainPitchShifterR inleta "InR"

  aVocalEffectChainPitchShifterL, aVocalEffectChainPitchShifterR threeBandEqStereo aVocalEffectChainPitchShifterL, aVocalEffectChainPitchShifterR, gkVocalEffectChainPitchShifterEqBass, gkVocalEffectChainPitchShifterEqMid, gkVocalEffectChainPitchShifterEqHigh

  aVocalEffectChainPitchShifterL, aVocalEffectChainPitchShifterR pan aVocalEffectChainPitchShifterL, aVocalEffectChainPitchShifterR, gkVocalEffectChainPitchShifterPan

  aVocalEffectChainPitchShifterL *= gkVocalEffectChainPitchShifterFader
  aVocalEffectChainPitchShifterR *= gkVocalEffectChainPitchShifterFader

  outleta "OutL", aVocalEffectChainPitchShifterL
  outleta "OutR", aVocalEffectChainPitchShifterR
endin
