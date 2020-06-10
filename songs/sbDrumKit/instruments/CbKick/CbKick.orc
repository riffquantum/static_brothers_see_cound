gSCbKickName = "CbKick"
gSCbKickRoute = "KickBus"
instrumentRoute gSCbKickName, gSCbKickRoute

alwayson "CbKickMixerChannel"

gkCbKickEqBass init 1.3
gkCbKickEqMid init 1
gkCbKickEqHigh init 1
gkCbKickFader init 1
gkCbKickPan init 50

gSCbKickSamplePath ="songs/sbDrumKit/instruments/CbKick/CB_Kick.wav"
giCbKickSample ftgen 0, 0, 0, 1, gSCbKickSamplePath, 0, 0, 0

instr CbKick
  iAmplitude = p4
  kPitch linseg (iAmplitude/0dbfs/2 + 1), .5, 1, .1, 1
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aCbKickSample loscil kAmplitudeEnvelope, kPitch, giCbKickSample, 1

  aCbKick = aCbKickSample

  outleta "OutL", aCbKick
  outleta "OutR", aCbKick
endin

instr CbKickBassKnob
  gkCbKickEqBass linseg p4, p3, p5
endin

instr CbKickMidKnob

  gkCbKickEqMid linseg p4, p3, p5
endin

instr CbKickHighKnob
  gkCbKickEqHigh linseg p4, p3, p5
endin

instr CbKickFader
  gkCbKickFader linseg p4, p3, p5
endin

instr CbKickPan
  gkCbKickPan linseg p4, p3, p5
endin

instr CbKickMixerChannel
  aCbKickL inleta "InL"
  aCbKickR inleta "InR"

  aCbKickL, aCbKickR mixerChannel aCbKickL, aCbKickR, gkCbKickFader, gkCbKickPan, gkCbKickEqBass, gkCbKickEqMid, gkCbKickEqHigh

  outleta "OutL", aCbKickL
  outleta "OutR", aCbKickR
endin
