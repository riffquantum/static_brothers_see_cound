instrumentRoute "Crash", "DrumKitBus"
alwayson "CrashMixerChannel"

gkCrashEqBass init 1
gkCrashEqMid init 1
gkCrashEqHigh init 1
gkCrashFader init 1.5
gkCrashPan init 50

gSCrashSamplePath = "localSamples/Drums/R8-Drums_Crash_E715.wav"
giCrashSample ftgen 0, 0, 0, 1, gSCrashSamplePath, 0, 0, 0

instr Crash
  aCrashSampleL, aCrashSampleR drumSample giCrashSample, p4, p5

  outleta "OutL", aCrashSampleL
  outleta "OutR", aCrashSampleR
endin

instr CrashBassKnob
  gkCrashEqBass linseg p4, p3, p5
endin

instr CrashMidKnob
  gkCrashEqMid linseg p4, p3, p5
endin

instr CrashHighKnob
  gkCrashEqHigh linseg p4, p3, p5
endin

instr CrashFader
  gkCrashFader linseg p4, p3, p5
endin

instr CrashPan
  gkCrashPan linseg p4, p3, p5
endin

instr CrashMixerChannel
  aCrashL inleta "InL"
  aCrashR inleta "InR"

  aCrashL, aCrashR mixerChannel aCrashL, aCrashR, gkCrashFader, gkCrashPan, gkCrashEqBass, gkCrashEqMid, gkCrashEqHigh

  outleta "OutL", aCrashL
  outleta "OutR", aCrashR
endin
