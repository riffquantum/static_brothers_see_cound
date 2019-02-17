gSMidiNoteSampleList[giKickNote] = "songs/sbDrumKit/samples/EA7604_R8_Bd.wav"
giMidiNoteDurationList[giKickNote] filelen gSMidiNoteSampleList[giKickNote]
giMidiNoteInterruptList[giKickNote] ftgen 0, 0, 0, -2, giKickNote

connect "2082", "KickOutL", "KickMixerChannel", "KickInL"
connect "2082", "KickOutR", "KickMixerChannel", "KickInR"

alwayson "KickMixerChannel"

gkKickEqBass init 1.3
gkKickEqMid init 1
gkKickEqHigh init 1
gkKickFader init 1
gkKickPan init 50

gSKickSample1Path = "songs/sbDrumKit/samples/EA7604_R8_Bd.wav"
giKickSample1TableLength getTableSizeFromSample gSKickSample1Path
giKickSample1 ftgen 0, 0, giKickSample1TableLength, 1, gSKickSample1Path, 0, 0, 0

gSKickSample2Path ="localSamples/CB_Kick.wav"
giKickSample2TableLength getTableSizeFromSample gSKickSample2Path
giKickSample2 ftgen 0, 0, giKickSample2TableLength, 1, gSKickSample2Path, 0, 0, 0

instr 2082 ;Kick, PadB9,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aKickSample1 loscil kAmplitudeEnvelope, kPitch, giKickSample1, 1
  aKickSample2 loscil kAmplitudeEnvelope, kPitch, giKickSample2, 1

  aKick = aKickSample1 + aKickSample2

  outleta "KickOutL", aKick
  outleta "KickOutR", aKick
endin

instr KickBassKnob
  gkKickEqBass linseg p4, p3, p5
endin

instr KickMidKnob
  gkKickEqMid linseg p4, p3, p5
endin

instr KickHighKnob
  gkKickEqHigh linseg p4, p3, p5
endin

instr KickFader
  gkKickFader linseg p4, p3, p5
endin

instr KickPan
  gkKickPan linseg p4, p3, p5
endin

instr KickMixerChannel
  aKickL inleta "KickInL"
  aKickR inleta "KickInR"

  kKickFader = gkKickFader
  kKickPan = gkKickPan
  kKickEqBass = gkKickEqBass
  kKickEqMid = gkKickEqMid
  kKickEqHigh = gkKickEqHigh

  aKickL, aKickR threeBandEqStereo aKickL, aKickR, kKickEqBass, kKickEqMid, kKickEqHigh

  if kKickPan > 100 then
      kKickPan = 100
  elseif kKickPan < 0 then
      kKickPan = 0
  endif

  aKickL = (aKickL * ((100 - kKickPan) * 2 / 100)) * kKickFader
  aKickR = (aKickR * (kKickPan * 2 / 100)) * kKickFader

  outleta "KickOutL", aKickL
  outleta "KickOutR", aKickR
endin
