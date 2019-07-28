gSMidiNoteSampleList[giTomPad1Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTomPad1Note] filelen gSMidiNoteSampleList[giTomPad1Note]
giMidiNoteInterruptList[giTomPad1Note] = 0

connect "2054", "TomPad1OutL", "TomPad1MixerChannel", "TomPad1InL"
connect "2054", "TomPad1OutR", "TomPad1MixerChannel", "TomPad1InR"

alwayson "TomPad1MixerChannel"

gkTomPad1EqBass init 1
gkTomPad1EqMid init 1
gkTomPad1EqHigh init 1
gkTomPad1Fader init 1
gkTomPad1Pan init 50

gSTomPad1Sample1Path = gSMidiNoteSampleList[giTomPad1Note]
giTomPad1Sample1TableLength getTableSizeFromSample gSTomPad1Sample1Path
giTomPad1Sample1 ftgen 0, 0, giTomPad1Sample1TableLength, 1, gSTomPad1Sample1Path, 0, 0, 0

instr 2054 ;TomPad1, PadA11,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTomPad1 loscil kAmplitudeEnvelope, kPitch, giTomPad1Sample1, 1

  outleta "TomPad1OutL", aTomPad1
  outleta "TomPad1OutR", aTomPad1
endin

instr TomPad1BassKnob
    gkTomPad1EqBass linseg p4, p3, p5
endin

instr TomPad1MidKnob
    gkTomPad1EqMid linseg p4, p3, p5
endin

instr TomPad1HighKnob
    gkTomPad1EqHigh linseg p4, p3, p5
endin

instr TomPad1Fader
    gkTomPad1Fader linseg p4, p3, p5
endin

instr TomPad1Pan
    gkTomPad1Pan linseg p4, p3, p5
endin

instr TomPad1MixerChannel
  aTomPad1L inleta "TomPad1InL"
  aTomPad1R inleta "TomPad1InR"

  kTomPad1Fader = gkTomPad1Fader
  kTomPad1Pan = gkTomPad1Pan
  kTomPad1EqBass = gkTomPad1EqBass
  kTomPad1EqMid = gkTomPad1EqMid
  kTomPad1EqHigh = gkTomPad1EqHigh

  aTomPad1L, aTomPad1R threeBandEqStereo aTomPad1L, aTomPad1R, kTomPad1EqBass, kTomPad1EqMid, kTomPad1EqHigh

  if kTomPad1Pan > 100 then
      kTomPad1Pan = 100
  elseif kTomPad1Pan < 0 then
      kTomPad1Pan = 0
  endif

  aTomPad1L = (aTomPad1L * ((100 - kTomPad1Pan) * 2 / 100)) * kTomPad1Fader
  aTomPad1R = (aTomPad1R * (kTomPad1Pan * 2 / 100)) * kTomPad1Fader

  outleta "TomPad1OutL", aTomPad1L
  outleta "TomPad1OutR", aTomPad1R

endin

