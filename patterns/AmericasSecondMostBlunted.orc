$BREAK_SAMPLE(NinetyNine'NinetyNineMonoInput'localsamples/ninetyNineAndAHalfIntroLoop.wav'8)
$BREAK_SAMPLE(Inhale'Mixer'localsamples/inhale.wav'4)
$TO_MONO(NinetyNineMono'Mixer'Mixer)

instr AmericasSecondMostBlunted
  gkNinetyNineEqBass = 4
  gkNinetyNinePan = 10

  $PATTERN_LOOP(8)
    _ "NinetyNineMono", iBaseTime, 8, 0

    if iMeasureCount % 4 < 3 then
      _ "NinetyNine", iBaseTime, 7.95, 60, 1
      _ "KissingMyLoveSpankyBreak", iBaseTime, 8, 120, (iMeasureCount % 8 == 6 ? 0.75 : 1), 0
    else
      _ "NinetyNine", iBaseTime, 1.1, 60, 1
      _ "KissingMyLoveSpankyBreak", iBaseTime, 1, 120, 1, 0

      _ "Inhale", iBaseTime+1, 4.25, 120, 0.9

      _ "NinetyNine", iBaseTime+5, 2.9, 60, 1, 5
      _ "KissingMyLoveSpankyBreak", iBaseTime+5, 3, 120, 1, 1
    endif
  $END_PATTERN_LOOP
endin
