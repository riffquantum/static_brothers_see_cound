giSequencerTable1 ftgenonce 0,  0,  16,  -2,  12, 24, 12, 14, 15, 12, 0, 12, 12, 24, 12, 14, 15, 6, 13, 16 ; sequencer (pitches are 6.00 + p/100)
giAccentTable1 ftgenonce 0,  0,  32,  -2,   0,  1,  0,  0,  0,  0, 0,  0,  0,  1,  0,  1,  1, 1,  0,  0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1; accent sequence
giDurationTable1 ftgenonce 0,  0,  16,  -2,   2,     1,  1,  2,    1,  1,  1,  2,     1,  1, 3,       1, 4, 0, 0, 0; fill with zeroes till next power of 2

giSequencerTable2 ftgenonce 0,  0,  8,  -2,   10, 0, 12, 0, 7, 10, 12, 7; sequencer (pitches are 6.00 + p/100)
giAccentTable2 ftgenonce 0,  0,  16,  -2,   1, 0,  0, 0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0; accent sequence
giDurationTable2 ftgenonce 0,  0,  2,  -2,   16, 0; fill with zeroes till next power of 2

giSequencerTable3 ftgenonce 0,  0,  8,  -2,   0, 12, 0, 0, 12, 0, 0, 12
giAccentTable3 ftgenonce 0,  0,  8,  -2,   1,  1, 1, 1,  1, 1, 1,  1
giDurationTable3 ftgenonce 0,  0,  8,  -2,   1,  1, 1, 1,  1, 1, 1,  1

$TB_303(TB303'Mixer)

instr tb303Test
  $PATTERN_LOOP(60)
    _ "TB303", i0, 20, .1, .3, .2, .2, .1, .4, .05, .8, 0, 0, \
    120, 2, giSequencerTable2, giAccentTable2, giDurationTable2, 127

    _ "TB303", i0+00, 20, 0 , 1, .5 , 1 , .1, .4, 1 , 1 , 1 , 1, \
      120, 0,  giSequencerTable1,  giAccentTable1,  giDurationTable1,  60

    _ "TB303", i0+20, 40, .2, 1, .5 , 1 , .1, .1, .5, 1 , .5, 1, \
      120, 2,  giSequencerTable2,  giAccentTable2,  giDurationTable2, 127

    _ "TB303", i0+40, 20, .5, 1, .95, 1 , 1 , .9, 1 , .1, .5, 1, \
      120, 0,  giSequencerTable1,  giAccentTable1,  giDurationTable1,  60

    _ "TB303", i0+30, 30, .5, 1, .5 , .5, .5, .5, .5, .5, 0 , 0, \
      120, 0, giSequencerTable3, giAccentTable3, giDurationTable3, 100

  $END_PATTERN_LOOP
endin
