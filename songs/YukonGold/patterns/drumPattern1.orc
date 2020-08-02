instr drumPattern1
  iPatternLength = p3 * i(gkBPM)/60
  iBeatsPerMeasure = 4
  iMeasureIndex = 0

  gkDefaultDrumKitDistortionWetAmmount = .55
  gkDefaultDrumKitDistortionDryAmmount = .45

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

    beatScoreline "DefaultDrumKitDistortion", iBaseTime, iBeatsPerMeasure
    beatScoreline "DefaultKick", iBaseTime+0, 1, 100, 1
    beatScoreline "DefaultKick", iBaseTime+2, 1, 100, 1
    beatScoreline "DefaultKick", iBaseTime+2.5, 1, 100, 1

    beatScoreline "DefaultSnare", iBaseTime+1, .25, 120, .8
    beatScoreline "DefaultSnare", iBaseTime+3, .25, 120, .8

    if iMeasureCount % 2 == 1 then
      beatScoreline "DefaultTomLow", iBaseTime+1, 1, 70, 1
      beatScoreline "DefaultTomLow", iBaseTime+1.25, 1, 20, 1
      beatScoreline "DefaultTomLow", iBaseTime+1.5, 1, 100, 1
      beatScoreline "DefaultTomMid", iBaseTime+1.5+1/6, 1, 100, 1
      beatScoreline "DefaultTomLow", iBaseTime+1.5+2/6, 1, 100, 1
      beatScoreline "DefaultTomLow", iBaseTime+2, 1, 100, .9
      beatScoreline "DefaultTomLow", iBaseTime+2.25, 1, 30, .85
      beatScoreline "DefaultTomLow", iBaseTime+2.75, 1, 100, .8
    else
      beatScoreline "DefaultKick", iBaseTime+1.5, 1, 80, 1
      beatScoreline "DefaultSnare", iBaseTime+1.75, .25, 80, .8
      beatScoreline "DefaultSnare", iBaseTime+1.75+1/6, .25, 30, .8
      beatScoreline "DefaultSnare", iBaseTime+1.75+2/6, .25, 10, .8
      beatScoreline "DefaultSnare", iBaseTime+2.25, .25, 60, .8
    endif

    beatScoreline "DefaultOpenHat", iBaseTime+0, .5, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+.5, .25, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+.5+1/3, .25, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+1, .25, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+1.5, .25, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+2.5, .25, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+3.5, .25, 100, 1
    beatScoreline "DefaultClosedHat", iBaseTime+2, .25, 50, 1
    beatScoreline "DefaultClosedHat", iBaseTime+3, .25, 50, 1

    iMeasureIndex += 1
  od
endin
