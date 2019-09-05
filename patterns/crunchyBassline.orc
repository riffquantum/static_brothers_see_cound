instr crunchyBassline
  iPatternLength = p3 * giBPM/60

  iBeatsPerMeasure = 4
  iMeasureCount = 0
  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    if iMeasureCount % 6 == 0 || iMeasureCount % 6 == 1 || iMeasureCount % 6 == 2 || iMeasureCount % 6 == 3 then
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+0, .25, "1 65.406")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+.5, .25, "1 130.813")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+1.5, .25, "1 65.406")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+2, .25, "1 130.813")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+2.5, .25, "1 65.406")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+3, .25, "1 110.000")
    endif

    if iMeasureCount % 6 == 4 then
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+0, 3.5, "1 41.201")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+4, 1.5, "1 87.305")
      scoreline_i beatScoreline( "BigCrunchySynth", iBaseTime+6, 1, "1 73.414")
    endif

    iMeasureCount += 1
  od
endin