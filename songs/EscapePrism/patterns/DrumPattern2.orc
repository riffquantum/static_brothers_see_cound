instr DrumPattern2
  $PATTERN_LOOP(8)
    beatScoreline "Snare", iBaseTime+1, 1, 127, 1
    beatScoreline "Snare", iBaseTime+3, 1, 127, 1
    beatScoreline "Snare", iBaseTime+5, 1, 127, 1

    if iMeasureCount % 3 == 1 then
      beatScoreline "Snare", iBaseTime+6.75, 1, 27, 1
      beatScoreline "Snare", iBaseTime+6+(7/8), 1, 27, 1
    elseif iMeasureCount % 3 == 2 then
      beatScoreline "Snare", iBaseTime+6+(7/8), 1, 17, 1
    endif
    beatScoreline "Snare", iBaseTime+7, 1, 127, 1

    beatScoreline "DefaultClosedHat", iBaseTime+0.0075465, 0.077400, 124, 1
    beatScoreline "DefaultClosedHat", iBaseTime+0.323144, 0.076432, 127, 1
    beatScoreline "DefaultClosedHat", iBaseTime+1.066183, 0.000967, 127, 1
    beatScoreline "DefaultClosedHat", iBaseTime+3.040499, 0.061920, 127, 1
    beatScoreline "DefaultClosedHat", iBaseTime+3.257218, 0.061920, 127, 1
    beatScoreline "DefaultClosedHat", iBaseTime+4.000257, 0.000967, 127, 1

    if iMeasureCount % 3 == 2 then
      beatScoreline "DefaultClosedHat", iBaseTime+5.000257, .5, 100, 1

      beatScoreline "DefaultClosedHat", iBaseTime+5.25, .5, 80, 1
    endif

    if iMeasureCount % 4 == 3 then
      beatScoreline "DefaultClosedHat", iBaseTime+6+(1/3), 0.075465, 127, 1
      beatScoreline "DefaultClosedHat", iBaseTime+6+(2/3), 0.075465, 127, 1
    elseif iMeasureCount % 4 == 2 then
      beatScoreline "DefaultClosedHat", iBaseTime+6+(1/3), 0.075465, 127, 1
    else
      beatScoreline "DefaultClosedHat", iBaseTime+6.25, 0.075465, 127, 1
    endif

    beatScoreline "HatWarp2", iBaseTime+0, 2, 70, 3.08, 3, .8, 100, .1
    beatScoreline "HatWarp2", iBaseTime+4, 4, 70, 3.1, 3, .8, 100, .1


    beatScoreline "Kick", iBaseTime+0, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+0, 2, 127, .5
    beatScoreline "Kick", iBaseTime+0.5, 2, 127, 1
    ; beatScoreline "Distorted808Kick", iBaseTime+0.5, 2, 127, .5

    ; beatScoreline "Kick", iBaseTime+4, 2, 127, 1
    ; beatScoreline "Distorted808Kick", iBaseTime+4, .5, 127, .35

    ; beatScoreline "Kick", iBaseTime+4.5, 2, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+4.5, 2, 127, .38
    beatScoreline "Distorted808Kick", iBaseTime+6.5, 2, 127, .38

    beatScoreline "Kick", iBaseTime+2.5, 2, 127, 1

    ; beatScoreline "KickHelix", iBaseTime+2, 1, 100, 2.11
    ; beatScoreline "KickHelix", iBaseTime+5, 1, 100, 2.11
  $END_PATTERN_LOOP
endin
