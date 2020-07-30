instr drumFigure1
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 5
  iMeasureCount = 0
  iSampleMode = 0
  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "OpenHat", iBaseTime+0, 1, 100, 1
    beatScoreline "HatPedal", iBaseTime+1, 1, 70, 1
    beatScoreline "ClosedHat", iBaseTime+2, 1, 120, 1
    beatScoreline "ClosedHat", iBaseTime+3, 1, 100, 1
    beatScoreline "ClosedHat", iBaseTime+4, 1, 120, 1
    ; beatScoreline "DefaultClosedHat", iBaseTime+4.5, 1, 120, 1

    beatScoreline "Kick", iBaseTime+0, 1, 100, 1
    beatScoreline "Kick", iBaseTime+4, 1, 100, 1, 1

    beatScoreline "Snare", iBaseTime+2, 1, 127, 1
    beatScoreline "Snare", iBaseTime+3.5, 1, 100, 1
    beatScoreline "Snare", iBaseTime+4.5, 1, 110, 1

    iMeasureCount += 1
  od
endin
