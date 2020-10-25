opcode randomVariation, i, 0
  iVariation random -0.1, 0.1
  xout iVariation
endop

instr pattern1
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 4
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex*iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "Kick", iBaseTime+0.0, 4, 4, .9
    if iMeasureCount % 2 == 1 then
      beatScoreline "Kick", iBaseTime+0.25, 4, 4, .9
      beatScoreline "Kick", iBaseTime+1.5, 4, 5, .9
    else
      beatScoreline "Kick", iBaseTime+0.5, 4, 4, .9
      beatScoreline "Kick", iBaseTime+1.75, 4, 5, .9
    endif


    beatScoreline "Kick", iBaseTime+2.5, 4, 5, .9

    beatScoreline "Snare", iBaseTime+1, 4, 4, .09
    beatScoreline "Snare", iBaseTime+3, 4, 4, 1.1

    if iMeasureCount % 4 != 0 then
      if iMeasureCount % 2 == 1 then
        beatScoreline "OpenHat", iBaseTime+0, 0.5, 2.3, 1
      else
        beatScoreline "HiHat", iBaseTime+0, 4, 2.3, 1
      endif
      beatScoreline "HiHat", iBaseTime+0.5, 3.5, 2.3, 1
      beatScoreline "HiHat", iBaseTime+1, 4, 2.3, 1
      beatScoreline "HiHat", iBaseTime+1.5, 3.5, 2.3, 1
      beatScoreline "HiHat", iBaseTime+2, 4, 2.3, 1
      beatScoreline "HiHat", iBaseTime+2.5, 3.5, 2.3, 1
      beatScoreline "HiHat", iBaseTime+3, 4, 2.3, 1
      beatScoreline "HiHat", iBaseTime+3.5, 3.5, 2.3, 1
    else
      beatScoreline "OpenHat", iBaseTime+0, 4, 2.3, 1
      beatScoreline "Crash", iBaseTime+2, 4, 2.3, 0.8
    endif
    iMeasureIndex += 1
  od
endin
