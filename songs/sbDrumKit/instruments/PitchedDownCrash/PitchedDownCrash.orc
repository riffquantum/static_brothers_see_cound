connect "3012", "PitchedDownCrashOutL", "PitchedDownCrashMixerChannel", "PitchedDownCrashInL"
connect "3012", "PitchedDownCrashOutR", "PitchedDownCrashMixerChannel", "PitchedDownCrashInR"

connect "PitchedDownCrashMixerChannel", "PitchedDownCrashOutL", "Mixer", "MixerInL"
connect "PitchedDownCrashMixerChannel", "PitchedDownCrashOutR", "Mixer", "MixerInR"

alwayson "PitchedDownCrashMixerChannel"

gkPitchedDownCrashEqBass init 1.3
gkPitchedDownCrashEqMid init 1
gkPitchedDownCrashEqHigh init 1
gkPitchedDownCrashFader init 1
gkPitchedDownCrashPan init 50

gSPitchedDownCrashSamplePath ="songs/sbDrumKit/samples/EA7847_R8_Crsh.wav"
giPitchedDownCrashSampleTableLength getTableSizeFromSample gSPitchedDownCrashSamplePath
giPitchedDownCrashSample ftgen 0, 0, giPitchedDownCrashSampleTableLength, 1, gSPitchedDownCrashSamplePath, 0, 0, 0

giPitchedDownCrashInstrumentNumber = 3012

instr 3012 ;PitchedDownCrash
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aPitchedDownCrashSample loscil kAmplitudeEnvelope, 1, giPitchedDownCrashSample, 1


  aPitchedDownCrash = aPitchedDownCrashSample

  outleta "PitchedDownCrashOutL", aPitchedDownCrash
  outleta "PitchedDownCrashOutR", aPitchedDownCrash
endin

instr PitchedDownCrashBassKnob
  gkPitchedDownCrashEqBass linseg p4, p3, p5
endin

instr PitchedDownCrashMidKnob
  gkPitchedDownCrashEqMid linseg p4, p3, p5
endin

instr PitchedDownCrashHighKnob
  gkPitchedDownCrashEqHigh linseg p4, p3, p5
endin

instr PitchedDownCrashFader
  gkPitchedDownCrashFader linseg p4, p3, p5
endin

instr PitchedDownCrashPan
  gkPitchedDownCrashPan linseg p4, p3, p5
endin

instr PitchedDownCrashMixerChannel
  aPitchedDownCrashL inleta "PitchedDownCrashInL"
  aPitchedDownCrashR inleta "PitchedDownCrashInR"

  kPitchedDownCrashFader = gkPitchedDownCrashFader
  kPitchedDownCrashPan = gkPitchedDownCrashPan
  kPitchedDownCrashEqBass = gkPitchedDownCrashEqBass
  kPitchedDownCrashEqMid = gkPitchedDownCrashEqMid
  kPitchedDownCrashEqHigh = gkPitchedDownCrashEqHigh

  aPitchedDownCrashL, aPitchedDownCrashR threeBandEqStereo aPitchedDownCrashL, aPitchedDownCrashR, kPitchedDownCrashEqBass, kPitchedDownCrashEqMid, kPitchedDownCrashEqHigh

  if kPitchedDownCrashPan > 100 then
      kPitchedDownCrashPan = 100
  elseif kPitchedDownCrashPan < 0 then
      kPitchedDownCrashPan = 0
  endif

  aPitchedDownCrashL = (aPitchedDownCrashL * ((100 - kPitchedDownCrashPan) * 2 / 100)) * kPitchedDownCrashFader
  aPitchedDownCrashR = (aPitchedDownCrashR * (kPitchedDownCrashPan * 2 / 100)) * kPitchedDownCrashFader

  outleta "PitchedDownCrashOutL", aPitchedDownCrashL
  outleta "PitchedDownCrashOutR", aPitchedDownCrashR
endin
