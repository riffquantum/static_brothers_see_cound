instr BassLine
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = 8
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

      ; beatScoreline "LayeredBassSynth", iBaseTime+23.159219, 0.953982, 120, 3.020000
      beatScoreline "LayeredBassSynth", iBaseTime+0.134486, 0.632763, 120, 3.010000
      beatScoreline "LayeredBassSynth", iBaseTime+0.629860, 0.508919, 116, 3.040000
      beatScoreline "LayeredBassSynth", iBaseTime+1.090403, 0.530205, 127, 3.010000
      beatScoreline "LayeredBassSynth", iBaseTime+1.566427, 0.599867, 111, 3.040000
      beatScoreline "LayeredBassSynth", iBaseTime+2.054061, 1.035254, 127, 3.010000
      beatScoreline "LayeredBassSynth", iBaseTime+3.006108, 1.048800, 111, 3.050000
      beatScoreline "LayeredBassSynth", iBaseTime+4.031687, 0.476023, 127, 3.010000
      beatScoreline "LayeredBassSynth", iBaseTime+4.484489, 0.510854, 111, 3.040000
      beatScoreline "LayeredBassSynth", iBaseTime+4.956643, 0.588257, 120, 3.010000
      beatScoreline "LayeredBassSynth", iBaseTime+5.479107, 0.638568, 116, 3.040000
      beatScoreline "LayeredBassSynth", iBaseTime+5.966741, 1.238435, 127, 3.010000
      beatScoreline "LayeredBassSynth", iBaseTime+7.154865, 0.924956, 127, 3.020000
      ; beatScoreline "LayeredBassSynth", iBaseTime+8.137873, 0.514725, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+8.613896, 0.476023, 111, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+9.062829, 0.514725, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+9.546592, 0.607607, 116, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+10.092278, 0.986878, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+11.075286, 0.950112, 116, 3.050000
      ; beatScoreline "LayeredBassSynth", iBaseTime+12.081514, 0.417972, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+12.507226, 0.534075, 111, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+12.963899, 0.518595, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+13.459273, 0.588257, 120, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+13.997218, 1.360343, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+15.084719, 1.087501, 120, 3.020000
      ; beatScoreline "LayeredBassSynth", iBaseTime+16.131584, 0.516660, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+16.588257, 0.481829, 111, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+17.023644, 0.592127, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+17.511278, 0.599867, 116, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+18.041483, 1.155228, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+19.036101, 1.056540, 120, 3.050000
      ; beatScoreline "LayeredBassSynth", iBaseTime+20.108121, 0.570841, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+20.626716, 0.476023, 120, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+21.079519, 0.557296, 127, 3.010000
      ; beatScoreline "LayeredBassSynth", iBaseTime+21.574893, 0.603737, 120, 3.040000
      ; beatScoreline "LayeredBassSynth", iBaseTime+22.078007, 1.195864, 127, 3.010000

    iMeasureIndex += 1
  od
endin
