$BREAK_SAMPLE(NinetyNine'NinetyNineMono'localsamples/ninetyNineAndAHalfIntroLoop.wav'8)
$BREAK_SAMPLE(Inhale'Mixer'localsamples/inhale.wav'4)
$TO_MONO(NinetyNineMono'Mixer)

instr AmericasSecondMostBlunted
  gkNinetyNineEqBass = 4
  gkNinetyNinePan = 10
  $PATTERN_LOOP(8)
    if iMeasureCount % 8 < 7 then
      beatScoreline "NinetyNine", iBaseTime, 7.95, 60, 1
      beatScoreline "KissingMyLoveSpankyBreak", iBaseTime, 8, 120, 1, 0
    else
      beatScoreline "Inhale", iBaseTime, 5, 120, 0.75
      beatScoreline "NinetyNine", iBaseTime+5, 2.9, 60, 1, 5
      beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+5, 3, 120, 1, 1
    endif
  $END_PATTERN_LOOP
endin
