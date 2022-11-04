gSSimpleOscillatorName = "SimpleOscillator"
gSSimpleOscillatorRoute = "Mixer"
instrumentRoute gSSimpleOscillatorName, gSSimpleOscillatorRoute

instr SimpleOscillator
  iVelocity = p4
  iPitch = p5
  iWaveShape = p6

  iAmplitude flexibleAmplitudeInput iVelocity

  if iAmplitude == 0 then
    goto skipNote
  endif

  kAmplitudeEnvelope = madsr(.005, .01, 1, .05, 0) * iAmplitude

  iFrequency flexiblePitchInput iPitch
  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  kFrequency   linseg    iFrequency*1.02, 0.3, iFrequency
  kFrequency = kFrequency * (1 + kPitchBend)

  if iWaveShape == 0 then
    iWaveTable sineWave
  elseif iWaveShape == 1 then
    iWaveTable sawtoothWaveUpAndDown
  elseif iWaveShape == 2 then
    iWaveTable triangleWave
  elseif iWaveShape == 3 then
    iWaveTable squareWave
  endif

  aSimpleOscillator1 oscil kAmplitudeEnvelope, kFrequency, iWaveTable ; main oscillator

  aOut = aSimpleOscillator1

  outleta "OutL", aSimpleOscillator1
  outleta "OutR", aSimpleOscillator1

  skipNote:
endin

$MIXER_CHANNEL(SimpleOscillator)
