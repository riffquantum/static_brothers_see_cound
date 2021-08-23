#define LAYERED_BASS_SYNTH_BODY #
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

  aLayeredBassSynth = 0
  aLayeredBassSynth = aPrimaryOscillator
  aLayeredBassSynth += aOctaveDown
  aLayeredBassSynth += aOctaveDownSquare
  aLayeredBassSynth += aTwoOctavesDownSaw
  aLayeredBassSynth += aThreeOctavesDownSaw


  aLayeredBassSynth *= aAmplitudeEnvelope
  kHalfPowerPointValue linseg 1500, .25, 150
  kQ linsegr 0.0001, 1, 5.5, .01, 5.5, iRelease, 1
  aLayeredBassSynth lowpass2 aLayeredBassSynth, kHalfPowerPointValue, kQ

  aLayeredBassSynth butterlp aLayeredBassSynth, 1000

  aLayeredBassSynth *= (261.1/iPitch)^.25

  ;Can I base the filter settings on the pitch to optimize sound at lower pitches?
  ;Also base the amplitude of the partials based on pitch?

  outleta "OutL", aLayeredBassSynth
  outleta "OutR", aLayeredBassSynth
#

$NEW_INSTRUMENT(LayeredBassSynth'LayeredBassSynthFx''$LAYERED_BASS_SYNTH_BODY)
$EFFECT_CHAIN(LayeredBassSynthFx'Mixer)
