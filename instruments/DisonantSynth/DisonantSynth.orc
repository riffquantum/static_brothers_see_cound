alwayson "DisonantSynthMixerChannel"

gkDisonantSynthEqBass init 1
gkDisonantSynthEqMid init 1
gkDisonantSynthEqHigh init 1
gkDisonantSynthFader init 1
gkDisonantSynthPan init 50
gSDisonantSynthName = "DisonantSynth"
gSDisonantSynthRoute = "MultiStageDistortion"
instrumentRoute gSDisonantSynthName, gSDisonantSynthRoute



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

  ;aDisonantSynthR = aDisonantSynthL

  outleta "DisonantSynthOutL", aDisonantSynthL
  outleta "DisonantSynthOutR", aDisonantSynthR
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
  aDisonantSynthL inleta "DisonantSynthInL"
  aDisonantSynthR inleta "DisonantSynthInR"

  kDisonantSynthFader = gkDisonantSynthFader
  kDisonantSynthPan = gkDisonantSynthPan
  kDisonantSynthEqBass = gkDisonantSynthEqBass
  kDisonantSynthEqMid = gkDisonantSynthEqMid
  kDisonantSynthEqHigh = gkDisonantSynthEqHigh

  aDisonantSynthL, aDisonantSynthR threeBandEqStereo aDisonantSynthL, aDisonantSynthR, kDisonantSynthEqBass, kDisonantSynthEqMid, kDisonantSynthEqHigh

  if kDisonantSynthPan > 100 then
      kDisonantSynthPan = 100
  elseif kDisonantSynthPan < 0 then
      kDisonantSynthPan = 0
  endif

  aDisonantSynthL = (aDisonantSynthL * ((100 - kDisonantSynthPan) * 2 / 100)) * kDisonantSynthFader
  aDisonantSynthR = (aDisonantSynthR * (kDisonantSynthPan * 2 / 100)) * kDisonantSynthFader

  outleta "DisonantSynthOutL", aDisonantSynthL
  outleta "DisonantSynthOutR", aDisonantSynthR
endin
