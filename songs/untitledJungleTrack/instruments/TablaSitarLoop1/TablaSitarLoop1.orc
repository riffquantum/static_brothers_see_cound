gSTablaSitarLoop1Name = "TablaSitarLoop1"
gSTablaSitarLoop1Route = "Mixer"
instrumentRoute gSTablaSitarLoop1Name, gSTablaSitarLoop1Route

alwayson "TablaSitarLoop1MixerChannel"

gkTablaSitarLoop1EqBass init 1
gkTablaSitarLoop1EqMid init 1
gkTablaSitarLoop1EqHigh init 1
gkTablaSitarLoop1Fader init 1
gkTablaSitarLoop1Pan init 50

instr TablaSitarLoop1
  kPitchFactor = p4 == 0 ? 1 : p4
  iSkipTimeInBeats = p5

  kPitchFactor *= (gkBPM / 149.5)

  STablaSitarLoop1FilePath init "songs/untitledJungleTrack/instruments/TablaSitarLoop1/tablasitarloop1.wav"

  iWrapAround = 1
  iFormat = 0
  iSkipInit = 0

  aTablaSitarLoop1L, aTablaSitarLoop1R diskin STablaSitarLoop1FilePath, kPitchFactor, iSkipTimeInBeats, iWrapAround, iFormat, iSkipInit

  outleta "OutL", aTablaSitarLoop1L
  outleta "OutR", aTablaSitarLoop1R
endin

instr TablaSitarLoop1BassKnob
  gkTablaSitarLoop1EqBass linseg p4, p3, p5
endin

instr TablaSitarLoop1MidKnob
  gkTablaSitarLoop1EqMid linseg p4, p3, p5
endin

instr TablaSitarLoop1HighKnob
  gkTablaSitarLoop1EqHigh linseg p4, p3, p5
endin

instr TablaSitarLoop1Fader
  gkTablaSitarLoop1Fader linseg p4, p3, p5
endin

instr TablaSitarLoop1Pan
  gkTablaSitarLoop1Pan linseg p4, p3, p5
endin

instr TablaSitarLoop1MixerChannel
  aTablaSitarLoop1L inleta "InL"
  aTablaSitarLoop1R inleta "InR"

  aTablaSitarLoop1L, aTablaSitarLoop1R mixerChannel aTablaSitarLoop1L, aTablaSitarLoop1R, gkTablaSitarLoop1Fader, gkTablaSitarLoop1Pan, gkTablaSitarLoop1EqBass, gkTablaSitarLoop1EqMid, gkTablaSitarLoop1EqHigh

  outleta "OutL", aTablaSitarLoop1L
  outleta "OutR", aTablaSitarLoop1R
endin
