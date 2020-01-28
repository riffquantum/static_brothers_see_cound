; Crash
gSCrashName = "Crash"
gSCrashRoute = "Mixer"
instrumentRoute gSCrashName, gSCrashRoute

alwayson "CrashMixerChannel"

gkCrashEqBass init 1
gkCrashEqMid init 1
gkCrashEqHigh init 1
gkCrashFader init 1
gkCrashPan init 50
gSCrashSamplePath = "localSamples/Drums/Linn-Drum_Crash_1.wav"
gSCrashSamplePath = "localSamples/Drums/R8-Drums_Crash_E74.wav"


giCrashSample ftgen 0, 0, 0, 1, gSCrashSamplePath, 0, 0, 0


instr Crash
  iAmplitude = p4
  kPitch = p5 == 0 ? 1 : p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aCrashOut loscil kAmplitudeEnvelope, kPitch, giCrashSample, 1

  outleta "CrashOutL", aCrashOut
  outleta "CrashOutR", aCrashOut
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
    aCrashL inleta "CrashInL"
    aCrashR inleta "CrashInR"

    kpanvalue linseg 0, 1, 100

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

    ;aCrashL distort1 aCrashL, 2, 1, .01, .01
    ;aCrashR distort1 aCrashR, 2, 1, .01, .01

    aCrashL = (aCrashL * ((100 - kCrashPan) * 2 / 100)) * kCrashFader
    aCrashR = (aCrashR * (kCrashPan * 2 / 100)) * kCrashFader

    outleta "CrashOutL", aCrashL
    outleta "CrashOutR", aCrashR

endin
