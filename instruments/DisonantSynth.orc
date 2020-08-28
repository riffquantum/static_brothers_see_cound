instrumentRoute "DisonantSynth", "Mixer"
alwayson "DisonantSynthMixerChannel"

gkDisonantSynthEqBass init 1
gkDisonantSynthEqMid init 1
gkDisonantSynthEqHigh init 1
gkDisonantSynthFader init 1
gkDisonantSynthPan init 50

instr DisonantSynth
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5
  iWaveTable sineWave

  kTremolo = .75 + oscil(.25, 1.5)
  aAmplitudeEnvelope = madsr(.005, .01, 1, .5, 0)
  aAmplitudeEnvelope = aAmplitudeEnvelope * kTremolo

  aDisonantSynthL = oscil(iAmplitude * (2/7), iPitch*1.1, iWaveTable)
  aDisonantSynthL += oscil(iAmplitude * (4/7), iPitch*1.1*.5, iWaveTable)
  aDisonantSynthL += oscil(iAmplitude * (1/7), iPitch*1.1*.9, iWaveTable)

  aDisonantSynthR = oscil(iAmplitude * (2/7), iPitch*.9, iWaveTable)
  aDisonantSynthR += oscil(iAmplitude * (4/7), iPitch*.9*.5, iWaveTable)
  aDisonantSynthR += oscil(iAmplitude * (1/7), iPitch*.9*.9, iWaveTable)

  aDisonantSynthL *= aAmplitudeEnvelope
  aDisonantSynthR *= aAmplitudeEnvelope

  outleta "OutL", aDisonantSynthL
  outleta "OutR", aDisonantSynthR
endin

instr DisonantSynthBassKnob
  gkDisonantSynthEqBass linseg p4, p3, p5
endin

instr DisonantSynthMidKnob
  gkDisonantSynthEqMid linseg p4, p3, p5
endin

instr DisonantSynthHighKnob
  gkDisonantSynthEqHigh linseg p4, p3, p5
endin

instr DisonantSynthFader
  gkDisonantSynthFader linseg p4, p3, p5
endin

instr DisonantSynthPan
  gkDisonantSynthPan linseg p4, p3, p5
endin

instr DisonantSynthMixerChannel
  aDisonantSynthL inleta "InL"
  aDisonantSynthR inleta "InR"

  aDisonantSynthL, aDisonantSynthR mixerChannel aDisonantSynthL, aDisonantSynthR, gkDisonantSynthFader, gkDisonantSynthPan, gkDisonantSynthEqBass, gkDisonantSynthEqMid, gkDisonantSynthEqHigh

  outleta "OutL", aDisonantSynthL
  outleta "OutR", aDisonantSynthR
endin
