instr DrumPattern2
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "Kick", iBaseTime+0, .01, 70,  1.1
    beatScoreline "Kick", iBaseTime+0.25, .01, 70,  1.1

    beatScoreline "Kick", iBaseTime+0.75+0.125, .01, 70,  1.1
    beatScoreline "Kick", iBaseTime+1, .01, 70,  1.1

    beatScoreline "Kick", iBaseTime+1.75+0.125, .01, 70,  1.1
    beatScoreline "Kick", iBaseTime+2, .01, 70,  1.1

    beatScoreline "Kick", iBaseTime+2.75+0.125, .01, 70,  1.1
    beatScoreline "Kick", iBaseTime+3, .01, 70,  1.1
    beatScoreline "Kick", iBaseTime+3.25, .01, 70,  1.1

    beatScoreline "Snare", iBaseTime+.5, .01, 70,  .9
    beatScoreline "Snare", iBaseTime+1.5, .01, 70,  .9
    beatScoreline "Snare", iBaseTime+2.5, .01, 70,  .9
    beatScoreline "Snare", iBaseTime+3.5, .01, 70,  .9

    repeatNotes "ClosedHat", iBaseTime, iBeatsPerMeasure, 4, .125, 50, 4, 0, 4

    beatScoreline "OpenHat", iBaseTime+0.0, 16, 80,  .25

    iMeasureCount += 1
  od
endin
