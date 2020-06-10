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
  if p4 != 0 then
    iAmplitude = p4
  else
    iNoteVelocity veloc
    iAmplitude = iNoteVelocity/127 * 0dbfs/10
  endif

  kAmplitudeEnvelope madsr .005, .01, iAmplitude, .05, 0

  if p5 != 0 then
    ifreq = p5
    ifreq = (p5 < 15 ? cpspch(p5) : p5)
  else
    ifreq   cpsmidi
  endif

  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  kfreq   linseg    ifreq*1.02, 0.3, ifreq
  kfreq = kfreq * (1+kPitchBend)

  iSineTable sineWave
  iSawTable sawtoothWaveUpAndDown
  iTriangleTable triangleWave
  iSquareTable squareWave


  aSimpleOscillator1      oscil   kAmplitudeEnvelope,    kfreq,          iSineTable ; main oscillator

  aOut = aSimpleOscillator1

  outleta "OutL", aOut
  outleta "OutR", aOut
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
