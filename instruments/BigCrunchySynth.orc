instrumentRoute "BigCrunchySynth", "Mixer"

instr BigCrunchySynth
  iAmplitude flexibleAmplitudeInput p4
  kAmplitudeEnvelope = madsr(.005, .01, 1, .5, 0) * iAmplitude

  ifreq flexiblePitchInput p5
  kfreq   linseg    ifreq*1.02, 0.3, ifreq
  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15
  kfreq = kfreq * (1+kPitchBend)

  iSineTable sineWave
  iSawTable sawtoothWaveUpAndDown
  iTriangleTable triangleWave
  iSquareTable squareWave


  aBigCrunchySynth1      oscil   kAmplitudeEnvelope,    kfreq,          iSineTable ; main oscillator

  aBigCrunchySynth2      oscil   kAmplitudeEnvelope/2,   (kfreq * 18),  iSawTable ; chorus oscillator

  aBigCrunchySynth3      oscil   kAmplitudeEnvelope/3,   (kfreq * 3),  iTriangleTable
  aBigCrunchySynth4      oscil   kAmplitudeEnvelope/4,   (kfreq * 4),  iSawTable
  aBigCrunchySynth5      oscil   kAmplitudeEnvelope/5,   (kfreq * 5),  iSineTable
  aBigCrunchySynth6      oscil   kAmplitudeEnvelope/6,   (kfreq * 6),  iSquareTable
  aBigCrunchySynth7      oscil   kAmplitudeEnvelope/7,   (kfreq * .3),  iSquareTable
  aBigCrunchySynth8      oscil   kAmplitudeEnvelope/8,   (kfreq * .9),  iTriangleTable

  aOut = aBigCrunchySynth1 + aBigCrunchySynth2 + aBigCrunchySynth3 + aBigCrunchySynth4 + aBigCrunchySynth5 + aBigCrunchySynth6 + aBigCrunchySynth7 + aBigCrunchySynth8

  kCenterFrequency line 1000, 1, 0
  kCenterFrequency = kCenterFrequency * ( 1 + oscil(.25, .25, iSineTable))
  kBandWidth = 700
  aOutCrunch reson aOut, kCenterFrequency, kBandWidth

  aOutBalanced balance aOutCrunch, aOut

  outleta "OutL", aOutBalanced
  outleta "OutR", aOutBalanced
endin

$MIXER_CHANNEL(BigCrunchySynth)
