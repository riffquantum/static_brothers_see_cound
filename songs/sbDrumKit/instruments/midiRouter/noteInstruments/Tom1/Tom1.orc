gSMidiNoteSampleList[giTom1Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTom1Note] filelen gSMidiNoteSampleList[giTom1Note]
giMidiNoteInterruptList[giTom1Note] = 0

connect "2045", "Tom1OutL", "Tom1MixerChannel", "Tom1InL"
connect "2045", "Tom1OutR", "Tom1MixerChannel", "Tom1InR"

alwayson "Tom1MixerChannel"

gkTom1EqBass init 1
gkTom1EqMid init 1
gkTom1EqHigh init 1
gkTom1Fader init 1
gkTom1Pan init 50

gSTom1Sample1Path = gSMidiNoteSampleList[giTom1Note]
giTom1Sample1TableLength getTableSizeFromSample gSTom1Sample1Path
giTom1Sample1 ftgen 0, 0, giTom1Sample1TableLength, 1, gSTom1Sample1Path, 0, 0, 0

instr 2045 ;Tom1, PadA11,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTom1 loscil kAmplitudeEnvelope, kPitch, giTom1Sample1, 1

  outleta "Tom1OutL", aTom1
  outleta "Tom1OutR", aTom1
endin

instr Tom1BassKnob
    gkTom1EqBass linseg p4, p3, p5
endin

instr Tom1MidKnob
    gkTom1EqMid linseg p4, p3, p5
endin

instr Tom1HighKnob
    gkTom1EqHigh linseg p4, p3, p5
endin

instr Tom1Fader
    gkTom1Fader linseg p4, p3, p5
endin

instr Tom1Pan
    gkTom1Pan linseg p4, p3, p5
endin

instr Tom1MixerChannel
  aTom1L inleta "Tom1InL"
  aTom1R inleta "Tom1InR"

  kTom1Fader = gkTom1Fader
  kTom1Pan = gkTom1Pan
  kTom1EqBass = gkTom1EqBass
  kTom1EqMid = gkTom1EqMid
  kTom1EqHigh = gkTom1EqHigh

  aTom1L, aTom1R threeBandEqStereo aTom1L, aTom1R, kTom1EqBass, kTom1EqMid, kTom1EqHigh

  if kTom1Pan > 100 then
      kTom1Pan = 100
  elseif kTom1Pan < 0 then
      kTom1Pan = 0
  endif

  aTom1L = (aTom1L * ((100 - kTom1Pan) * 2 / 100)) * kTom1Fader
  aTom1R = (aTom1R * (kTom1Pan * 2 / 100)) * kTom1Fader

  outleta "Tom1OutL", aTom1L
  outleta "Tom1OutR", aTom1R

endin

