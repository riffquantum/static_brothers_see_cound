alwayson "LeadSynthMixerChannel"

gkLeadSynthEqBass init 1
gkLeadSynthEqMid init 1
gkLeadSynthEqHigh init 1
gkLeadSynthFader init 1
gkLeadSynthPan init 50
instrumentRoute "LeadSynth", "RingModForLeadSynthInput"

instr LeadSynth
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

instr LeadSynthBassKnob
  gkLeadSynthEqBass linseg p4, p3, p5
endin

instr LeadSynthMidKnob
  gkLeadSynthEqMid linseg p4, p3, p5
endin

instr LeadSynthHighKnob
  gkLeadSynthEqHigh linseg p4, p3, p5
endin

instr LeadSynthFader
  gkLeadSynthFader linseg p4, p3, p5
endin

instr LeadSynthPan
  gkLeadSynthPan linseg p4, p3, p5
endin

instr LeadSynthMixerChannel
  aLeadSynthL inleta "InL"
  aLeadSynthR inleta "InR"

  aLeadSynthL, aLeadSynthR mixerChannel aLeadSynthL, aLeadSynthR, gkLeadSynthFader, gkLeadSynthPan, gkLeadSynthEqBass, gkLeadSynthEqMid, gkLeadSynthEqHigh

  outleta "OutL", aLeadSynthL
  outleta "OutR", aLeadSynthR
endin
