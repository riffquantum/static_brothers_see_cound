instr Pattern1_dnb
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  gkEscapePrismFader = .1

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "EscapePrism", iBaseTime, 3.65, 120, 5.05

    beatScoreline "AmenBreak", iBaseTime, 4, 120, 2, 4
    beatScoreline "AmenBreak", iBaseTime+4, 4, 120, 2, 8

    if iMeasureCount % 2 == 0 then
      beatScoreline "EscapePrism", iBaseTime+2, 3.65, 120, 5.055
    else
      beatScoreline "EscapePrism", iBaseTime+4, 3.65, 127, 5.07
    endif

    if iMeasureCount > 0 then
      beatScoreline "EscapePrism", iBaseTime+6, 1.65, 120, 5.06

      ; beatScoreline "Snare", iBaseTime+0.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+1.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+2.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+3.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+4.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+5.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+6.5, 1, 127, 1
      ; beatScoreline "Snare", iBaseTime+7.5, 1, 127, 1

      ; beatScoreline "Kick", iBaseTime+1.25, 2, 127, 1
      ; beatScoreline "Kick", iBaseTime+4, 2, 127, 1
      ; beatScoreline "Kick", iBaseTime+5.25, 2, 127, 1

      beatScoreline "Snare", iBaseTime+0.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+1.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+2.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+3.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+4.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+5.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+6.5, 1, 127, 1
      beatScoreline "Snare", iBaseTime+7.5, 1, 127, 1
    endif

    if iMeasureCount < 4 then
      beatScoreline "HatWarp", iBaseTime+0, 8, 50, 3.05, .5
    else
      beatScoreline "HatWarp", iBaseTime+0, 8, 100, 3.057, 3
    endif

    beatScoreline "Kick", iBaseTime+0, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+0, 2, 127, .5

    beatScoreline "Kick", iBaseTime+1.25, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+1.25, 2, 127, .5

    beatScoreline "Kick", iBaseTime+4.25, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4.25, .5, 127, .35

    beatScoreline "Kick", iBaseTime+4.75, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4.75, 2, 127, .38


    if iMeasureCount > 3 then
      beatScoreline "Kick", iBaseTime+2.5, 2, 127, 1
    endif

    ; beatScoreline "KickHelix", iBaseTime+0, 4, 100, 3.05

    iMeasureIndex += 1
  od
endin
