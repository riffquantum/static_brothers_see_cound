instr MainLoop
  ; _ "KissBit", 0, stb(p3), 8, 0, 0
  ; gkKissBitFader = .5
  ; _ "MarianVerb", 0, stb(p3)
  _ "VerseDrums", 0, stb(p3)
  $PATTERN_LOOP(4)
    ; _ "AsmaStab", i0, 1, 100, 1
    ; _ "AsmaStab", i0, 2, 100, .5
    ; _ "AsmaStab", i0, 2, 100, 4/3
    ; Toss this in sometimes, every bar is good
    ; _ "Kiss", i0, 3.9, 100, 1, 4
    ; _ "Kiss", i0, 3.9, 100, 1, 8
    ; _ "Kiss", i0, 3.9, 100, 1, 12


    ; _ "Asma1", i0, 4, 120, 1, 0
  $END_PATTERN_LOOP

  $PATTERN_LOOP(2)
    ; _ "Asma1", i0, 2, 60, 4/3, 0
    ; _ "Asma1", i0, 2, 120, 2/3, 0
  $END_PATTERN_LOOP

  $PATTERN_LOOP(8)

    ; The bellow should be regarded as placeholders for the scratching idea here.
    ; if iMeasureCount % 4 == 0 then
    ;   _ "HarpGlis", i0, 1, 60, 1
    ; endif
    ; _ "PianoBits", i0+2.5, 2, 60, 1, 3.1

    ; THE HEAVY BRASS JAW HARP IS IN KEY FOR THIS - Jaw harp intro? Dare I include
    ; SAW?

    _ "Asma1", i0, 8, 120, 1, 0
    if iMeasureCount > 2 && iMeasureIndex % 4 == 3 then
      _ "Asma1", i0+4, 2, 120, 4/3, 0
      _ "Asma1", i0+6, 2, 120, 4/3, 0
    elseif iMeasureCount > 2 && iMeasureIndex % 4 != 1 then
      _ "Asma1", i0+4, 2, 120, 2/3, 0
      _ "Asma1", i0+6, 2, 120, 2/3, 0
    endif
  $END_PATTERN_LOOP

  ; _ "AsmaLoop", 0, 16

endin

instr AsmaLoop
  $PATTERN_LOOP(8)
    _ "Asma1", i0, 8, 120, 1, 0

    if p4 == 1 then
      _ "Asma1", i0+4, 2, 120, 2/3, 0
      _ "Asma1", i0+6, 2, 120, 2/3, 0
    elseif p4 == 2 then
      _ "Asma1", i0+4, 2, 120, 4/3, 0
      _ "Asma1", i0+6, 2, 120, 4/3, 0
    endif
  $END_PATTERN_LOOP
endin

instr VerseLoop

  ; This is a nice accent to include maybe on the second verse. Mimics the sparkle loop trail off
  ; $PATTERN_LOOP(8)
  ;   _ "Asma8", i0, .25, 100, 1, 20, 0, 0, 4.5
  ; $END_PATTERN_LOOP

  $PATTERN_LOOP(32)
  _ "AsmaLoop", i0, 8, 1
  _ "AsmaLoop", i0+8, 8, 0
  _ "AsmaLoop", i0+16, 8, 1
  _ "AsmaLoop", i0+24, 8, 2
  $END_PATTERN_LOOP
endin

instr VerseDrums
  $PATTERN_LOOP(4)
    ; if iMeasureIndex % 4 == 0 then
    ; _ "Kiss", i0, 1, 100, 1, 1.5
    ; _ "Kiss", i0+1, 1, 100, 1, 1.5
    ; _ "Kiss", i0+2, 1, 100, 1, 1.5
    ; _ "Kiss", i0+3, 1, 100, 1, 1.5
    ; else
    ; endif
    ; _ "Kick", i0+1.75+1/32, 1, 100, 1


    if iMeasureCount % 2 == 1 then
      if iMeasureCount % 8 == 5 then
        _ "DrumLoop7", i0, 4
      elseif iMeasureCount % 4 == 3 then
        _ "DrumLoop3", i0, 4
      else
        _ "DrumLoop1", i0, 4
      endif
    else
      _ "DrumLoop2", i0, 4
    endif

    ; if iMeasureCount % 2 == 1 then
    ;   _ "DrumLoop2", i0, 4
    ; else
    ;   _ "DrumLoop6", i0, 4
    ; endif
  $END_PATTERN_LOOP
endin

instr Intro
  _ "Asma1", 0, stb(p3), 120, -1, 7, 0, 2, 0
  _ "Asma1", 0, stb(p3), 120, -2/3, 7, 0, 0, 0

  ; _ "Asma1", stb(p3)-1, 1, 120, 1, 7.5
  _ "Kiss", stb(p3)-1, 1, 100, 1, 7
endin

instr Verse
  ; _ "VerseLoop", 0, stb(p3)-16
  ; _ "VerseDrums", 0, stb(p3)-16

  _ "VerseLoop", 0, stb(p3)
  _ "VerseDrums", 0, stb(p3)
endin
