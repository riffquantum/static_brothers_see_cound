gSMidiNoteSampleList[giYellowPadNote] = "songs/sbDrumKit/samples/EA7815_R8_Crsh.wav"
giMidiNoteDurationList[giYellowPadNote] = filelen(gSMidiNoteSampleList[giYellowPadNote]) * 1.6666
giMidiNoteInterruptList[giYellowPadNote] = 0

connect "2051", "YellowPadOutL", "YellowPadMixerChannel", "YellowPadInL"
connect "2051", "YellowPadOutR", "YellowPadMixerChannel", "YellowPadInR"

alwayson "YellowPadMixerChannel"

gkYellowPadEqBass init 1
gkYellowPadEqMid init 1
gkYellowPadEqHigh init 1
gkYellowPadFader init 1
gkYellowPadPan init 50

gSYellowPadSample1Path = gSMidiNoteSampleList[giYellowPadNote]
giYellowPadSample1TableLength getTableSizeFromSample gSYellowPadSample1Path
giYellowPadSample1 ftgen 0, 0, giYellowPadSample1TableLength, 1, gSYellowPadSample1Path, 0, 0, 0

instr 2051 ;YellowPad, Crash, PadA145,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =.6

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aYellowPad1 loscil kAmplitudeEnvelope, 1, giYellowPadSample1, 1
  aYellowPad2 loscil kAmplitudeEnvelope, kPitch, giYellowPadSample1, 1

  aYellowPad = aYellowPad1 + aYellowPad2

  outleta "YellowPadOutL", aYellowPad
  outleta "YellowPadOutR", aYellowPad
endin

instr YellowPadBassKnob
    gkYellowPadEqBass linseg p4, p3, p5
endin

instr YellowPadMidKnob
    gkYellowPadEqMid linseg p4, p3, p5
endin

instr YellowPadHighKnob
    gkYellowPadEqHigh linseg p4, p3, p5
endin

instr YellowPadFader
    gkYellowPadFader linseg p4, p3, p5
endin

instr YellowPadPan
    gkYellowPadPan linseg p4, p3, p5
endin

instr YellowPadMixerChannel
  aYellowPadL inleta "YellowPadInL"
  aYellowPadR inleta "YellowPadInR"

  kYellowPadFader = gkYellowPadFader
  kYellowPadPan = gkYellowPadPan
  kYellowPadEqBass = gkYellowPadEqBass
  kYellowPadEqMid = gkYellowPadEqMid
  kYellowPadEqHigh = gkYellowPadEqHigh

  aYellowPadL, aYellowPadR threeBandEqStereo aYellowPadL, aYellowPadR, kYellowPadEqBass, kYellowPadEqMid, kYellowPadEqHigh

  if kYellowPadPan > 100 then
      kYellowPadPan = 100
  elseif kYellowPadPan < 0 then
      kYellowPadPan = 0
  endif

  aYellowPadL = (aYellowPadL * ((100 - kYellowPadPan) * 2 / 100)) * kYellowPadFader
  aYellowPadR = (aYellowPadR * (kYellowPadPan * 2 / 100)) * kYellowPadFader

  outleta "YellowPadOutL", aYellowPadL
  outleta "YellowPadOutR", aYellowPadR

endin

