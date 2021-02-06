instr VerseOutline
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 192
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1


    beatScoreline "BubblingNudge", iBaseTime+0, 24
    beatScoreline "TurbineLoop1", iBaseTime+0, 192

    beatScoreline "DrumPattern", iBaseTime+24, 168

    beatScoreline "Clatter", iBaseTime+48, 24
    beatScoreline "CloudDrift1", iBaseTime+48, 144

    beatScoreline "EmContent", iBaseTime+72, 24


    beatScoreline "OffBreeze", iBaseTime+96, 96

    beatScoreline "Clatter", iBaseTime+120, 24
    beatScoreline "BubblingNudge", iBaseTime+144, 48

    iMeasureIndex += 1
  od
endin
