gSMidiNoteSampleList[giGreenPadNote] = "localSamples/sinkingPianoStab.wav"
giMidiNoteDurationList[giGreenPadNote] = filelen(gSMidiNoteSampleList[giGreenPadNote]) - .75
giMidiNoteInterruptList[giGreenPadNote] ftgen 0, 0, 0, -2, giGreenPadNote

connect "2044", "GreenPadOutL", "GreenPadMixerChannel", "GreenPadInL"
connect "2044", "GreenPadOutR", "GreenPadMixerChannel", "GreenPadInR"

alwayson "GreenPadMixerChannel"

gkGreenPadEqBass init 1
gkGreenPadEqMid init 1
gkGreenPadEqHigh init 1
gkGreenPadFader init 1
gkGreenPadPan init 50

gSGreenPadSample1Path = gSMidiNoteSampleList[giGreenPadNote]
giGreenPadSample1TableLength getTableSizeFromSample gSGreenPadSample1Path
giGreenPadSample1 ftgen 0, 0, giGreenPadSample1TableLength, 1, gSGreenPadSample1Path, 0, 0, 0

instr 2044 ;GreenPad, PadA8,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aGreenPadL, aGreenPadR loscil kAmplitudeEnvelope, kPitch, giGreenPadSample1, 1

  event_i "i", "BigSynth", 0, giMidiNoteDurationList[giGreenPadNote], iNoteVelocity*2, 4.07

  ;outleta "GreenPadOutL", aGreenPadL
  ;outleta "GreenPadOutR", aGreenPadR
endin

instr GreenPadBassKnob
    gkGreenPadEqBass linseg p4, p3, p5
endin

instr GreenPadMidKnob
    gkGreenPadEqMid linseg p4, p3, p5
endin

instr GreenPadHighKnob
    gkGreenPadEqHigh linseg p4, p3, p5
endin

instr GreenPadFader
    gkGreenPadFader linseg p4, p3, p5
endin

instr GreenPadPan
    gkGreenPadPan linseg p4, p3, p5
endin

instr GreenPadMixerChannel
  aGreenPadL inleta "GreenPadInL"
  aGreenPadR inleta "GreenPadInR"

  kGreenPadFader = gkGreenPadFader
  kGreenPadPan = gkGreenPadPan
  kGreenPadEqBass = gkGreenPadEqBass
  kGreenPadEqMid = gkGreenPadEqMid
  kGreenPadEqHigh = gkGreenPadEqHigh

  aGreenPadL, aGreenPadR threeBandEqStereo aGreenPadL, aGreenPadR, kGreenPadEqBass, kGreenPadEqMid, kGreenPadEqHigh

  if kGreenPadPan > 100 then
      kGreenPadPan = 100
  elseif kGreenPadPan < 0 then
      kGreenPadPan = 0
  endif

  aGreenPadL = (aGreenPadL * ((100 - kGreenPadPan) * 2 / 100)) * kGreenPadFader
  aGreenPadR = (aGreenPadR * (kGreenPadPan * 2 / 100)) * kGreenPadFader

  outleta "GreenPadOutL", aGreenPadL
  outleta "GreenPadOutR", aGreenPadR

endin

