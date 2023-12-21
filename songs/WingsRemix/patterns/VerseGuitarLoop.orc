instr VerseGuitarLoop
  $PATTERN_LOOP(48)
    ; _ "Guitar1", i0, 48, 100, 1
      ; _ "Guitar1_SOL_57", i0 + 4, 9, 100, 5/3 ;, 0
      ; _ "Guitar1_SOL_57", i0 + 24, 9, 100, 5/3 ;, 16
      ; _ "Guitar1_SOL_57", i0 + 36, 9, 100, 5/3 ;, 32

    ; _ "Guitar2", i0, 48, 100, 1
      ; _ "Guitar2_SOL_57", i0 + 8, 9, 100, 6/5 ;, 0
      ; _ "Guitar2_SOL_57", i0 + 20, 9, 100, 6/5 ;, 16
      ; _ "Guitar2_SOL_57", i0 + 40, 9, 100, 6/5 ;, 32

    _ "Guitar1Grain", i0, 48, 100, 4.0
  $END_PATTERN_LOOP
endin
