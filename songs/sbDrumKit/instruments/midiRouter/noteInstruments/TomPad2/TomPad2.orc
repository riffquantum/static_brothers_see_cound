gSMidiNoteSampleList[giTomPad2Note] = "songs/sbDrumKit/samples/EA7617_R8_Tom.wav"
giMidiNoteDurationList[giTomPad2Note] filelen gSMidiNoteSampleList[giTomPad2Note]
giMidiNoteInterruptList[giTomPad2Note] = 0

connect "2046", "TomPad2OutL", "TomPad2MixerChannel", "TomPad2InL"
connect "2046", "TomPad2OutR", "TomPad2MixerChannel", "TomPad2InR"

alwayson "TomPad2MixerChannel"

gkTomPad2EqBass init 1
gkTomPad2EqMid init 1
gkTomPad2EqHigh init 1
gkTomPad2Fader init 1
gkTomPad2Pan init 50

gSTomPad2Sample1Path = gSMidiNoteSampleList[giTomPad2Note]
giTomPad2Sample1TableLength getTableSizeFromSample gSTomPad2Sample1Path
giTomPad2Sample1 ftgen 0, 0, giTomPad2Sample1TableLength, 1, gSTomPad2Sample1Path, 0, 0, 0

instr 2046 ;TomPad2, PadA11,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTomPad2 loscil kAmplitudeEnvelope, kPitch, giTomPad2Sample1, 1

  outleta "TomPad2OutL", aTomPad2
  outleta "TomPad2OutR", aTomPad2
endin

instr TomPad2BassKnob
    gkTomPad2EqBass linseg p4, p3, p5
endin

instr TomPad2MidKnob
    gkTomPad2EqMid linseg p4, p3, p5
endin

instr TomPad2HighKnob
    gkTomPad2EqHigh linseg p4, p3, p5
endin

instr TomPad2Fader
    gkTomPad2Fader linseg p4, p3, p5
endin

instr TomPad2Pan
    gkTomPad2Pan linseg p4, p3, p5
endin

instr TomPad2MixerChannel
  aTomPad2L inleta "TomPad2InL"
  aTomPad2R inleta "TomPad2InR"

  kTomPad2Fader = gkTomPad2Fader
  kTomPad2Pan = gkTomPad2Pan
  kTomPad2EqBass = gkTomPad2EqBass
  kTomPad2EqMid = gkTomPad2EqMid
  kTomPad2EqHigh = gkTomPad2EqHigh

  aTomPad2L, aTomPad2R threeBandEqStereo aTomPad2L, aTomPad2R, kTomPad2EqBass, kTomPad2EqMid, kTomPad2EqHigh

  if kTomPad2Pan > 100 then
      kTomPad2Pan = 100
  elseif kTomPad2Pan < 0 then
      kTomPad2Pan = 0
  endif

  aTomPad2L = (aTomPad2L * ((100 - kTomPad2Pan) * 2 / 100)) * kTomPad2Fader
  aTomPad2R = (aTomPad2R * (kTomPad2Pan * 2 / 100)) * kTomPad2Fader

  outleta "TomPad2OutL", aTomPad2L
  outleta "TomPad2OutR", aTomPad2R

endin

