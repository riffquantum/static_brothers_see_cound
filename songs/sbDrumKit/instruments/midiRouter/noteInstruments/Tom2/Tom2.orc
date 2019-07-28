gSMidiNoteSampleList[giTom2Note] = "songs/sbDrumKit/samples/EA7619_R8_Tom.wav"
giMidiNoteDurationList[giTom2Note] filelen gSMidiNoteSampleList[giTom2Note]
giMidiNoteInterruptList[giTom2Note] = 0

connect "2051", "Tom2OutL", "Tom2MixerChannel", "Tom2InL"
connect "2051", "Tom2OutR", "Tom2MixerChannel", "Tom2InR"

alwayson "Tom2MixerChannel"

gkTom2EqBass init 1
gkTom2EqMid init 1
gkTom2EqHigh init 1
gkTom2Fader init 1
gkTom2Pan init 50

gSTom2Sample1Path = gSMidiNoteSampleList[giTom2Note]
giTom2Sample1TableLength getTableSizeFromSample gSTom2Sample1Path
giTom2Sample1 ftgen 0, 0, giTom2Sample1TableLength, 1, gSTom2Sample1Path, 0, 0, 0

instr 2051 ;Tom2, PadA7,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTom2 loscil kAmplitudeEnvelope, kPitch, giTom2Sample1, 1

  outleta "Tom2OutL", aTom2
  outleta "Tom2OutR", aTom2
endin

instr Tom2BassKnob
    gkTom2EqBass linseg p4, p3, p5
endin

instr Tom2MidKnob
    gkTom2EqMid linseg p4, p3, p5
endin

instr Tom2HighKnob
    gkTom2EqHigh linseg p4, p3, p5
endin

instr Tom2Fader
    gkTom2Fader linseg p4, p3, p5
endin

instr Tom2Pan
    gkTom2Pan linseg p4, p3, p5
endin

instr Tom2MixerChannel
  aTom2L inleta "Tom2InL"
  aTom2R inleta "Tom2InR"

  kTom2Fader = gkTom2Fader
  kTom2Pan = gkTom2Pan
  kTom2EqBass = gkTom2EqBass
  kTom2EqMid = gkTom2EqMid
  kTom2EqHigh = gkTom2EqHigh

  aTom2L, aTom2R threeBandEqStereo aTom2L, aTom2R, kTom2EqBass, kTom2EqMid, kTom2EqHigh

  if kTom2Pan > 100 then
      kTom2Pan = 100
  elseif kTom2Pan < 0 then
      kTom2Pan = 0
  endif

  aTom2L = (aTom2L * ((100 - kTom2Pan) * 2 / 100)) * kTom2Fader
  aTom2R = (aTom2R * (kTom2Pan * 2 / 100)) * kTom2Fader

  outleta "Tom2OutL", aTom2L
  outleta "Tom2OutR", aTom2R

endin

