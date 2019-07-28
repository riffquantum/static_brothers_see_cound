gSMidiNoteSampleList[giBluePadNote] = "localSamples/chorusedGuitarStab.wav"
giMidiNoteDurationList[giBluePadNote] filelen gSMidiNoteSampleList[giBluePadNote]
giMidiNoteInterruptList[giBluePadNote] = 0

connect "2045", "BluePadOutL", "BluePadMixerChannel", "BluePadInL"
connect "2045", "BluePadOutR", "BluePadMixerChannel", "BluePadInR"

alwayson "BluePadMixerChannel"

gkBluePadEqBass init 1
gkBluePadEqMid init 1
gkBluePadEqHigh init 1
gkBluePadFader init 1
gkBluePadPan init 50

gSBluePadSample1Path = gSMidiNoteSampleList[giBluePadNote]
giBluePadSample1TableLength getTableSizeFromSample gSBluePadSample1Path
giBluePadSample1 ftgen 0, 0, giBluePadSample1TableLength, 1, gSBluePadSample1Path, 0, 0, 0

instr 2045 ;BluePad, PadB1,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aBluePadL, aBluePadR loscil kAmplitudeEnvelope, kPitch, giBluePadSample1, 1

  outleta "BluePadOutL", aBluePadL
  outleta "BluePadOutR", aBluePadR
endin

instr BluePadBassKnob
    gkBluePadEqBass linseg p4, p3, p5
endin

instr BluePadMidKnob
    gkBluePadEqMid linseg p4, p3, p5
endin

instr BluePadHighKnob
    gkBluePadEqHigh linseg p4, p3, p5
endin

instr BluePadFader
    gkBluePadFader linseg p4, p3, p5
endin

instr BluePadPan
    gkBluePadPan linseg p4, p3, p5
endin

instr BluePadMixerChannel
  aBluePadL inleta "BluePadInL"
  aBluePadR inleta "BluePadInR"

  kBluePadFader = gkBluePadFader
  kBluePadPan = gkBluePadPan
  kBluePadEqBass = gkBluePadEqBass
  kBluePadEqMid = gkBluePadEqMid
  kBluePadEqHigh = gkBluePadEqHigh

  aBluePadL, aBluePadR threeBandEqStereo aBluePadL, aBluePadR, kBluePadEqBass, kBluePadEqMid, kBluePadEqHigh

  if kBluePadPan > 100 then
      kBluePadPan = 100
  elseif kBluePadPan < 0 then
      kBluePadPan = 0
  endif

  aBluePadL = (aBluePadL * ((100 - kBluePadPan) * 2 / 100)) * kBluePadFader
  aBluePadR = (aBluePadR * (kBluePadPan * 2 / 100)) * kBluePadFader

  outleta "BluePadOutL", aBluePadL
  outleta "BluePadOutR", aBluePadR

endin

