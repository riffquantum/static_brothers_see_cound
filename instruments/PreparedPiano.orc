alwayson "PreparedPianoMixerChannel"

gkPreparedPianoEqBass init 1
gkPreparedPianoEqMid init 1
gkPreparedPianoEqHigh init 1
gkPreparedPianoFader init 1
gkPreparedPianoPan init 50
instrumentRoute "PreparedPiano", "NewEffectInput"

instr PreparedPiano
  iAmplitude flexibleAmplitudeInput p4
  iFrequency flexiblePitchInput p5

  aAmplitudeEnvelope madsr .01, .1, .8, .25

  iNumberOfStrings = 3
  iDetuneInCents = 3
  iStiffness = .01
  iDecayTime = 10
  iHighFrequencyAttentuation = .1
  kBoundaryConditionLeft = 3
  kBoundaryConditionRight = 3
  iHammerMass = .05
  iHammerFrequency = 440
  iHammerStartPosition = .5
  iStrikePoint = .01
  iStrikeVelocity = 40
  iScanningFrequency = 0
  iScanningFrequencySpread = 0

  aSignalL prepiano iFrequency, iNumberOfStrings, iDetuneInCents, iStiffness, \
    iDecayTime, iHighFrequencyAttentuation, kBoundaryConditionLeft, kBoundaryConditionRight, iHammerMass, iHammerFrequency, iHammerStartPosition, iStrikePoint, iStrikeVelocity, iScanningFrequency, iScanningFrequencySpread

  aSignalL *= aAmplitudeEnvelope
  aSignalR = aSignalL

  outleta "OutL", aSignalL
  outleta "OutR", aSignalR

  skipNote:
endin

instr PreparedPianoBassKnob
  gkPreparedPianoEqBass linseg p4, p3, p5
endin

instr PreparedPianoMidKnob
  gkPreparedPianoEqMid linseg p4, p3, p5
endin

instr PreparedPianoHighKnob
  gkPreparedPianoEqHigh linseg p4, p3, p5
endin

instr PreparedPianoFader
  gkPreparedPianoFader linseg p4, p3, p5
endin

instr PreparedPianoPan
  gkPreparedPianoPan linseg p4, p3, p5
endin

instr PreparedPianoMixerChannel
  aPreparedPianoL inleta "InL"
  aPreparedPianoR inleta "InR"

  aPreparedPianoL, aPreparedPianoR mixerChannel aPreparedPianoL, aPreparedPianoR, gkPreparedPianoFader, gkPreparedPianoPan, gkPreparedPianoEqBass, gkPreparedPianoEqMid, gkPreparedPianoEqHigh

  outleta "OutL", aPreparedPianoL
  outleta "OutR", aPreparedPianoR
endin
