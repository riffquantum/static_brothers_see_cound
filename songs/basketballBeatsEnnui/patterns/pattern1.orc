instr pattern1
  iPatternLength = p3 * giBPM/60

  iBeatsPerMeasure = 4
  iMeasureCount = 0
  until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureCount*iBeatsPerMeasure

    ;hats
    beatScoreline("hiHat", iBaseTime, 1, ".75")
    beatScoreline("hiHat", iBaseTime+0.5, 1, ".5")
    beatScoreline("hiHat", iBaseTime+1, 1, ".75")
    beatScoreline("hiHat", iBaseTime+1.5, 1, ".5")
    beatScoreline("hiHat", iBaseTime+2, 1, ".75")
    beatScoreline("hiHat", iBaseTime+2.5, 1, ".5")
    beatScoreline("hiHat", iBaseTime+3, 1, ".75")
    beatScoreline("hiHat", iBaseTime+3.5, 1, ".5")

    if (iMeasureCount + 1) % 4 == 0 then
      beatScoreline("hiHat", iBaseTime+2.625, 1, ".25")
      beatScoreline("hiHat", iBaseTime+2.75, 1, ".35")
      beatScoreline("hiHat", iBaseTime+2.875, 1, ".45")
    endif



    ;kicks
    beatScoreline("kick", iBaseTime, 1, ".5")
    beatScoreline("kick", iBaseTime+0.25, 1, ".5")
    beatScoreline("kick", iBaseTime+0.375, 1, ".15")

    if (iMeasureCount + 1) % 4 != 3 then
      beatScoreline("kick", iBaseTime+2.5, 1, ".5")
    endif



    ;snares
    beatScoreline("snare", iBaseTime + 1, 1, "1")
    beatScoreline("snare", iBaseTime + 3, 1, "1")
    if (iMeasureCount + 1) % 4 == 0 then
      beatScoreline("snare", iBaseTime + 1.75, 1, ".5")
    endif

    if (iMeasureCount + 1) % 4 == 2 then
      beatScoreline("snare", iBaseTime + 2.25, 1, ".25")
    endif

    ;synth
    if (iMeasureCount + 1) % 4 != 0 then
      beatScoreline("BigRichSynth", iBaseTime, .75, "1 70")
      beatScoreline("BigRichSynth", iBaseTime+1, 1, "1 80")
      beatScoreline("BigRichSynth", iBaseTime+2, 2, "1 65")
    else
      beatScoreline("BigRichSynth", iBaseTime, 4, "1 60")
    endif

    if (iMeasureCount + 1) % 8 == 0 then
      beatScoreline("BigRichSynth", iBaseTime, .25, "1 160")
      beatScoreline("BigRichSynth", iBaseTime+.5, .25, "1 160")
      beatScoreline("BigRichSynth", iBaseTime+1, .25, "1 165")
      beatScoreline("BigRichSynth", iBaseTime+1.333, .75, "1 154")
    endif

    iMeasureCount += 1
  od
endin
