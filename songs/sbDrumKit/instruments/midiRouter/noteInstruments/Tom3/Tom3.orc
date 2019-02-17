gSMidiNoteSampleList[giTom3Note] = "songs/sbDrumKit/samples/EA7620_R8_Tom.wav"
giMidiNoteDurationList[giTom3Note] filelen gSMidiNoteSampleList[giTom3Note]
giMidiNoteInterruptList[giTom3Note] = 0

connect "2073", "Tom3OutL", "Tom3MixerChannel", "Tom3InL"
connect "2073", "Tom3OutR", "Tom3MixerChannel", "Tom3InR"

alwayson "Tom3MixerChannel"

gkTom3EqBass init 1
gkTom3EqMid init 1
gkTom3EqHigh init 1
gkTom3Fader init 1
gkTom3Pan init 50

gSTom3Sample1Path = gSMidiNoteSampleList[giTom3Note]
giTom3Sample1TableLength getTableSizeFromSample gSTom3Sample1Path
giTom3Sample1 ftgen 0, 0, giTom3Sample1TableLength, 1, gSTom3Sample1Path, 0, 0, 0

instr 2073 ;Tom3, PadB13,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTom3 loscil kAmplitudeEnvelope, kPitch, giTom3Sample1, 1

  outleta "Tom3OutL", aTom3
  outleta "Tom3OutR", aTom3
endin

instr Tom3BassKnob
    gkTom3EqBass linseg p4, p3, p5
endin

instr Tom3MidKnob
    gkTom3EqMid linseg p4, p3, p5
endin

instr Tom3HighKnob
    gkTom3EqHigh linseg p4, p3, p5
endin

instr Tom3Fader
    gkTom3Fader linseg p4, p3, p5
endin

instr Tom3Pan
    gkTom3Pan linseg p4, p3, p5
endin

instr Tom3MixerChannel
  aTom3L inleta "Tom3InL"
  aTom3R inleta "Tom3InR"

  kTom3Fader = gkTom3Fader
  kTom3Pan = gkTom3Pan
  kTom3EqBass = gkTom3EqBass
  kTom3EqMid = gkTom3EqMid
  kTom3EqHigh = gkTom3EqHigh

  aTom3L, aTom3R threeBandEqStereo aTom3L, aTom3R, kTom3EqBass, kTom3EqMid, kTom3EqHigh

  if kTom3Pan > 100 then
      kTom3Pan = 100
  elseif kTom3Pan < 0 then
      kTom3Pan = 0
  endif

  aTom3L = (aTom3L * ((100 - kTom3Pan) * 2 / 100)) * kTom3Fader
  aTom3R = (aTom3R * (kTom3Pan * 2 / 100)) * kTom3Fader

  outleta "Tom3OutL", aTom3L
  outleta "Tom3OutR", aTom3R

endin

