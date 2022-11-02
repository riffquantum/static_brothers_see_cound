instr DrumLoop
  $PATTERN_LOOP(8)
    _ "MuffledKick", iBaseTime+0, .25, 127, 1
    _ "Distorted808Kick", iBaseTime+0, .25, 127, .5
    _ "MuffledKick", iBaseTime+0.25, 1, 127, 1
    _ "Distorted808Kick", iBaseTime+0.25, 1, 127, .5

    _ "MuffledKick", iBaseTime+2.6, 1, 127, 1
    _ "Distorted808Kick", iBaseTime+2.6, 1, 127, .5

    _ "MuffledKick", iBaseTime+4.6, 1, 127, 1
    _ "Distorted808Kick", iBaseTime+4.6, 1, 127, .5

    if iMeasureCount % 2 ==0 then
      _ "MuffledKick", iBaseTime+6.6, 1, 127, 1
      _ "Distorted808Kick", iBaseTime+6.6, 1, 127, .5
      _("PillarBreak", iBaseTime+0.5, .5, 120, 1, 12)
    else
      _ "MuffledKick", iBaseTime+5.6, 1, 127, 1
      _ "Distorted808Kick", iBaseTime+5.6, 1, 127, .5
    endif

    ; _("PillarBreak", iBaseTime+3.6, .5, 120, 1, 12)
    if iMeasureCount % 4 == 0 then
      _("PillarBreak", iBaseTime+5.5, .5, 120, 1, 12)
    endif

    repeatNotes("PillarBreak", iBaseTime+0, 8, 1, .25, 120, 2, 700, 4, 0, 12)
    repeatNotes("PillarBreak", iBaseTime+0.5, 7.5, 1, .25, 120, 2, 700, 3, 0, 12)

    _("PillarBreak", iBaseTime+0, 4, 120, 1, 8)
    _("PillarBreak", iBaseTime+0.25, .5, 120, .99, 8)
    _("PillarBreak", iBaseTime+4, 2, 120, 1, 4)
    _("PillarBreak", iBaseTime+6, 1.5, 120, 1, 4)
  $END_PATTERN_LOOP
endin
