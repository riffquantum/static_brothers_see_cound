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

$MIXER_CHANNEL(BassPluck)
