connect "3006", "SnareOutL", "SnareMixerChannel", "SnareInL"
connect "3006", "SnareOutR", "SnareMixerChannel", "SnareInR"

connect "SharpSnareMixerChannel", "SharpSnareOutL", "Mixer", "MixerInL"
connect "SharpSnareMixerChannel", "SharpSnareOutR", "Mixer", "MixerInR"

alwayson "SnareMixerChannel"

gkSnareEqBass init 1.3
gkSnareEqMid init 1
gkSnareEqHigh init 1
gkSnareFader init 1
gkSnarePan init 50

gSSnareSamplePath ="songs/sbDrumKit/samples/EA7741_R8_Sd.wav"
giSnareSampleTableLength getTableSizeFromSample gSSnareSamplePath
giSnareSample ftgen 0, 0, giSnareSampleTableLength, 1, gSSnareSamplePath, 0, 0, 0

giSnareInstrumentNumber = 3006

instr 3006 ;Snare
  iNoteVelocity = p4
  iAmplitude = iNoteVelocity/127 ;* 0dbfs
  kPitch linseg (iNoteVelocity/127/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aSnareSample loscil kAmplitudeEnvelope, 1, giSnareSample, 1


  aSnare = aSnareSample

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
