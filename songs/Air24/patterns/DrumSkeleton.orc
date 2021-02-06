instr DrumPattern
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "DefaultRide", iBaseTime+0, 1, 120, 1
    beatScoreline "DefaultKick", iBaseTime+0, 1, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+1.75, 1, 20, 1
    beatScoreline "DefaultSnare", iBaseTime+2, 1, 120, 1
    beatScoreline "DefaultKick", iBaseTime+3, 1, 120, 1
    beatScoreline "DefaultKick", iBaseTime+3.25, 1, 100, 1
    beatScoreline "DefaultKick", iBaseTime+3.5, 1, 100, 1

    repeatNotes "DefaultClosedHat", iBaseTime+0, 5, 2, .5, 70, 1, 500, 2

    beatScoreline "DefaultRide", iBaseTime+5, 1, 120, 1
    beatScoreline "DefaultKick", iBaseTime+5, 1, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+7, 1, 120, 1
    repeatNotes "DefaultClosedHat", iBaseTime+5, 6, 2, .5, 70, 1, 500, 2


    beatScoreline "DefaultSnare", iBaseTime+9.333, 1, 40, 1
    beatScoreline "DefaultSnare", iBaseTime+9.666, 1, 20, 1
    beatScoreline "DefaultSnare", iBaseTime+10, 1, 120, 1
    beatScoreline "DefaultRide", iBaseTime+10, 1, 120, 1

    beatScoreline "DefaultRide", iBaseTime+11, 1, 120, 1
    beatScoreline "DefaultKick", iBaseTime+11, 1, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+13, 1, 120, 1
    repeatNotes "DefaultClosedHat", iBaseTime+11, 5, 2, .5, 70, 1, 500, 2

    beatScoreline "DefaultRide", iBaseTime+16, 1, 120, 1
    beatScoreline "DefaultKick", iBaseTime+16, 1, 120, 1
    repeatNotes "DefaultClosedHat", iBaseTime+16, 8, 2, .5, 70, 1, 500, 2

    beatScoreline "DefaultSnare", iBaseTime+18, 1, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+21, 1, 120, 1
    beatScoreline "DefaultRide", iBaseTime+21, 1, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+22, 1, 120, 1
    beatScoreline "DefaultRide", iBaseTime+22, 1, 120, 1

    beatScoreline "DefaultKick", iBaseTime+22.25, 1, 50, 1
    beatScoreline "DefaultSnare", iBaseTime+22.5, 1, 20, 1
    beatScoreline "DefaultSnare", iBaseTime+22.75, 1, 20, 1

    beatScoreline "DefaultSnare", iBaseTime+23, 1, 120, 1
    beatScoreline "DefaultRide", iBaseTime+23, 1, 120, 1

    iMeasureIndex += 1
  od
endin
