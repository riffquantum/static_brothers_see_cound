instr HatPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  gaDelayHiHatTime = oscil( beatsToSeconds(1/4), 1/beatsToSeconds(iBeatsPerMeasure)) + beatsToSeconds(1/2)
  gkDelayHiHatStereoOffset = beatsToSeconds(1/16)

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "DelayHiHat", iBaseTime, 4, 40, (iMeasureCount + 1)/10 + 1, 1
    beatScoreline "DelayHiHat", iBaseTime+1, 3, 50, (iMeasureCount + 1)/10 + 1, 0, 1, beatsToSeconds(1/4)

    iMeasureCount += 1
  od
endin
