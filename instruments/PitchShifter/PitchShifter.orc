alwayson "PitchShifterInput"
alwayson "PitchShifterMixerChannel"

gkPitchShifterWetAmmount init 1
gkPitchShifterDryAmmount init 0

gkPitchShifterEqBass init 1
gkPitchShifterEqMid init 1
gkPitchShifterEqHigh init 1
gkPitchShifterFader init 1
gkPitchShifterPan init 50

bypassRoute "PitchShifter"
stereoRoute "PitchShifterMixerChannel", "Mixer"

instr PitchShifterInput
  aPitchShifterInL inleta "InL"
  aPitchShifterInR inleta "InR"

  aPitchShifterOutWetL, aPitchShifterOutWetR, aPitchShifterOutDryL, aPitchShifterOutDryR bypassSwitch aPitchShifterInL, aPitchShifterInR, gkPitchShifterDryAmmount, gkPitchShifterWetAmmount, "PitchShifter"

  outleta "OutWetL", aPitchShifterOutWetL
  outleta "OutWetR", aPitchShifterOutWetR

  outleta "OutDryL", aPitchShifterOutDryL
  outleta "OutDryR", aPitchShifterOutDryR
endin

instr PitchShifter
  aPitchShifterInL inleta "InL"
  aPitchShifterInR inleta "InR"
  iStartingPitch = p4
  iEndingPitch = p5 != 0 ? p5 : p4
  iPitchShifterWetRelease = p6
  kPitchShift = linseg(iStartingPitch, p3, iEndingPitch)
  kWetLevel madsr .001, .001, 1, iPitchShifterWetRelease

  aPitchShifterOutL pitchShifter aPitchShifterInL, kPitchShift, 1, 1
  aPitchShifterOutR pitchShifter aPitchShifterInR, kPitchShift, 1, 1

  ; aPitchShifterOutR += aPitchShifterInR
  ; aPitchShifterOutL += aPitchShifterInL

  outleta "OutL", aPitchShifterOutR
  outleta "OutR", aPitchShifterOutL
endin

instr PitchShifterBassKnob
  gkPitchShifterEqBass linseg p4, p3, p5
endin

instr PitchShifterMidKnob
  gkPitchShifterEqMid linseg p4, p3, p5
endin

instr PitchShifterHighKnob
  gkPitchShifterEqHigh linseg p4, p3, p5
endin

instr PitchShifterFader
  gkPitchShifterFader linseg p4, p3, p5
endin

instr PitchShifterPan
  gkPitchShifterPan linseg p4, p3, p5
endin

instr PitchShifterMixerChannel
  aPitchShifterL inleta "InL"
  aPitchShifterR inleta "InR"

  aPitchShifterL, aPitchShifterR threeBandEqStereo aPitchShifterL, aPitchShifterR, gkPitchShifterEqBass, gkPitchShifterEqMid, gkPitchShifterEqHigh

  aPitchShifterL, aPitchShifterR pan aPitchShifterL, aPitchShifterR, gkPitchShifterPan

  aPitchShifterL *= gkPitchShifterFader
  aPitchShifterR *= gkPitchShifterFader

  outleta "OutL", aPitchShifterL
  outleta "OutR", aPitchShifterR
endin
