gSPunishYouName = "PunishYou"
gSPunishYouRoute = "Mixer"
instrumentRoute gSPunishYouName, gSPunishYouRoute

alwayson "PunishYouMixerChannel"

gkPunishYouEqBass init 1.3
gkPunishYouEqMid init 1
gkPunishYouEqHigh init 1
gkPunishYouFader init 1
gkPunishYouPan init 50

gSPunishYouSample1Path = "songs/sbDrumKit/samples/punishYou.wav"
giPunishYouSample1TableLength getTableSizeFromSample gSPunishYouSample1Path
giPunishYouSample1 ftgen 0, 0, giPunishYouSample1TableLength, 1, gSPunishYouSample1Path, 0, 0, 0

instr PunishYou
  iAmplitude  = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aPunishYouSample1 loscil kAmplitudeEnvelope, 1, giPunishYouSample1, 1

  aPunishYou = aPunishYouSample1

  outleta "PunishYouOutL", aPunishYou
  outleta "PunishYouOutR", aPunishYou
endin

instr PunishYouBassKnob
  gkPunishYouEqBass linseg p4, p3, p5
endin

instr PunishYouMidKnob
  gkPunishYouEqMid linseg p4, p3, p5
endin

instr PunishYouHighKnob
  gkPunishYouEqHigh linseg p4, p3, p5
endin

instr PunishYouFader
  gkPunishYouFader linseg p4, p3, p5
endin

instr PunishYouPan
  gkPunishYouPan linseg p4, p3, p5
endin

instr PunishYouMixerChannel
  aPunishYouL inleta "PunishYouInL"
  aPunishYouR inleta "PunishYouInR"

  kPunishYouFader = gkPunishYouFader
  kPunishYouPan = gkPunishYouPan
  kPunishYouEqBass = gkPunishYouEqBass
  kPunishYouEqMid = gkPunishYouEqMid
  kPunishYouEqHigh = gkPunishYouEqHigh

  aPunishYouL, aPunishYouR threeBandEqStereo aPunishYouL, aPunishYouR, kPunishYouEqBass, kPunishYouEqMid, kPunishYouEqHigh

  if kPunishYouPan > 100 then
      kPunishYouPan = 100
  elseif kPunishYouPan < 0 then
      kPunishYouPan = 0
  endif

  aPunishYouL = (aPunishYouL * ((100 - kPunishYouPan) * 2 / 100)) * kPunishYouFader
  aPunishYouR = (aPunishYouR * (kPunishYouPan * 2 / 100)) * kPunishYouFader

  outleta "PunishYouOutL", aPunishYouL
  outleta "PunishYouOutR", aPunishYouR
endin
