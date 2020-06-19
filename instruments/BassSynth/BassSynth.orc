instrumentRoute "BassSynth", "WarmDistortionInput"
alwayson "BassSynthMixerChannel"

gkBassSynthEqBass init 1
gkBassSynthEqMid init 1
gkBassSynthEqHigh init 1
gkBassSynthFader init 1
gkBassSynthPan init 50

/* MIDI Config Values */
massign giBassSynthMidiChannel, "BassSynth"

instr BassSynth
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5
  iSineTable sineWave
  iSawtooth sawtoothWaveDown
  iSawtoothUp sawtoothWaveUpAndDown
  iSquareWave squareWave


  iAttack = 0.01
  iDecay = 0.01
  iSustain = iAmplitude
  iRelease = 0.15
  iEnvelopeDelay = 0
  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease, iEnvelopeDelay)

  kTremoloDepth = 0.1
  kTremoloRate = 3
  kTremolo = (1 - kTremoloDepth) + oscil(kTremoloDepth, kTremoloRate, iSineTable)
  kAmplitudeEnvelope = kAmplitudeEnvelope * kTremolo

  aPrimaryOscillator = oscil(kAmplitudeEnvelope*(2/11), iPitch, iSineTable)
  aOctaveDown = oscil(kAmplitudeEnvelope*(4/11), cpspch(pchcps(iPitch) - 1), iSineTable)
  aOctaveDownSquare = oscil(kAmplitudeEnvelope*(1/11), cpspch(pchcps(iPitch) - 1), iSquareWave)
  aTwoOctavesDownSaw = oscil(kAmplitudeEnvelope*(2/11), cpspch(pchcps(iPitch) - 2), iSawtooth)
  aThreeOctavesDownSaw = oscil(kAmplitudeEnvelope*(2/11), cpspch(pchcps(iPitch) - 3), iSawtooth)


  aBassSynthL = aPrimaryOscillator
  aBassSynthL += aOctaveDown
  aBassSynthL += aOctaveDownSquare
  aBassSynthL += aTwoOctavesDownSaw
  aBassSynthL += aThreeOctavesDownSaw

  aPrimaryOscillator *= kAmplitudeEnvelope

  kHalfPowerPointValue linseg 500, .25, 150
  kQ linsegr 0.0001, 1, 5.5, iRelease, 5.5
  aBassSynthL lowpass2 aBassSynthL, kHalfPowerPointValue, kQ

  ; aBassSynthL *= kAmplitudeEnvelope

  ;Can I base the filter settings on the pitch to optimize sound at lower pitches?
  ;Also base the amplitude of the partials based on pitch?

  aBassSynthL balance aBassSynthL, aPrimaryOscillator

  aBassSynthR = aBassSynthL

  outleta "OutL", aBassSynthL
  outleta "OutR", aBassSynthR
endin

instr BassSynthBassKnob
  gkBassSynthEqBass linseg p4, p3, p5
endin

instr BassSynthMidKnob
  gkBassSynthEqMid linseg p4, p3, p5
endin

instr BassSynthHighKnob
  gkBassSynthEqHigh linseg p4, p3, p5
endin

instr BassSynthFader
  gkBassSynthFader linseg p4, p3, p5
endin

instr BassSynthPan
  gkBassSynthPan linseg p4, p3, p5
endin

instr BassSynthMixerChannel
  aBassSynthL inleta "InL"
  aBassSynthR inleta "InR"

  aBassSynthL, aBassSynthR mixerChannel aBassSynthL, aBassSynthR, gkBassSynthFader, gkBassSynthPan, gkBassSynthEqBass, gkBassSynthEqMid, gkBassSynthEqHigh

  outleta "OutL", aBassSynthL
  outleta "OutR", aBassSynthR
endin
