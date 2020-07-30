instrumentRoute "PunishmentAwaits", "Mixer"

alwayson "PunishmentAwaitsMixerChannel"

gkPunishmentAwaitsEqBass init 1.3
gkPunishmentAwaitsEqMid init 1
gkPunishmentAwaitsEqHigh init 1
gkPunishmentAwaitsFader init 1
gkPunishmentAwaitsPan init 50

gSPunishmentAwaitsSample1Path = "localSamples/punishmentAwaits.wav"
giPunishmentAwaitsSample1TableLength getTableSizeFromSample gSPunishmentAwaitsSample1Path
giPunishmentAwaitsSample1 ftgen 0, 0, giPunishmentAwaitsSample1TableLength, 1, gSPunishmentAwaitsSample1Path, 0, 0, 0

instr PunishmentAwaits
  iAmplitude velocityToAmplitude p4

   event_i "i", "PhotoshopSamples", 0, 1, p4, 6

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aPunishmentAwaitsSample1 loscil kAmplitudeEnvelope, 1, giPunishmentAwaitsSample1, 1

  aPunishmentAwaits = aPunishmentAwaitsSample1

  outleta "OutL", aPunishmentAwaits
  outleta "OutR", aPunishmentAwaits
endin

instr PunishmentAwaitsBassKnob
  gkPunishmentAwaitsEqBass linseg p4, p3, p5
endin

instr PunishmentAwaitsMidKnob
  gkPunishmentAwaitsEqMid linseg p4, p3, p5
endin

instr PunishmentAwaitsHighKnob
  gkPunishmentAwaitsEqHigh linseg p4, p3, p5
endin

instr PunishmentAwaitsFader
  gkPunishmentAwaitsFader linseg p4, p3, p5
endin

instr PunishmentAwaitsPan
  gkPunishmentAwaitsPan linseg p4, p3, p5
endin

instr PunishmentAwaitsMixerChannel
  aPunishmentAwaitsL inleta "InL"
  aPunishmentAwaitsR inleta "InR"

  kPunishmentAwaitsFader = gkPunishmentAwaitsFader
  kPunishmentAwaitsPan = gkPunishmentAwaitsPan
  kPunishmentAwaitsEqBass = gkPunishmentAwaitsEqBass
  kPunishmentAwaitsEqMid = gkPunishmentAwaitsEqMid
  kPunishmentAwaitsEqHigh = gkPunishmentAwaitsEqHigh

  aPunishmentAwaitsL, aPunishmentAwaitsR threeBandEqStereo aPunishmentAwaitsL, aPunishmentAwaitsR, kPunishmentAwaitsEqBass, kPunishmentAwaitsEqMid, kPunishmentAwaitsEqHigh

  if kPunishmentAwaitsPan > 100 then
      kPunishmentAwaitsPan = 100
  elseif kPunishmentAwaitsPan < 0 then
      kPunishmentAwaitsPan = 0
  endif

  aPunishmentAwaitsL = (aPunishmentAwaitsL * ((100 - kPunishmentAwaitsPan) * 2 / 100)) * kPunishmentAwaitsFader
  aPunishmentAwaitsR = (aPunishmentAwaitsR * (kPunishmentAwaitsPan * 2 / 100)) * kPunishmentAwaitsFader

  outleta "OutL", aPunishmentAwaitsL
  outleta "OutR", aPunishmentAwaitsR
endin
