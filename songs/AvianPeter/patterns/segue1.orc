instr segue1
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 1
  iMeasureCount = 0
  iSampleMode = 0
  iDurationInBeats = p3*i(gkBPM)/60

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure
    beatScoreline "Kick", iBaseTime+0, 1, 100, 1

    beatScoreline "Crash", iBaseTime+0, 1, 100, 1

    iPunishmentAwaitsDuration = iMeasureCount+1 == iDurationInBeats ? 10 : 1

    beatScoreline "PunishmentAwaits", iBaseTime+0, iPunishmentAwaitsDuration, 100

    iMeasureCount += 1
  od
endin
