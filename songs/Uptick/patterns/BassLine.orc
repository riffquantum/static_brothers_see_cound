instr BassLine
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1
      beatScoreline "LayeredBassSynth", iBaseTime+0, 0.32763, 120, 2.060000
      beatScoreline "LayeredBassSynth", iBaseTime+2, 0.632763, 120, 2.0750000

      beatScoreline "LayeredBassSynth", iBaseTime+3, 0.32763, 120, 2.060000
      beatScoreline "LayeredBassSynth", iBaseTime+4.5, 0.632763, 120, 2.060000

      beatScoreline "LayeredBassSynth", iBaseTime+6, 0.32763, 120, 2.060000
      beatScoreline "LayeredBassSynth", iBaseTime+6.5, 0.632763, 120, 2.060000
    iMeasureIndex += 1
  od
endin
