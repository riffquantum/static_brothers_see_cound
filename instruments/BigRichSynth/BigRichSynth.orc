instrumentRoute "BigRichSynth", "Mixer"
alwayson "BigRichSynthMixerChannel"

gkBigRichSynthEqBass init 1
gkBigRichSynthEqMid init 1
gkBigRichSynthEqHigh init 1
gkBigRichSynthFader init 1
gkBigRichSynthPan init 50

massign giBigRichSynthMidiChannel, "BigRichSynth"

instr BigRichSynth
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

instr BigRichSynthBassKnob
  gkBigRichSynthEqBass linseg p4, p3, p5
endin

instr BigRichSynthMidKnob
  gkBigRichSynthEqMid linseg p4, p3, p5
endin

instr BigRichSynthHighKnob
  gkBigRichSynthEqHigh linseg p4, p3, p5
endin

instr BigRichSynthFader
  gkBigRichSynthFader linseg p4, p3, p5
endin

instr BigRichSynthPan
  gkBigRichSynthPan linseg p4, p3, p5
endin

instr BigRichSynthMixerChannel
  aBigRichSynthL inleta "InL"
  aBigRichSynthR inleta "InR"

  aBigRichSynthL, aBigRichSynthR mixerChannel aBigRichSynthL, aBigRichSynthR, gkBigRichSynthFader, gkBigRichSynthPan, gkBigRichSynthEqBass, gkBigRichSynthEqMid, gkBigRichSynthEqHigh

  outleta "OutL", aBigRichSynthL
  outleta "OutR", aBigRichSynthR
endin
