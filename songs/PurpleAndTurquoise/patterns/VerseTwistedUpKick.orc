instr VerseTwistedUpKick
  gkTwistedUpKickFader = (0.75 + oscil(0.05, 0.2)) * linseg(0, beatsToSeconds(16), 0, beatsToSeconds(16), 1, 0.1, 1)

  $PATTERN_LOOP(8)
    if iMeasureCount % 4 == 0 then
      beatScoreline "TwistedUpKick", iBaseTime, 8, 80, 4.02, 1.9, 20
    else
      beatScoreline "TwistedUpKick", iBaseTime, 4, 80, 4.02, 1.9, 2 + iMeasureCount/100

      if iMeasureCount % 6 == 5 then
        beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8 + iMeasureCount/1000, 4, 5
      elseif iMeasureCount % 7 == 6 then
        beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8 + iMeasureCount/1000, 4, 5, 3, 0
      elseif iMeasureCount % 8 == 3 then
        beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8 + iMeasureCount/1000, 0, 0, 3, 0
      else
        beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, 1.1 + iMeasureCount/1000
      endif
    endif
  $END_PATTERN_LOOP
endin
