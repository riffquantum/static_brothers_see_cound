instr DrumLoop1
  $PATTERN_LOOP(4)
    _ "Kick", i0, 1, 100, 1
    _ "Kick", i0+.75+1/32, 1, 100, 1
    _ "Kick", i0+2.75+1/32, 1, 100, 1
    _ "Kick", i0+3.5, 1, 100, 1


    _ "Kiss", i0, 4, 100, 1.0, 0
  $END_PATTERN_LOOP
endin

instr DrumLoop2
  $PATTERN_LOOP(4)
    _ "Kick", i0, 1, 100, 1
    _ "Kick", i0+.75+1/32, 1, 100, 1
    _ "Kick", i0+2.75+1/32, 1, 100, 1

    _ "Kiss", i0, 3.5-.1, 100, 1, 0
    _ "Kiss", i0+3.5-2/128, .45, 100, 1, 1.5
  $END_PATTERN_LOOP
endin

instr DrumLoop3
  $PATTERN_LOOP(4)
    _ "Kick", i0, 1, 100, 1
    _ "Kick", i0+2.75+3/64, 1, 110, 1
    _ "Kick", i0+3.25+3/128, 1, 80, .8

    _ "Kiss", i0, 4, 100, 1, 4;3.99
  $END_PATTERN_LOOP
endin

instr DrumLoop4
  $PATTERN_LOOP(4)
    _ "Kick", i0, 1, 100, 1
    _ "Kick", i0+.25+3/128, 1, 70, 1
    _ "Kick", i0+.75+1/32, 1, 100, 1
    _ "Kick", i0+2.25+1/32, 1, 100, 1
    _ "Kick", i0+3, 1, 80, 1
    _ "Kick", i0+3.25+3/128, 1, 70, .8

    _ "Kiss", i0, 3.95, 80, .99, 12.04
  $END_PATTERN_LOOP
endin

instr DrumLoop5
  $PATTERN_LOOP(4)
    _ "Kick", i0, 1, 100, 1
    _ "Kick", i0+.25+3/128, 1, 70, 1
    _ "Kick", i0+.75+1/32, 1, 100, 1
    _ "Kick", i0+2, 1, 100, 1
    _ "Kick", i0+2.25+3/128, 1, 70, 1
    _ "Kick", i0+2.75+1/32, 1, 100, 1


    ; _ "Kick", i0+2.25+1/32, 1, 100, 1
    ; _ "Kick", i0+3, 1, 80, 1
    ; _ "Kick", i0+3.25+3/128, 1, 70, .8

    _ "Kiss", i0, 2, 80, .99, 12.04
    _ "Kiss", i0+2, 2, 80, .99, 12.04
  $END_PATTERN_LOOP
endin

instr DrumLoop6
  $PATTERN_LOOP(4)
    _ "Kick", i0+2, 1, 100, 1
    _ "Kick", i0+2.25+3/128, 1, 70, 1
    _ "Kick", i0+2.75+1/32, 1, 100, 1

    _ "Kick", i0+.25+1/32, 1, 100, 1
    _ "Kick", i0+1, 1, 80, 1
    _ "Kick", i0+1.25+3/128, 1, 70, .8

    _ "Kiss", i0, 1.95, 80, .99, 14.04
    _ "Kiss", i0+2, 2, 80, .99, 12.04
  $END_PATTERN_LOOP
endin

instr DrumLoop7
  $PATTERN_LOOP(4)
    _ "Kick", i0, 1, 100, 1
    _ "Kick", i0+.25+3/128, 1, 70, 1
    _ "Kick", i0+.75+1/32, 1, 100, 1

    _ "Kick", i0+2.75+1/32, 1, 100, 1
    _ "Kick", i0+3.5, 1, 100, 1

    _ "Kiss", i0, 2, 80, .99, 12.04
    _ "Kiss", i0+2, 2, 100, 1.0, 2

  $END_PATTERN_LOOP
endin
