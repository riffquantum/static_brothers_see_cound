opcode randomVariation, i, 0
  iVariation random -0.1, 0.1
  xout iVariation
endop

instr machineGunTriplets
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 8
  iMeasureCount = 0

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    beatScoreline "Crash", iBaseTime+0.0, 4, 2.3, .9
    beatScoreline "OpenHat", iBaseTime+0.333, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+0.0, 1, 8, 1.01
    beatScoreline "Kick", iBaseTime+0.333, 1, 7, 1.01
    beatScoreline "Kick", iBaseTime+0.666, 1, 7, 1.01

    beatScoreline "OpenHat", iBaseTime+1.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+1.0, 1, 8, 1.01
    beatScoreline "Kick", iBaseTime+1.333, 1, 7, 1.01
    beatScoreline "Kick", iBaseTime+1.666, 1, 7, 1.01

    beatScoreline "OpenHat", iBaseTime+2.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+2.0, 1, 8, 1.01
    beatScoreline "Kick", iBaseTime+2.333, 1, 7, 1.01
    beatScoreline "Kick", iBaseTime+2.666, 1, 7, 1.01

    beatScoreline "OpenHat", iBaseTime+3.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+3.0, 1, 8, 1.01
    beatScoreline "Kick", iBaseTime+3.333, 1, 7, 1.01
    beatScoreline "Kick", iBaseTime+3.666, 1, 7, 1.01

    beatScoreline "OpenHat", iBaseTime+4.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+4.0, 1, 8, 1.0, 1

    beatScoreline "OpenHat", iBaseTime+5.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+5.0, 1, 8, 1.0, 1

    beatScoreline "OpenHat", iBaseTime+6.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+6.0, 1, 8, 1.01

    beatScoreline "OpenHat", iBaseTime+7.0, 4, 2.3, 1
    beatScoreline "Kick", iBaseTime+7.0, 1, 8, 1.01


    beatScoreline "Snare", iBaseTime + 0.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 1.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 2.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 3.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 4.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 5.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 6.0, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 7.0, 1, 6, 1.1

    beatScoreline "Snare", iBaseTime + 0.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 1.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 2.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 3.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 4.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 5.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 6.5, 1, 6, 1.1
    beatScoreline "Snare", iBaseTime + 7.5, 1, 6, 1.1
    /*

    beatScoreline "Snare", iBaseTime + 16, 1, 6.2 1.1

    beatScoreline "OpenHat", iBaseTime+0.0, 2, 2.3 1
    beatScoreline "HiHat", iBaseTime+4.0, 2, 2.3 .8
    beatScoreline "HiHat", iBaseTime+6.0, 2, 2.3 .8
    beatScoreline "HiHat", iBaseTime+8.0, 2, 2.3 .8
    beatScoreline "HiHat", iBaseTime+10.0, 2, 2.3 .8
    beatScoreline "HiHat", iBaseTime+12.0, 2, 2.3 .8
    beatScoreline "HiHat", iBaseTime+14.0, 2, 2.3 .8
    beatScoreline "HiHat", iBaseTime+16.0, 2, 2.3 .8
    */


    ;beatScoreline "OpenHat", iBaseTime+0.0, 4, 5 .5


    iMeasureCount += 1
  od
endin
