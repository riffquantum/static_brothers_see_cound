instrumentRoute "PleasantFluteSynth", "k35LowPassFilterInput"
alwayson "PleasantFluteSynthMixerChannel"

gkPleasantFluteSynthEqBass init 1
gkPleasantFluteSynthEqMid init 1
gkPleasantFluteSynthEqHigh init 1
gkPleasantFluteSynthFader init 1
gkPleasantFluteSynthPan init 50

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

instr PleasantFluteSynthBassKnob
  gkPleasantFluteSynthEqBass linseg p4, p3, p5
endin

instr PleasantFluteSynthMidKnob
  gkPleasantFluteSynthEqMid linseg p4, p3, p5
endin

instr PleasantFluteSynthHighKnob
  gkPleasantFluteSynthEqHigh linseg p4, p3, p5
endin

instr PleasantFluteSynthFader
  gkPleasantFluteSynthFader linseg p4, p3, p5
endin

instr PleasantFluteSynthPan
  gkPleasantFluteSynthPan linseg p4, p3, p5
endin

instr PleasantFluteSynthMixerChannel
  aPleasantFluteSynthL inleta "InL"
  aPleasantFluteSynthR inleta "InR"

  aPleasantFluteSynthL, aPleasantFluteSynthR mixerChannel aPleasantFluteSynthL, aPleasantFluteSynthR, gkPleasantFluteSynthFader, gkPleasantFluteSynthPan, gkPleasantFluteSynthEqBass, gkPleasantFluteSynthEqMid, gkPleasantFluteSynthEqHigh

  outleta "OutL", aPleasantFluteSynthL
  outleta "OutR", aPleasantFluteSynthR
endin
