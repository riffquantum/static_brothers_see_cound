gSSharpSnareName = "SharpSnare"
gSSharpSnareRoute = "DrumKitBus"
instrumentRoute gSSharpSnareName, gSSharpSnareRoute

alwayson "SharpSnareMixerChannel"

gkSharpSnareEqBass init 1.3
gkSharpSnareEqMid init 1
gkSharpSnareEqHigh init 1
gkSharpSnareFader init 1
gkSharpSnarePan init 50

gSSharpSnareSamplePath ="songs/sbDrumKit/samples/EA7739_R8_Sd.wav"
giSharpSnareSampleTableLength getTableSizeFromSample gSSharpSnareSamplePath
giSharpSnareSample ftgen 0, 0, giSharpSnareSampleTableLength, 1, gSSharpSnareSamplePath, 0, 0, 0

instr SharpSnare
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aSharpSnareSample loscil kAmplitudeEnvelope, 1, giSharpSnareSample, 1

  aSharpSnare = aSharpSnareSample

  outleta "SharpSnareOutL", aSharpSnare
  outleta "SharpSnareOutR", aSharpSnare
endin

instr SharpSnareBassKnob
  gkSharpSnareEqBass linseg p4, p3, p5
endin

instr SharpSnareMidKnob
  gkSharpSnareEqMid linseg p4, p3, p5
endin

instr SharpSnareHighKnob
  gkSharpSnareEqHigh linseg p4, p3, p5
endin

instr SharpSnareFader
  gkSharpSnareFader linseg p4, p3, p5
endin

instr SharpSnarePan
  gkSharpSnarePan linseg p4, p3, p5
endin

instr SharpSnareMixerChannel
  aSharpSnareL inleta "SharpSnareInL"
  aSharpSnareR inleta "SharpSnareInR"

  kSharpSnareFader = gkSharpSnareFader
  kSharpSnarePan = gkSharpSnarePan
  kSharpSnareEqBass = gkSharpSnareEqBass
  kSharpSnareEqMid = gkSharpSnareEqMid
  kSharpSnareEqHigh = gkSharpSnareEqHigh

  aSharpSnareL, aSharpSnareR threeBandEqStereo aSharpSnareL, aSharpSnareR, kSharpSnareEqBass, kSharpSnareEqMid, kSharpSnareEqHigh

  if kSharpSnarePan > 100 then
      kSharpSnarePan = 100
  elseif kSharpSnarePan < 0 then
      kSharpSnarePan = 0
  endif

  aSharpSnareL = (aSharpSnareL * ((100 - kSharpSnarePan) * 2 / 100)) * kSharpSnareFader
  aSharpSnareR = (aSharpSnareR * (kSharpSnarePan * 2 / 100)) * kSharpSnareFader

  outleta "SharpSnareOutL", aSharpSnareL
  outleta "SharpSnareOutR", aSharpSnareR
endin
