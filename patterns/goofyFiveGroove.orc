$BREAK_SAMPLE(NothingIDontLikeBreak'Mixer'localSamples/nothingIDontLikeBreak.wav'16)

instr goofyFiveGroove
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 5
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "NothingIDontLikeBreak", iBaseTime+0, iBeatsPerMeasure-.333, 127, 1, 0

    beatScoreline "DefaultKick", iBaseTime+0, .25, 100, 1
    beatScoreline "DefaultKick", iBaseTime+1, .25, 95, .95
    beatScoreline "DefaultKick", iBaseTime+1.5, .25, 80, .9

    if iMeasureIndex % 2 == 0 && iMeasureIndex % 4 != 0 then
      beatScoreline "DefaultOpenHat", iBaseTime+0, .5, 80, 1

    elseif iMeasureIndex % 4 == 0 then
      beatScoreline "DefaultCrash", iBaseTime+0, .5, 80, .95
      beatScoreline "DefaultCrash", iBaseTime+1, .5, 80, .95
    else
      beatScoreline "DefaultClosedHat", iBaseTime+0, .5, 80, 1
    endif

    beatScoreline "DefaultClosedHat", iBaseTime+0.5, .5, 100, 1

    beatScoreline "DefaultClosedHat", iBaseTime+1, .5, 80, 1
    beatScoreline "DefaultClosedHat", iBaseTime+2, .5, 80, 1
    beatScoreline "DefaultClosedHat", iBaseTime+3, .5, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+3.5, .5, 80, 1
    beatScoreline "DefaultClosedHat", iBaseTime+4, .5, 80, 1

    beatScoreline "DefaultSnare", iBaseTime+1, .25, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+2.75, .25, 30, 1
    beatScoreline "DefaultSnare", iBaseTime+3.25, .25, 30, 1
    beatScoreline "DefaultSnare", iBaseTime+4, .25, 120, 1

    beatScoreline "DefaultKick", iBaseTime+2, .25, 100, 1
    beatScoreline "DefaultKick", iBaseTime+2.5, .25, 80, 1.05
    beatScoreline "DefaultKick", iBaseTime+3.5, .25, 80, .95
    beatScoreline "DefaultKick", iBaseTime+4.5, .25, 100, .9

    if iMeasureIndex % 4 == 2 then
      beatScoreline "DefaultKick", iBaseTime+4.75, .25, 70, .8
    endif

    beatScoreline "DefaultCowbell", iBaseTime+1.5, .25, 5, 1
    beatScoreline "DefaultCowbell", iBaseTime+1.5, .25, 5, 1
    beatScoreline "DefaultCowbell", iBaseTime+2.5, .25, 5, 1
    beatScoreline "DefaultCowbell", iBaseTime+4.5, .25, 5, 1

    iMeasureIndex += 1
  od
endin
