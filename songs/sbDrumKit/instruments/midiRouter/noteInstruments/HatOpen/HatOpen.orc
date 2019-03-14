gSMidiNoteSampleList[giHatOpenNote] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giHatOpenNote] filelen gSMidiNoteSampleList[giHatOpenNote]
giMidiNoteInterruptList[giHatOpenNote] ftgen 0, 0, 0, -2, giHatOpenNote

connect "2055", "HatOpenOutL", "HatOpenMixerChannel", "HatOpenInL"
connect "2055", "HatOpenOutR", "HatOpenMixerChannel", "HatOpenInR"

alwayson "HatOpenMixerChannel"

gkHatOpenEqBass init 1
gkHatOpenEqMid init 1
gkHatOpenEqHigh init 1
gkHatOpenFader init 1
gkHatOpenPan init 50

gSHatOpenSample1Path = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giHatOpenSample1TableLength getTableSizeFromSample gSHatOpenSample1Path
giHatOpenSample1 ftgen 0, 0, giHatOpenSample1TableLength, 1, gSHatOpenSample1Path, 0, 0, 0

instr 2055 ;HatOpen, PadA14,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch = 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aHatOpen loscil kAmplitudeEnvelope, kPitch, giHatOpenSample1, 1

  outleta "HatOpenOutL", aHatOpen
  outleta "HatOpenOutR", aHatOpen
endin

instr HatOpenBassKnob
    gkHatOpenEqBass linseg p4, p3, p5
endin

instr HatOpenMidKnob
    gkHatOpenEqMid linseg p4, p3, p5
endin

instr HatOpenHighKnob
    gkHatOpenEqHigh linseg p4, p3, p5
endin

instr HatOpenFader
    gkHatOpenFader linseg p4, p3, p5
endin

instr HatOpenPan
    gkHatOpenPan linseg p4, p3, p5
endin

instr HatOpenMixerChannel
  aHatOpenL inleta "HatOpenInL"
  aHatOpenR inleta "HatOpenInR"

  kHatOpenFader = gkHatOpenFader
  kHatOpenPan = gkHatOpenPan
  kHatOpenEqBass = gkHatOpenEqBass
  kHatOpenEqMid = gkHatOpenEqMid
  kHatOpenEqHigh = gkHatOpenEqHigh

  aHatOpenL, aHatOpenR threeBandEqStereo aHatOpenL, aHatOpenR, kHatOpenEqBass, kHatOpenEqMid, kHatOpenEqHigh

  if kHatOpenPan > 100 then
      kHatOpenPan = 100
  elseif kHatOpenPan < 0 then
      kHatOpenPan = 0
  endif

  aHatOpenL = (aHatOpenL * ((100 - kHatOpenPan) * 2 / 100)) * kHatOpenFader
  aHatOpenR = (aHatOpenR * (kHatOpenPan * 2 / 100)) * kHatOpenFader

  outleta "HatOpenOutL", aHatOpenL
  outleta "HatOpenOutR", aHatOpenR

endin
