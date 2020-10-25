instr DrumPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "Kick", iBaseTime+0, 1, 70,  1.6
    beatScoreline "Kick", iBaseTime+0.5, 1, 70,  1
    beatScoreline "Kick", iBaseTime+1, 1, 70,  .8

    if iMeasureCount % 2 == 0 then
      beatScoreline "Kick", iBaseTime+2.25, 1, 70,  1
      beatScoreline "Kick", iBaseTime+2.75, 1, 70,  1
    else
      beatScoreline "Kick", iBaseTime+2.25, 1, 70,  1
      beatScoreline "Snare", iBaseTime+2.75, 1, 50,  .95
    endif

    beatScoreline "Kick", iBaseTime+3, 1, 70,  1

    beatScoreline "Snare", iBaseTime+1, 1, 75,  1
    beatScoreline "Snare", iBaseTime+2+6/8, 1, 5,  1
    ; beatScoreline "Snare", iBaseTime+2+7/8, 1, 9,  1
    ; beatScoreline "Snare", iBaseTime+2+7.5/8, 1, 5,  1
    beatScoreline "Snare", iBaseTime+3, 1, 75,  1

    if iMeasureCount % 4 == 3 then
      beatScoreline "Kick", iBaseTime+2, 1, 70,  .9
      beatScoreline "RideBell", iBaseTime+0, 1, 40,  1
    endif


      beatScoreline "RideBell", iBaseTime+0.5, 1, 40,  1
      beatScoreline "RideBell", iBaseTime+1.5, 1, 10,  1
      if iMeasureCount % 4 == 2 then
        beatScoreline "RideBell", iBaseTime+1.5+2/6, 1, 9,  1
        beatScoreline "RideBell", iBaseTime+1.5+4/6, 1, 9,  1
      else
        beatScoreline "RideBell", iBaseTime+1.75, 1, 10,  1
      endif
      beatScoreline "RideBell", iBaseTime+2.5, 1, 10,  1
      beatScoreline "RideBell", iBaseTime+2.75, 1, 10,  1
      beatScoreline "RideBell", iBaseTime+3.25, 1, 10,  1

      if iMeasureCount % 2 == 1 then
        beatScoreline "RideBell", iBaseTime+3.75, 1, 10,  1
      endif


      beatScoreline "RideBell", iBaseTime+3+15/16, 1, 9,  1
      beatScoreline "RideBell", iBaseTime+3+7/8, 1, 12,  1
      ; beatScoreline "RideBell", iBaseTime+0.5, 1, 10,  1

    if iMeasureCount % 4 == 2 then
      beatScoreline "Kick", iBaseTime+3.5, 1, 40,  2
      beatScoreline "Crash", iBaseTime+0.0, 1, 10, .2
    endif


    beatScoreline "ClosedHat", iBaseTime+0, 1, 70,  1
    beatScoreline "ClosedHat", iBaseTime+0.25, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+0.5, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+0.75, 1, 35,  .95

    beatScoreline "ClosedHat", iBaseTime+1, 1, 70,  1
    beatScoreline "ClosedHat", iBaseTime+1.25, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+1.5, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+1.75, 1, 35,  .95

    beatScoreline "ClosedHat", iBaseTime+2, 1, 70,  1
    beatScoreline "ClosedHat", iBaseTime+2.25, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+2.5, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+2.75, 1, 35,  .95

    beatScoreline "ClosedHat", iBaseTime+3, 1, 70,  1
    beatScoreline "ClosedHat", iBaseTime+3.25, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+3.5, 1, 35,  .95
    beatScoreline "ClosedHat", iBaseTime+3.75, 1, 35,  .95

    iMeasureCount += 1
  od
endin
