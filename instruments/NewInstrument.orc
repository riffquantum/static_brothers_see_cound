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

  kMod1 = 2
  kV1 = 80
  kCross = 4
  kV2 = 10
  kLFO = 11
  kV3 = 100
  kLFODepth = 1
  kD4 = 3
  kADSR = 128
  kV5 = 80

  ; aSignalL STKRhodey iFrequency, iAmplitude, kMod1, kV1, kCross, kV2, kLFO, kV3, kLFODepth, kD4, kADSR, kV5

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
