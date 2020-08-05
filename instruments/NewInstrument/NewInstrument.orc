alwayson "NewInstrumentMixerChannel"

gkNewInstrumentEqBass init 1
gkNewInstrumentEqMid init 1
gkNewInstrumentEqHigh init 1
gkNewInstrumentFader init 1
gkNewInstrumentPan init 50
instrumentRoute "NewInstrument", "NewEffectInput"

instr NewInstrument
  iAmplitude flexibleAmplitudeInput p4
  iFrequency flexiblePitchInput p5

  aAmplitudeEnvelope madsr .01, .1, .8, .25
  aSignalL = 0

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

  ; asignal STKRhodey ifrequency, iamplitude, [kmod, kv1[, kcross, kv2[, klfo, kv3[, klfodepth, kv4[, kadsr, kv5]]]]]

  aSignalL *= aAmplitudeEnvelope
  aSignalR = aSignalL

  outleta "OutL", aSignalL
  outleta "OutR", aSignalR

  skipNote:
endin

instr NewInstrumentBassKnob
  gkNewInstrumentEqBass linseg p4, p3, p5
endin

instr NewInstrumentMidKnob
  gkNewInstrumentEqMid linseg p4, p3, p5
endin

instr NewInstrumentHighKnob
  gkNewInstrumentEqHigh linseg p4, p3, p5
endin

instr NewInstrumentFader
  gkNewInstrumentFader linseg p4, p3, p5
endin

instr NewInstrumentPan
  gkNewInstrumentPan linseg p4, p3, p5
endin

instr NewInstrumentMixerChannel
  aNewInstrumentL inleta "InL"
  aNewInstrumentR inleta "InR"

  aNewInstrumentL, aNewInstrumentR mixerChannel aNewInstrumentL, aNewInstrumentR, gkNewInstrumentFader, gkNewInstrumentPan, gkNewInstrumentEqBass, gkNewInstrumentEqMid, gkNewInstrumentEqHigh

  outleta "OutL", aNewInstrumentL
  outleta "OutR", aNewInstrumentR
endin
