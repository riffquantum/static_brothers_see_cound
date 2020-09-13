instrumentRoute "BassTone", "Mixer"
alwayson "BassToneMixerChannel"

gkBassToneEqBass init 1
gkBassToneEqMid init 1
gkBassToneEqHigh init 1
gkBassToneFader init 1
gkBassTonePan init 50

instr BassTone
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5

  iSineTable sineWave
  iSawtooth sawtoothWaveDown
  iSawtoothUp sawtoothWaveUpAndDown
  iSquareWave squareWave

  iAttack = 0.5
  iDecay = 0.01
  iSustain = 0.9
  iRelease = 1
  aAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease)

  ; aTremoloDepth = 0.1
  ; aTremoloRate = 3
  ; aTremolo = (1 - aTremoloDepth) + poscil(aTremoloDepth, aTremoloRate, iSineTable)
  ; aAmplitudeEnvelope *= aTremolo

  aPrimaryOscillator = poscil(iAmplitude*(2/11), iPitch, iSineTable)
  aOctaveDown = poscil(iAmplitude*(4/11), cpspch(pchcps(iPitch) - 1), iSineTable)
  aOctaveDownSquare = poscil(iAmplitude*(1/11), cpspch(pchcps(iPitch) - 1), iSquareWave)
  aTwoOctavesDownSaw = poscil(iAmplitude*(2/11), cpspch(pchcps(iPitch) - 2), iSawtooth)
  aThreeOctavesDownSaw = poscil(iAmplitude*(2/11), cpspch(pchcps(iPitch) - 3), iSawtooth)

  aBassTone = 0
  aBassTone = aPrimaryOscillator
  aBassTone += aOctaveDown
  aBassTone += aOctaveDownSquare
  aBassTone += aTwoOctavesDownSaw
  aBassTone += aThreeOctavesDownSaw


  aBassTone *= aAmplitudeEnvelope
  kHalfPowerPointValue linseg 1500, .25, 150
  kQ linsegr 0.0001, 1, 5.5, .01, 5.5, iRelease, 1
  aBassTone lowpass2 aBassTone, kHalfPowerPointValue, kQ

  aBassTone butterlp aBassTone, 1000

  aBassTone *= (261.1/iPitch)^.25

  outleta "OutL", aBassTone
  outleta "OutR", aBassTone
endin

instr BassToneBassKnob
  gkBassToneEqBass linseg p4, p3, p5
endin

instr BassToneMidKnob
  gkBassToneEqMid linseg p4, p3, p5
endin

instr BassToneHighKnob
  gkBassToneEqHigh linseg p4, p3, p5
endin

instr BassToneFader
  gkBassToneFader linseg p4, p3, p5
endin

instr BassTonePan
  gkBassTonePan linseg p4, p3, p5
endin

instr BassToneMixerChannel
  aBassToneL inleta "InL"
  aBassToneR inleta "InR"

  aBassToneL, aBassToneR mixerChannel aBassToneL, aBassToneR, gkBassToneFader, gkBassTonePan, gkBassToneEqBass, gkBassToneEqMid, gkBassToneEqHigh

  outleta "OutL", aBassToneL
  outleta "OutR", aBassToneR
endin
