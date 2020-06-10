instrumentRoute "DisonantSynth", "MultiStageDistortion"
alwayson "DisonantSynthMixerChannel"

gkDisonantSynthEqBass init 1
gkDisonantSynthEqMid init 1
gkDisonantSynthEqHigh init 1
gkDisonantSynthFader init 1
gkDisonantSynthPan init 50

/* MIDI Config Values */
massign giDisonantSynthMidiChannel, "DisonantSynth"

instr DisonantSynth
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5
  iSineTable sineWave

  kTremolo = .75 + oscil(.25, 1.5, iSineTable)
  kAmplitudeEnvelope = madsr(.005, .01, iAmplitude, .5, 0)
  kAmplitudeEnvelope = kAmplitudeEnvelope * kTremolo

  aDisonantSynthL = oscil(kAmplitudeEnvelope*0.5, iPitch*1.1, iSineTable)
  aDisonantSynthL += oscil(kAmplitudeEnvelope, iPitch*1.1*.5, iSineTable)
  aDisonantSynthL += oscil(kAmplitudeEnvelope*0.25, iPitch*1.1*.9, iSineTable)

  aDisonantSynthR = oscil(kAmplitudeEnvelope*0.5, iPitch*.9, iSineTable)
  aDisonantSynthR += oscil(kAmplitudeEnvelope, iPitch*.9*.5, iSineTable)
  aDisonantSynthR += oscil(kAmplitudeEnvelope*0.25, iPitch*.9*.9, iSineTable)

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
