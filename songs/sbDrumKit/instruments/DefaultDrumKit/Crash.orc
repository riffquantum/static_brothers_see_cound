gSCrashName = "Crash"
gSCrashRoute = "DrumKitBus"
instrumentRoute gSCrashName, gSCrashRoute


alwayson "CrashMixerChannel"

gkCrashEqBass init 1.3
gkCrashEqMid init 1
gkCrashEqHigh init 1
gkCrashFader init 1
gkCrashPan init 50

gSCrashSamplePath ="songs/sbDrumKit/samples/EA7847_R8_Crsh.wav"
giCrashSampleTableLength getTableSizeFromSample gSCrashSamplePath
giCrashSample ftgen 0, 0, giCrashSampleTableLength, 1, gSCrashSamplePath, 0, 0, 0

instr Crash
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aCrashSample loscil kAmplitudeEnvelope, 1, giCrashSample, 1

  aCrash = aCrashSample

  outleta "OutL", aCrash
  outleta "OutR", aCrash
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

  kCrashFader = gkCrashFader
  kCrashPan = gkCrashPan
  kCrashEqBass = gkCrashEqBass
  kCrashEqMid = gkCrashEqMid
  kCrashEqHigh = gkCrashEqHigh

  aCrashL, aCrashR threeBandEqStereo aCrashL, aCrashR, kCrashEqBass, kCrashEqMid, kCrashEqHigh

  if kCrashPan > 100 then
      kCrashPan = 100
  elseif kCrashPan < 0 then
      kCrashPan = 0
  endif

  aCrashL = (aCrashL * ((100 - kCrashPan) * 2 / 100)) * kCrashFader
  aCrashR = (aCrashR * (kCrashPan * 2 / 100)) * kCrashFader

  outleta "OutL", aCrashL
  outleta "OutR", aCrashR
endin
