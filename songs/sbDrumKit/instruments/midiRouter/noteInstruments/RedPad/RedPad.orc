gSMidiNoteSampleList[giRedPadNote] = "localSamples/dissonantStab.wav"
giMidiNoteDurationList[giRedPadNote] filelen gSMidiNoteSampleList[giRedPadNote]
giMidiNoteInterruptList[giRedPadNote] = 0

connect "2038", "RedPadOutL", "RedPadMixerChannel", "RedPadInL"
connect "2038", "RedPadOutR", "RedPadMixerChannel", "RedPadInR"

alwayson "RedPadMixerChannel"

gkRedPadEqBass init 1
gkRedPadEqMid init 1
gkRedPadEqHigh init 1
gkRedPadFader init 1
gkRedPadPan init 50

gSRedPadSample1Path = gSMidiNoteSampleList[giRedPadNote]
giRedPadSample1TableLength getTableSizeFromSample gSRedPadSample1Path
giRedPadSample1 ftgen 0, 0, giRedPadSample1TableLength, 1, gSRedPadSample1Path, 0, 0, 0

instr 2038 ;RedPad, PadA6,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aRedPadL, aRedPadR loscil kAmplitudeEnvelope, kPitch, giRedPadSample1, 1

  outleta "RedPadOutL", aRedPadL
  outleta "RedPadOutR", aRedPadR
endin

instr RedPadBassKnob
    gkRedPadEqBass linseg p4, p3, p5
endin

instr RedPadMidKnob
    gkRedPadEqMid linseg p4, p3, p5
endin

instr RedPadHighKnob
    gkRedPadEqHigh linseg p4, p3, p5
endin

instr RedPadFader
    gkRedPadFader linseg p4, p3, p5
endin

instr RedPadPan
    gkRedPadPan linseg p4, p3, p5
endin

instr RedPadMixerChannel
  aRedPadL inleta "RedPadInL"
  aRedPadR inleta "RedPadInR"

  kRedPadFader = gkRedPadFader
  kRedPadPan = gkRedPadPan
  kRedPadEqBass = gkRedPadEqBass
  kRedPadEqMid = gkRedPadEqMid
  kRedPadEqHigh = gkRedPadEqHigh

  aRedPadL, aRedPadR threeBandEqStereo aRedPadL, aRedPadR, kRedPadEqBass, kRedPadEqMid, kRedPadEqHigh

  if kRedPadPan > 100 then
      kRedPadPan = 100
  elseif kRedPadPan < 0 then
      kRedPadPan = 0
  endif

  aRedPadL = (aRedPadL * ((100 - kRedPadPan) * 2 / 100)) * kRedPadFader
  aRedPadR = (aRedPadR * (kRedPadPan * 2 / 100)) * kRedPadFader

  outleta "RedPadOutL", aRedPadL
  outleta "RedPadOutR", aRedPadR

endin

