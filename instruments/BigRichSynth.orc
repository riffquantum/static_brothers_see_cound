instrumentRoute "BigRichSynth", "Mixer"

instr BigRichSynth
  iAmplitude flexibleAmplitudeInput p4

  kAmplitudeEnvelope = madsr(.005, .01, 1, .05, 0) * iAmplitude

  ifreq flexiblePitchInput p5

  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  kfreq   linseg    ifreq*1.02, 0.3, ifreq
  kfreq = kfreq * (1+kPitchBend)

  iSineTable sineWave
  iSawTable sawtoothWaveUpAndDown
  iTriangleTable triangleWave
  iSquareTable squareWave


  aBigRichSynth1      oscil   kAmplitudeEnvelope,    kfreq,          iSineTable ; main oscillator

  aBigRichSynth2      oscil   kAmplitudeEnvelope/2,   (kfreq * 18),  iSawTable ; chorus oscillator

  aBigRichSynth3      oscil   kAmplitudeEnvelope/3,   (kfreq * 3),  iTriangleTable
  aBigRichSynth4      oscil   kAmplitudeEnvelope/4,   (kfreq * 4),  iSawTable
  aBigRichSynth5      oscil   kAmplitudeEnvelope/5,   (kfreq * 5),  iSineTable
  aBigRichSynth6      oscil   kAmplitudeEnvelope/6,   (kfreq * 6),  iSquareTable
  aBigRichSynth7      oscil   kAmplitudeEnvelope/7,   (kfreq * .3),  iSquareTable
  aBigRichSynth8      oscil   kAmplitudeEnvelope/8,   (kfreq * .9),  iTriangleTable

  aOut = aBigRichSynth1 + aBigRichSynth2 + aBigRichSynth3 + aBigRichSynth4 + aBigRichSynth5 + aBigRichSynth6 + aBigRichSynth7 + aBigRichSynth8

  outleta "OutL", aOut
  outleta "OutR", aOut
endin

$MIXER_CHANNEL(BigRichSynth)
