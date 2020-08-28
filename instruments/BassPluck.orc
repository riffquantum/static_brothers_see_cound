alwayson "BassPluckMixerChannel"

gkBassPluckEqBass init 1
gkBassPluckEqMid init 1
gkBassPluckEqHigh init 1
gkBassPluckFader init 1
gkBassPluckPan init 50
instrumentRoute "BassPluck", "Mixer"

instr BassPluck
  iAmplitude flexibleAmplitudeInput p4
  iFrequency flexiblePitchInput p5
  ifn init 0
  idecayMethod init 6
  iformat init 0
  iskipinit init 0
  iParam1 = .05
  iParam2 = .02

  iPluckPoint = .05
  kReflectionCoefficient = .5
  kPickupPosition = .05

  aAmplitudeEnvelope madsr .01, .1, .8, .25

  aPlucker = 0
  aPlucker += pluck(iAmplitude, iFrequency, iFrequency, ifn, idecayMethod, iParam1, iParam2)/2
  aPlucker += wgpluck2(iPluckPoint, iAmplitude, iFrequency, kPickupPosition, kReflectionCoefficient)
  aPlucker += poscil(iAmplitude, iFrequency)

  aPlucker butterlp aPlucker, 1000
  aPlucker butterlp aPlucker, 800

  aPlucker *= aAmplitudeEnvelope
  aPlucker *= (261.1/iFrequency)^.25

  outleta "OutL", aPlucker
  outleta "OutR", aPlucker

  skipNote:
endin

instr BassPluckBassKnob
  gkBassPluckEqBass linseg p4, p3, p5
endin

instr BassPluckMidKnob
  gkBassPluckEqMid linseg p4, p3, p5
endin

instr BassPluckHighKnob
  gkBassPluckEqHigh linseg p4, p3, p5
endin

instr BassPluckFader
  gkBassPluckFader linseg p4, p3, p5
endin

instr BassPluckPan
  gkBassPluckPan linseg p4, p3, p5
endin

instr BassPluckMixerChannel
  aBassPluckL inleta "InL"
  aBassPluckR inleta "InR"

  aBassPluckL, aBassPluckR mixerChannel aBassPluckL, aBassPluckR, gkBassPluckFader, gkBassPluckPan, gkBassPluckEqBass, gkBassPluckEqMid, gkBassPluckEqHigh

  outleta "OutL", aBassPluckL
  outleta "OutR", aBassPluckR
endin
