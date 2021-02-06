alwayson "NewInstrumentMixerChannel"

gkNewInstrumentEqBass init 1
gkNewInstrumentEqMid init 1
gkNewInstrumentEqHigh init 1
gkNewInstrumentFader init 1
gkNewInstrumentPan init 50
instrumentRoute "NewInstrument", "Mixer"

gSNewInstrumentSamplePath = "localSamples/Drums/R8-Drums_Crash_E715.wav"
giNewInstrumentSample ftgen 0, 0, 0, 1, gSNewInstrumentSamplePath, 0, 0, 0


instr NewInstrument
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

$MIXER_CHANNEL(NewInstrument)

; #define NEW_INSTRUMENT_GRAIN #
;   kTimeStretch = 8 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
;   kGrainSizeAdjustment = .3 * poscil(.2, .25)
;   kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
;   kPitchAdjustment = 1
;   kGrainOverlapPercentageAdjustment = 1
; #

; $SYNCLOOP_SAMPLER(NewInstrument'NewEffectInput'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop4.wav'$NEW_INSTRUMENT_GRAIN'0)
; $EFFECT_CHAIN(NewInstrumentEffectChain'Mixer)
