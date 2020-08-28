instrumentRoute "BassSynth", "Mixer"
alwayson "BassSynthMixerChannel"

gkBassSynthEqBass init 1
gkBassSynthEqMid init 1
gkBassSynthEqHigh init 1
gkBassSynthFader init 1
gkBassSynthPan init 50

instr BassSynth
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5

  iSineTable sineWave
  iSawtooth sawtoothWaveDown
  iSawtoothUp sawtoothWaveUpAndDown
  iSquareWave squareWave

  iAttack = 0.01
  iDecay = 0.01
  iSustain = 0.9
  iRelease = .08
  aAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease)

  aTremoloDepth = 0.1
  aTremoloRate = 3
  aTremolo = (1 - aTremoloDepth) + poscil(aTremoloDepth, aTremoloRate, iSineTable)
  aAmplitudeEnvelope *= aTremolo

  aPrimaryOscillator = poscil(iAmplitude*(2/11), iPitch, iSineTable)
  aOctaveDown = poscil(iAmplitude*(4/11), cpspch(pchcps(iPitch) - 1), iSineTable)
  aOctaveDownSquare = poscil(iAmplitude*(1/11), cpspch(pchcps(iPitch) - 1), iSquareWave)
  aTwoOctavesDownSaw = poscil(iAmplitude*(2/11), cpspch(pchcps(iPitch) - 2), iSawtooth)
  aThreeOctavesDownSaw = poscil(iAmplitude*(2/11), cpspch(pchcps(iPitch) - 3), iSawtooth)

  aBassSynth = 0
  aBassSynth = aPrimaryOscillator
  aBassSynth += aOctaveDown
  aBassSynth += aOctaveDownSquare
  aBassSynth += aTwoOctavesDownSaw
  aBassSynth += aThreeOctavesDownSaw


  aBassSynth *= aAmplitudeEnvelope
  kHalfPowerPointValue linseg 1500, .25, 150
  kQ linsegr 0.0001, 1, 5.5, .01, 5.5, iRelease, 1
  aBassSynth lowpass2 aBassSynth, kHalfPowerPointValue, kQ

  aBassSynth butterlp aBassSynth, 1000

  aBassSynth *= (261.1/iPitch)^.25

  ;Can I base the filter settings on the pitch to optimize sound at lower pitches?
  ;Also base the amplitude of the partials based on pitch?

  outleta "OutL", aBassSynth
  outleta "OutR", aBassSynth
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
