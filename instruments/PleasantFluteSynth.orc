instrumentRoute "PleasantFluteSynth", "Mixer"

instr PleasantFluteSynth
  iAmplitude flexibleAmplitudeInput  p4
  iFrequency flexiblePitchInput p5

  aOut = 0

  if iAmplitude == 0 then
    goto skipNote
  endif

  iAttack = .1
  iDecay = .1
  iSustain = .5
  iRelease = .25

  kAmplitudeEnvelope = madsr(iAttack, iDecay, iSustain, iRelease) * iAmplitude

  kPitchBend = 0
  midipitchbend kPitchBend, 0, 15

  kFrequency   linseg    iFrequency*.98, iAttack, iFrequency*1.03, iDecay, iFrequency

  kFrequency = kFrequency * (1 + kPitchBend)

  kFrequency *= 1 + oscil(linseg(0, iAttack+iDecay+1, 0, 3, .02), 4)

  iWaveTable sineWave

  aOscillator1 oscil kAmplitudeEnvelope, kFrequency, iWaveTable

  aOut += aOscillator1

  aOut *= (261.1/iFrequency)^.25


  outleta "OutL", aOut
  outleta "OutR", aOut

  skipNote:
endin

$MIXER_CHANNEL(PleasantFluteSynth)
