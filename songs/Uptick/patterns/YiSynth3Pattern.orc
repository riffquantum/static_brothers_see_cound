instr YiSynth3Pattern
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 24
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
     iMeasureCount = iMeasureIndex + 1

    beatScoreline "YiSynth3", iBaseTime+0.084659, 0.913346, 70, 4.010000
    beatScoreline "YiSynth3", iBaseTime+0.972849, 0.661789, 78, 3.030000
    beatScoreline "YiSynth3", iBaseTime+1.988752, 0.824333, 76, 3.110000
    beatScoreline "YiSynth3", iBaseTime+3.033682, 0.729516, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+4.082482, 0.793372, 73, 4.010000
    beatScoreline "YiSynth3", iBaseTime+5.017113, 0.801113, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+5.998186, 0.901736, 71, 3.110000
    beatScoreline "YiSynth3", iBaseTime+6.942493, 0.623088, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+8.000968, 0.812723, 73, 4.010000
    beatScoreline "YiSynth3", iBaseTime+8.993651, 0.750801, 89, 3.030000
    beatScoreline "YiSynth3", iBaseTime+9.903126, 0.944307, 69, 3.110000
    beatScoreline "YiSynth3", iBaseTime+10.982887, 0.727581, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+12.023946, 0.828203, 78, 4.010000
    beatScoreline "YiSynth3", iBaseTime+13.037915, 0.659854, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+13.989962, 0.866905, 76, 3.110000
    beatScoreline "YiSynth3", iBaseTime+15.019411, 0.665659, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+16.056600, 0.777892, 78, 4.010000
    beatScoreline "YiSynth3", iBaseTime+16.973816, 0.725646, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+17.976175, 0.864969, 73, 3.110000
    beatScoreline "YiSynth3", iBaseTime+18.955312, 0.677269, 78, 3.030000
    beatScoreline "YiSynth3", iBaseTime+20.015722, 0.932696, 76, 4.010000
    beatScoreline "YiSynth3", iBaseTime+20.998730, 0.787567, 81, 3.030000
    beatScoreline "YiSynth3", iBaseTime+22.001088, 0.977203, 71, 3.110000
    beatScoreline "YiSynth3", iBaseTime+23.024732, 0.756606, 81, 3.030000

    iMeasureIndex += 1
  od
endin
