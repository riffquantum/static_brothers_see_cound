gSMidiNoteSampleList[giCrashNote] = "songs/sbDrumKit/samples/EA7815_R8_Crsh.wav"
giMidiNoteDurationList[giCrashNote] = filelen(gSMidiNoteSampleList[giCrashNote]) * 1.6666
giMidiNoteInterruptList[giCrashNote] = 0

connect "2073", "CrashOutL", "CrashMixerChannel", "CrashInL"
connect "2073", "CrashOutR", "CrashMixerChannel", "CrashInR"

alwayson "CrashMixerChannel"

gkCrashEqBass init 1
gkCrashEqMid init 1
gkCrashEqHigh init 1
gkCrashFader init 1
gkCrashPan init 50

gSCrashSample1Path = gSMidiNoteSampleList[giCrashNote]
giCrashSample1TableLength getTableSizeFromSample gSCrashSample1Path
giCrashSample1 ftgen 0, 0, giCrashSample1TableLength, 1, gSCrashSample1Path, 0, 0, 0

instr 2073 ;Crash, Crash, PadA145,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =.6

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aCrash1 loscil kAmplitudeEnvelope, 1, giCrashSample1, 1
  aCrash2 loscil kAmplitudeEnvelope, kPitch, giCrashSample1, 1

  aCrash = aCrash1 + aCrash2

  outleta "CrashOutL", aCrash
  outleta "CrashOutR", aCrash
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

  outleta "CrashOutL", aCrashL
  outleta "CrashOutR", aCrashR

endin

