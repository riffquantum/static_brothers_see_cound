instr TriplePortraitDrumLoop
  iPatternLength = secondsToBeats(p3)
  iMode = p4
  iBeatsPerMeasure = 8
  iMeasureCount = 0
  iSampleMode = 0

  ; if iMode == 0 || iMode ==1 then
  ;   gkTriplePortraitLoop1Pan = 50
  ;   gkTriplePortraitLoop2Pan = 50
  ; elseif iMode == 2 then
  ;   gkTriplePortraitLoop1Pan = 0
  ;   gkTriplePortraitLoop2Pan = 100
  ; elseif iMode == 3 then
  ;   gkTriplePortraitLoop2Pan = 0
  ;   gkTriplePortraitLoop1Pan = 100
  ; endif
  gkTriplePortraitLoop1Pan = oscil(50, 1/beatsToSeconds(7.1)) + 50
  gkTriplePortraitLoop2Pan = 100 - (oscil(50, 1/beatsToSeconds(8.1)) + 50)

  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure
    ; beatScoreline "YiSynth1", iBaseTime, 8, 127, 5.10
    ; beatScoreline "YiSynth1", iBaseTime, 8, 127, 4.10


    ; if iMode == 0 then
    ;   beatScoreline "TriplePortraitLoop2", iBaseTime, 8, 120, 1
    ; elseif iMode ==1 then
    ;   beatScoreline "TriplePortraitLoop1", iBaseTime, 8, 120, 1
    ; elseif iMode == 2 || iMode == 3 then
    ;   beatScoreline "TriplePortraitLoop1", iBaseTime, 8, 70, 1
    ;   beatScoreline "TriplePortraitLoop2", iBaseTime, 8, 70, 1
    ; endif

    ; beatScoreline "TriplePortraitLoop1", iBaseTime, 8, 70, 1
    ; beatScoreline "TriplePortraitLoop2", iBaseTime, 8, 70, 1


    beatScoreline "Distorted808Kick", iBaseTime, .75, 120, .75
    beatScoreline "Distorted808Kick", iBaseTime+1, 4, 120, .75
    beatScoreline "Distorted808Kick", iBaseTime+4, 4, 120, .75

    ; beatScoreline "DustyBass", iBaseTime+0, 4, 100, 4.04
    ; beatScoreline "DustyBass", iBaseTime+2, 2, 100, 4.015, .2
    ; beatScoreline "DustyBass", iBaseTime+4, 4, 100, 3.06

    ; if iMeasureCount % 2 == 0 then
    ;   beatScoreline "Violin1", iBaseTime, 8, 100, 1
    ; else
    ;   beatScoreline "Violin3", iBaseTime, 8, 120, 1
    ; endif

    iMeasureCount += 1
  od
endin
