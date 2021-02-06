instr KickSquiggleGroove
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    if iMeasureCount % 4 == 2 then
      beatScoreline "KickSquiggle", iBaseTime+4.25, .7, 120, 3.100000
    endif

    if iMeasureCount % 4 > 2 then
      beatScoreline "KickSquiggle", iBaseTime+0, 4, 100, 3.02
      beatScoreline "KickSquiggle", iBaseTime+4, 4, 100, 3.02
    else
      beatScoreline "KickSquiggle", iBaseTime+0, 4, 100, 3.03
      beatScoreline "KickSquiggle", iBaseTime+4, 4, 100, 3.03
    endif

    beatScoreline "DefaultSnare", iBaseTime+1, 1, 70, .8
    beatScoreline "DefaultSnare", iBaseTime+3, 1, 70, .8
    beatScoreline "DefaultSnare", iBaseTime+5, 1, 70, .8
    beatScoreline "DefaultSnare", iBaseTime+7, 1, 70, .8

    if iMeasureCount > 4 then
      beatScoreline "TR606Kick", iBaseTime+0, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+1, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+2, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+3, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+4, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+5, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+6, 1, 120, .9
      beatScoreline "TR606Kick", iBaseTime+7, 1, 120, .9
    endif
    if iMeasureCount > 6 then
      if iMeasureCount % 4 != 1 then
        beatScoreline "ThinkBreak", iBaseTime+0, 2, 100, 1, 2
        beatScoreline "ThinkBreak", iBaseTime+2, 2, 100, 1
        beatScoreline "ThinkBreak", iBaseTime+4, 4, 100, 1
      else
        beatScoreline "ThinkBreak", iBaseTime+0, 8, 100, .5
      endif
    endif

    iMeasureIndex += 1
  od
endin
