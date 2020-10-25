instrumentRoute "DefaultCrash", "DefaultDrumKitBus"

alwayson "DefaultCrashMixerChannel"

gkDefaultCrashEqBass init 1
gkDefaultCrashEqMid init 1
gkDefaultCrashEqHigh init 1
gkDefaultCrashFader init 1
gkDefaultCrashPan init 60

gSDefaultCrashSamplePath = "localSamples/Drums/R8-Drums_Crash_E715.wav"
giDefaultCrashSample ftgen 0, 0, 0, 1, gSDefaultCrashSamplePath, 0, 0, 0

instr DefaultCrash
  aDefaultCrashL, aDefaultCrashR drumSample giDefaultCrashSample, p4, p5

  outleta "OutL", aDefaultCrashL
  outleta "OutR", aDefaultCrashR
endin

instr DefaultCrashBassKnob
  gkDefaultCrashEqBass linseg p4, p3, p5
endin

instr DefaultCrashMidKnob
  gkDefaultCrashEqMid linseg p4, p3, p5
endin

instr DefaultCrashHighKnob
  gkDefaultCrashEqHigh linseg p4, p3, p5
endin

instr DefaultCrashFader
  gkDefaultCrashFader linseg p4, p3, p5
endin

instr DefaultCrashPan
  gkDefaultCrashPan linseg p4, p3, p5
endin

instr DefaultCrashMixerChannel
  aDefaultCrashL inleta "InL"
  aDefaultCrashR inleta "InR"

  aDefaultCrashL, aDefaultCrashR mixerChannel aDefaultCrashL, aDefaultCrashR, gkDefaultCrashFader, gkDefaultCrashPan, gkDefaultCrashEqBass, gkDefaultCrashEqMid, gkDefaultCrashEqHigh

  outleta "OutL", aDefaultCrashL
  outleta "OutR", aDefaultCrashR
endin
