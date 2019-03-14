gSMidiNoteSampleList[giHatClosedNote] = "songs/sbDrumKit/samples/VA2105_hh.wav"
giMidiNoteDurationList[giHatClosedNote] filelen gSMidiNoteSampleList[giHatClosedNote]
giMidiNoteInterruptList[giHatClosedNote] = 0

connect "2047", "HatClosedOutL", "HatClosedMixerChannel", "HatClosedInL"
connect "2047", "HatClosedOutR", "HatClosedMixerChannel", "HatClosedInR"

alwayson "HatClosedMixerChannel"

gkHatClosedEqBass init 1
gkHatClosedEqMid init 1
gkHatClosedEqHigh init 1
gkHatClosedFader init 1
gkHatClosedPan init 50

gSHatClosedSample1Path = "songs/sbDrumKit/samples/VA2105_hh.wav"
giHatClosedSample1TableLength getTableSizeFromSample gSHatClosedSample1Path
giHatClosedSample1 ftgen 0, 0, giHatClosedSample1TableLength, 1, gSHatClosedSample1Path, 0, 0, 0

instr 2047 ;HatClosed, PadA10,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aHatClosed loscil kAmplitudeEnvelope, kPitch, giHatClosedSample1, 1

  outleta "HatClosedOutL", aHatClosed
  outleta "HatClosedOutR", aHatClosed
endin

instr HatClosedBassKnob
    gkHatClosedEqBass linseg p4, p3, p5
endin

instr HatClosedMidKnob
    gkHatClosedEqMid linseg p4, p3, p5
endin

instr HatClosedHighKnob
    gkHatClosedEqHigh linseg p4, p3, p5
endin

instr HatClosedFader
    gkHatClosedFader linseg p4, p3, p5
endin

instr HatClosedPan
    gkHatClosedPan linseg p4, p3, p5
endin

instr HatClosedMixerChannel
  aHatClosedL inleta "HatClosedInL"
  aHatClosedR inleta "HatClosedInR"

  kHatClosedFader = gkHatClosedFader
  kHatClosedPan = gkHatClosedPan
  kHatClosedEqBass = gkHatClosedEqBass
  kHatClosedEqMid = gkHatClosedEqMid
  kHatClosedEqHigh = gkHatClosedEqHigh

  aHatClosedL, aHatClosedR threeBandEqStereo aHatClosedL, aHatClosedR, kHatClosedEqBass, kHatClosedEqMid, kHatClosedEqHigh

  if kHatClosedPan > 100 then
      kHatClosedPan = 100
  elseif kHatClosedPan < 0 then
      kHatClosedPan = 0
  endif

  aHatClosedL = (aHatClosedL * ((100 - kHatClosedPan) * 2 / 100)) * kHatClosedFader
  aHatClosedR = (aHatClosedR * (kHatClosedPan * 2 / 100)) * kHatClosedFader

  outleta "HatClosedOutL", aHatClosedL
  outleta "HatClosedOutR", aHatClosedR

endin

