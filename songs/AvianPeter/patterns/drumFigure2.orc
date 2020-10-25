instr drumFigure2
  iPatternLength = secondsToBeats(p3)
  iSegueLenth = p4 != 0 ? p4 : 3
  iBeatsPerMeasure = 6
  iMeasureCount = 0
  iSampleMode = 0
  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "OpenHat", iBaseTime+0, 1, 100, 1
    beatScoreline "HatPedal", iBaseTime+1, 1, 100, 1
    beatScoreline "ClosedHat", iBaseTime+2, 1, 100, 1

    beatScoreline "Kick", iBaseTime+0, 1, 100, 1

    beatScoreline "Snare", iBaseTime+2, 1, 100, 1

    beatScoreline "segue1", iBaseTime+3, iSegueLenth, 100



    iMeasureCount += 1
  od
endin
