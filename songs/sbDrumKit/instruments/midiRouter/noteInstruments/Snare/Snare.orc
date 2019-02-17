gSMidiNoteSampleList[giSnareNote] = "songs/sbDrumKit/samples/VA1108_sd.wav"
giMidiNoteDurationList[giSnareNote] filelen gSMidiNoteSampleList[giSnareNote]
giMidiNoteInterruptList[giSnareNote] = 0

connect "2036", "SnareOutL", "SnareMixerChannel", "SnareInL"
connect "2036", "SnareOutR", "SnareMixerChannel", "SnareInR"

alwayson "SnareMixerChannel"

gkSnareEqBass init 1
gkSnareEqMid init 1
gkSnareEqHigh init 1
gkSnareFader init 1
gkSnarePan init 50

gSSnareSample1Path = gSMidiNoteSampleList[giSnareNote]
giSnareSample1TableLength getTableSizeFromSample gSSnareSample1Path
giSnareSample1 ftgen 0, 0, giSnareSample1TableLength, 1, gSSnareSample1Path, 0, 0, 0

instr 2036 ;Snare, PadA2,
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 * 0dbfs
  kPitch =1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aSnare loscil kAmplitudeEnvelope, kPitch, giSnareSample1, 1

  outleta "SnareOutL", aSnare
  outleta "SnareOutR", aSnare
endin

instr SnareBassKnob
    gkSnareEqBass linseg p4, p3, p5
endin

instr SnareMidKnob
    gkSnareEqMid linseg p4, p3, p5
endin

instr SnareHighKnob
    gkSnareEqHigh linseg p4, p3, p5
endin

instr SnareFader
    gkSnareFader linseg p4, p3, p5
endin

instr SnarePan
    gkSnarePan linseg p4, p3, p5
endin

instr SnareMixerChannel
  aSnareL inleta "SnareInL"
  aSnareR inleta "SnareInR"

  kSnareFader = gkSnareFader
  kSnarePan = gkSnarePan
  kSnareEqBass = gkSnareEqBass
  kSnareEqMid = gkSnareEqMid
  kSnareEqHigh = gkSnareEqHigh

  aSnareL, aSnareR threeBandEqStereo aSnareL, aSnareR, kSnareEqBass, kSnareEqMid, kSnareEqHigh

  if kSnarePan > 100 then
      kSnarePan = 100
  elseif kSnarePan < 0 then
      kSnarePan = 0
  endif

  aSnareL = (aSnareL * ((100 - kSnarePan) * 2 / 100)) * kSnareFader
  aSnareR = (aSnareR * (kSnarePan * 2 / 100)) * kSnareFader

  outleta "SnareOutL", aSnareL
  outleta "SnareOutR", aSnareR

endin

