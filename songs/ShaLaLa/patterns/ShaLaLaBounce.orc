instr ShaLaLaBounce
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 4
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "ShaLaLa", iBaseTime+0, .666, 86, 523.251

    beatScoreline "ShaLaLa", iBaseTime+0.75, .666, 86, 1046.502

    if iMeasureCount%4==0 then
      beatScoreline "ShaLaLa", iBaseTime+1.5, 2.5, 86, 261.626
    else
      beatScoreline "ShaLaLa", iBaseTime+1.5, .5, 86, 261.626
      beatScoreline "ShaLaLa", iBaseTime+2, .5, 86, 261.626, .5
      beatScoreline "ShaLaLa", iBaseTime+2.5, .5, 86, 261.626, .5
      beatScoreline "ShaLaLa", iBaseTime+3, .5, 86, 261.626, .5
      beatScoreline "ShaLaLa", iBaseTime+3.5, .5, 86, 261.626, .5
    endif

    beatScoreline "RingMod", iBaseTime + iBeatsPerMeasure/2, iBeatsPerMeasure/2

    iMeasureIndex += 1
  od
endin
