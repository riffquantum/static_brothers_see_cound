instrumentRoute "LinnDrumCrash", "LinnDrumKitBus"

alwayson "LinnDrumCrashMixerChannel"

gkLinnDrumCrashEqBass init 1.3
gkLinnDrumCrashEqMid init 1
gkLinnDrumCrashEqHigh init 1
gkLinnDrumCrashFader init 1
gkLinnDrumCrashPan init 60

gSLinnDrumCrashSamplePath = "localSamples/Drums/R8-Drums_Crash_E715.wav"
giLinnDrumCrashSample ftgen 0, 0, 0, 1, gSLinnDrumCrashSamplePath, 0, 0, 0

instr LinnDrumCrash
  aLinnDrumCrashL, aLinnDrumCrashR drumSample giLinnDrumCrashSample, p4, p5

  outleta "OutL", aLinnDrumCrashL
  outleta "OutR", aLinnDrumCrashR
endin

instr LinnDrumCrashBassKnob
  gkLinnDrumCrashEqBass linseg p4, p3, p5
endin

instr LinnDrumCrashMidKnob
  gkLinnDrumCrashEqMid linseg p4, p3, p5
endin

instr LinnDrumCrashHighKnob
  gkLinnDrumCrashEqHigh linseg p4, p3, p5
endin

instr LinnDrumCrashFader
  gkLinnDrumCrashFader linseg p4, p3, p5
endin

instr LinnDrumCrashPan
  gkLinnDrumCrashPan linseg p4, p3, p5
endin

instr LinnDrumCrashMixerChannel
  aLinnDrumCrashL inleta "InL"
  aLinnDrumCrashR inleta "InR"

  aLinnDrumCrashL, aLinnDrumCrashR mixerChannel aLinnDrumCrashL, aLinnDrumCrashR, gkLinnDrumCrashFader, gkLinnDrumCrashPan, gkLinnDrumCrashEqBass, gkLinnDrumCrashEqMid, gkLinnDrumCrashEqHigh

  outleta "OutL", aLinnDrumCrashL
  outleta "OutR", aLinnDrumCrashR
endin
