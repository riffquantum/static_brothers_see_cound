#include "../instruments/BigCrunchySynth.orc"

instr crunchyBassline
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 4
  iMeasureCount = 0
  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    if iMeasureCount % 6 == 0 || iMeasureCount % 6 == 1 || iMeasureCount % 6 == 2 || iMeasureCount % 6 == 3 then
      beatScorelineS( "BigCrunchySynth", iBaseTime+0, .25, "1 65.406")
      beatScorelineS( "BigCrunchySynth", iBaseTime+.5, .25, "1 130.813")
      beatScorelineS( "BigCrunchySynth", iBaseTime+1.5, .25, "1 65.406")
      beatScorelineS( "BigCrunchySynth", iBaseTime+2, .25, "1 130.813")
      beatScorelineS( "BigCrunchySynth", iBaseTime+2.5, .25, "1 65.406")
      beatScorelineS( "BigCrunchySynth", iBaseTime+3, .25, "1 110.000")
    endif

    if iMeasureCount % 6 == 4 then
      beatScorelineS( "BigCrunchySynth", iBaseTime+0, 3.5, "1 41.201")
      beatScorelineS( "BigCrunchySynth", iBaseTime+4, 1.5, "1 87.305")
      beatScorelineS( "BigCrunchySynth", iBaseTime+6, 1, "1 73.414")
    endif

    iMeasureCount += 1
  od
endin
