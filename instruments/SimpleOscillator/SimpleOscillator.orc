gSSimpleOscillatorName = "SimpleOscillator"
gSSimpleOscillatorRoute = "Mixer"
instrumentRoute gSSimpleOscillatorName, gSSimpleOscillatorRoute

alwayson "SimpleOscillatorMixerChannel"

gkSimpleOscillatorEqBass init 1
gkSimpleOscillatorEqMid init 1
gkSimpleOscillatorEqHigh init 1
gkSimpleOscillatorFader init 1
gkSimpleOscillatorPan init 50

instr SimpleOscillator
  iVelocity = p4
  iPitch = p5
  iWaveShape = p6

  iAmplitude flexibleAmplitudeInput iVelocity

  if iAmplitude == 0 then
    goto skipNote
  endif

  kAmplitudeEnvelope madsr .005, .01, iAmplitude, .05, 0

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

instr SimpleOscillatorBassKnob
  gkSimpleOscillatorEqBass linseg p4, p3, p5
endin

instr SimpleOscillatorMidKnob
  gkSimpleOscillatorEqMid linseg p4, p3, p5
endin

instr SimpleOscillatorHighKnob
  gkSimpleOscillatorEqHigh linseg p4, p3, p5
endin

instr SimpleOscillatorFader
  gkSimpleOscillatorFader linseg p4, p3, p5
endin

instr SimpleOscillatorPan
  gkSimpleOscillatorPan linseg p4, p3, p5
endin

instr SimpleOscillatorMixerChannel
  aSimpleOscillatorL inleta "InL"
  aSimpleOscillatorR inleta "InR"

  aSimpleOscillatorL, aSimpleOscillatorR mixerChannel aSimpleOscillatorL, aSimpleOscillatorR, gkSimpleOscillatorFader, gkSimpleOscillatorPan, gkSimpleOscillatorEqBass, gkSimpleOscillatorEqMid, gkSimpleOscillatorEqHigh

  outleta "OutL", aSimpleOscillatorL
  outleta "OutR", aSimpleOscillatorR
endin
