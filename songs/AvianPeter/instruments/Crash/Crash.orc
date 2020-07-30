stereoRoute "CrashMixerChannel", "DrumKitBus"
alwayson "CrashMixerChannel"

gkCrashEqBass init 1
gkCrashEqMid init 1
gkCrashEqHigh init 1
gkCrashFader init .75
gkCrashPan init 50

instr Crash
  iSupressNoise = p6

  event_i "i", "DefaultCrash", 0, p3, p4, p5

  if iSupressNoise == 0 then
    event_i "i", "PhotoshopSamples", 0, 1, p4, 1
  endif
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
