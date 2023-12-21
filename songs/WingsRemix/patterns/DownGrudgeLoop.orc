instr DownGrudgeLoop
  iVoxSet = i(gkVoxBusFader)
  gkVoxBusFader linseg iVoxSet, bts(8), iVoxSet * .75, p3 - bts(7.9), iVoxSet * .75, .1, iVoxSet
  gkCloserVerbWetAmount = .5
  _ "CloserVerb", 0, stb(p3), 1
  ; _ "BassDelay", 0, stb(p3)

  gaNoInputDelayTime = oscil:a(.25, .1) + 1
  gkNoInputDelayDryAmount = 1
  _ "NoInput", 0, stb(p3), 30, 5.0
  _ "NoInputDelay", 0, stb(p3)

  ; _ "Vox1", 0, stb(p3), 20

  _ "DownGrudgeDrumLoop", 0, stb(p3)

  $PATTERN_LOOP(8)
    _ "Bass", i0, 8, 127, 1, (iMeasureIndex % 4) * 8
    _ "BassSubDi", i0, 8, 100, 1, (iMeasureIndex % 4) * 8
    _ "BassSub", i0, 8, 100, 1, (iMeasureIndex % 4) * 8

    _ "Guitar1_B52", i0, 8, 127, -1, (iMeasureIndex % 4) * 2
    _ "Guitar2_B52", i0, 8, 127, -1, (iMeasureIndex % 4) * 2
  $END_PATTERN_LOOP

  _ "HiVox6", 0, 3, 100, 1
  _ "MidVox1", 6, 3, 100, 1
  _ "LowVox7", 14, 3, 100, .8
  _ "HiVox2", 21, 3, 80, 1
  _ "HiVox3", 21, 3, 80, 1
  _ "LowVox8", 24, 3, 100, .8
  _ "HiVox4", 36, 3, 100, 1
  _ "LowVox5", 40, 3, 100, .8
  _ "HiVox5", 44, 3, 100, 1.1
  _ "HiVox6", 58, 3, 100, 1

  gkVoxGrainDelayDelayFeedbackAmount = linseg(\
    i(gkVoxGrainDelayDelayFeedbackAmount), \
    58, \
    i(gkVoxGrainDelayDelayFeedbackAmount), \
    5.9, \
    0, \
    .1, \
    i(gkVoxGrainDelayDelayFeedbackAmount) \
  )
endin
