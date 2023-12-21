instr VerseLoop
  iSupressFadein = p4

  $PATTERN_LOOP(48)
      ; Get a twisty kick in here somewhere
      _ "Dist808", i0, 4, 120, .5
      _ "DrumLoop1", i0+1, 48
      _ "Verse808s", i0+1, 48

      _ "Bass", i0, 48, 127, 1, 0
      _ "BassSubDi", i0, 48, 100, 1, 0
      _ "BassSub", i0, 48, 100, 1, 0


      if iSupressFadein == 1 then
        _ "VerseElectronicDrums", i0+1, 48
      elseif iMeasureCount > 2 then
        _ "VerseElectronicDrums", i0+1, 48
      endif

      if iSupressFadein == 1 then
        _ "VerseKickHelix", i0+1, 48
      elseif iMeasureCount > 3 then
        _ "VerseKickHelix", i0+1, 48
      endif

      if iMeasureCount > 4 then
        _ "Guitar1_B52", i0, 48, 127, 1, 0
        _ "Guitar2_B52", i0, 48, 127, 1, 0
      endif

      ; _ "Bass", i0, 48, 100, 2/3, 0
      ; _ "BassSubDi", i0, 48, 120, .75
      ; _ "BassSub", i0, 48, 120, .75


      ; _ "DrumGrain", i0+8, 8
      ; _ "DrumTweak", i0+8, 8
      ; _ "DrumGrain", i0+24, 8
      ; _ "DrumTweak", i0+24, 8
      ; _ "DrumGrain", i0+40, 8
      ; _ "DrumTweak", i0+40, 8

      ; _ "VerseGuitarLoop", i0, 48
      ; if iMeasureCount > 5 then
      ;   _ "VerseGuitarLoop", i0, 48
      ; endif
  $END_PATTERN_LOOP
endin
