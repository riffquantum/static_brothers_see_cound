instr DrumPattern1
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 4
  iMeasureCount = 0
  iSampleMode = 0

  gkDistorted808KickPreGain = 20 * (4+oscil(3, 1.5))
  gkDistorted808KickPostGain = 1
  gkDistorted808KickDutyOffset = .01
  gkDistorted808KickSlopeShift = .01

  gkDistorted808KickDryAmount = 1
  gkDistorted808KickWetAmount = 1
  gkDistorted808KickPitch = oscil(.25, .25) + 1

  gaDelayHiHatTime = oscil( beatsToSeconds(1/4), 1/beatsToSeconds(iBeatsPerMeasure)) + beatsToSeconds(1/2)
  gkDelayHiHatStereoOffset = beatsToSeconds(1/16)

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "Distorted808Kick", iBaseTime+0, 1, 70,  1
    beatScoreline "DefaultKick", iBaseTime+0, 1, 70,  1
    beatScoreline "Distorted808Kick", iBaseTime+0.5, 1, 70,  .5
    beatScoreline "Distorted808Kick", iBaseTime+2.5, 1, 70,  1.2

    beatScoreline "DefaultSnare", iBaseTime+1, 1, 127,  1
    beatScoreline "DefaultSnare", iBaseTime+3, 1, 127,  1

    if iMeasureCount % 4 == 3 then
      beatScoreline "Distorted808Kick", iBaseTime+2, 1, 70,  .9
    endif

    if iMeasureCount % 4 == 2 then
      beatScoreline "Distorted808Kick", iBaseTime+3.5, 1, 40,  2
    endif

    iMeasureCount += 1
  od
endin
