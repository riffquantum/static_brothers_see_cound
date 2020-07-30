instr BassLine
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
  iBaseTime = iMeasureCount*iBeatsPerMeasure
  ; 1  2  3  4  5  6  7  8  9  10  11 12
  ; C# D  D# E  F  F# G  G# A  A#  B  C

  beatScoreline "BassSynth", iBaseTime+0.0, .5, 40,  cpspch(7.11) * i(gkBPM)/30
  beatScoreline "BassSynth", iBaseTime+0.5, .5, 40,  cpspch(6.04) * i(gkBPM)/30
  beatScoreline "BassSynth", iBaseTime+1.0, .5, 40,  cpspch(6.07) * i(gkBPM)/30
  beatScoreline "BassSynth", iBaseTime+1.5, .5, 40,  cpspch(7.02) * i(gkBPM)/30
  beatScoreline "BassSynth", iBaseTime+2.0, .5, 40,  cpspch(7.02) * i(gkBPM)/30
  beatScoreline "BassSynth", iBaseTime+2.5, 1.5, 40,  cpspch(6.11) * i(gkBPM)/30

  iMeasureCount += 1
  od
endin
