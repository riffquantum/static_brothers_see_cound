$MULTI_MODE_REVERB(NewInstrumentReverb'Mixer'Mixer'3)
alwayson "NewInstrumentReverb"

instrumentRoute "NewInstrument", "Mixer"
$MIXER_CHANNEL(NewInstrument)

gkNewInstrumentCenterFrequency init 500
gkNewInstrumentQ init 10
giNewInstrumentWave init sawtoothWaveUpAndDown()
giNewInstrumentAttack init .5
giNewInstrumentDecay init 0.3
giNewInstrumentSustain init 0.8
giNewInstrumentRelease init 0.5
giNewInstrumentFilterExponent init 1
gkNewInstrumentVibratoRate init 1
gkNewInstrumentVibratoPitchAmount init 0.005
gkNewInstrumentVibratoAmplitudeAmount init 0
giNewInstrumentNumberOfVoices init 7

instr NewInstrument
  iAmplitude flexibleAmplitudeInput p4
  iPitch flexiblePitchInput p5

  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15
  kPitch = iPitch * (1 + kPitchBend)

  kEnvelope = madsr(giNewInstrumentAttack, giNewInstrumentDecay, giNewInstrumentSustain, giNewInstrumentRelease)
  kAmplitude = kEnvelope * iAmplitude
  kCenterFrequency = gkNewInstrumentCenterFrequency ;* (kEnvelope^giNewInstrumentFilterExponent)
  kBandwidth = gkNewInstrumentQ ;* (kEnvelope^giNewInstrumentFilterExponent)

  aVibrato = oscil(1, gkNewInstrumentVibratoRate) * kEnvelope
  kPitch += kPitch * ((aVibrato + 1) * gkNewInstrumentVibratoPitchAmount)
  kAmplitude *= 1 - ((aVibrato/2 + .5) * gkNewInstrumentVibratoAmplitudeAmount)

  kDetuneFactor = .005 ;/ random(1, 4)

  aFirstVoice = poscil3(kAmplitude, kPitch, giNewInstrumentWave)
  aSignal = aFirstVoice

  if giNewInstrumentNumberOfVoices > 1 then
    aSignal += poscil3(kAmplitude, kPitch*(1+kDetuneFactor*2), giNewInstrumentWave, random(0, 1))
  endif
  if giNewInstrumentNumberOfVoices > 2 then
    aSignal += poscil3(kAmplitude, kPitch*(1-kDetuneFactor*2), giNewInstrumentWave, random(0, 1))
  endif
  if giNewInstrumentNumberOfVoices > 3 then
    aSignal += poscil3(kAmplitude, kPitch*(1+kDetuneFactor*3), giNewInstrumentWave, random(0, 1))
  endif
  if giNewInstrumentNumberOfVoices > 4 then
    aSignal += poscil3(kAmplitude, kPitch*(1-kDetuneFactor*3), giNewInstrumentWave, random(0, 1))
  endif
  if giNewInstrumentNumberOfVoices > 5 then
    aSignal += poscil3(kAmplitude, kPitch*(1+kDetuneFactor*4), giNewInstrumentWave, random(0, 1))
  endif
  if giNewInstrumentNumberOfVoices > 6 then
    aSignal += poscil3(kAmplitude, kPitch*(1-kDetuneFactor*4), giNewInstrumentWave, random(0, 1))
  endif


  aFilteredSignal = lowpass2( aSignal, kCenterFrequency, kBandwidth)
  aFilteredSignal = butterlp( aSignal, 1500)
  aFilteredSignal = tone( aSignal, 400)
  aFilteredSignal = moogladder( aSignal, 2500, .1)
  ; aFilteredSignal = clfilt(aFilteredSignal, 20, 1, 6, 1, 3)

  ; aSignal = balance(aFilteredSignal, aFirstVoice)

  outleta "OutL", aSignal
  outleta "OutR", aSignal
endin



; $EFFECT_CHAIN(NewInstrumentFx'Mixer)


; #define NEW_INSTRUMENT_GRAIN #
;   kTimeStretch = 8 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
;   kGrainSizeAdjustment = .3 * poscil(.2, .25)
;   kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
;   kPitchAdjustment = 1
;   kGrainOverlapPercentageAdjustment = 1
; #

; $SYNCLOOP_SAMPLER(NewInstrument'NewEffectInput'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop4.wav'$NEW_INSTRUMENT_GRAIN'0)



