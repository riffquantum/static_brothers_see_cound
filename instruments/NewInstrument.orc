alwayson "NewInstrumentMixerChannel"

gkNewInstrumentEqBass init 1
gkNewInstrumentEqMid init 1
gkNewInstrumentEqHigh init 1
gkNewInstrumentFader init 1
gkNewInstrumentPan init 50
instrumentRoute "NewInstrument", "NewEffectInput"

gSNewInstrumentSamplePath = "localSamples/Drums/R8-Drums_Crash_E715.wav"
giNewInstrumentSample ftgen 0, 0, 0, 1, gSNewInstrumentSamplePath, 0, 0, 0


instr NewInstrument
  ; iAmplitude flexibleAmplitudeInput p4
  ; iFrequency flexiblePitchInput p5

  ; aAmplitudeEnvelope madsr .01, .01, 1, .01
  ; aSignalL = 0


  ; print iAmplitude
  ; aSignalL *= aAmplitudeEnvelope
  ; aSignalR *= aAmplitudeEnvelope

  aDefaultCrashL, aDefaultCrashR drumSample giNewInstrumentSample, p4, p5

  outleta "OutL", aDefaultCrashL
  outleta "OutR", aDefaultCrashR
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
