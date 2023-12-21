instr Verse
  iSupressFadein = p4
  ; VERSE EFFECTS
  ; _ "BassDelay", 0, stb(p3)
  _ "CloserVerb", 0, stb(p3), 1
  ; _ "CloserVerb2", 0, stb(p3), 8
  _ "NoInput", 0, -1, 30, 5.0

  gkSnareDelayDelayPan = 50 + oscil(50, 1/bts(48))
  gaSnareDelayDelayTime = poscil:a(1, .03, -1, .5) + 1.2
  ; _ "SnareDelay", 0, stb(p3) ; Could go here for continuous delay or in Drum Loop for stop/start

  ; NO
  gaNoInputDelayTime = oscil:a(.25, .1) + 1
  gkNoInputDelayDryAmount = 1
  gkNoInputFader = linseg(0, bts(12), 0, bts(12), i(gkNoInputFader))
  ; _ "NoInput", 0, stb(p3), 30, 5.0
  ; _ "NoInputDelay", 0, stb(p3)

  _ "VerseLoop", 0, stb(p3), iSupressFadein

  if iSupressFadein != 1 then
    _ "VerseFadeIn", 0, stb(p3)
  endif

  ; _ "DrumGrain", 0 + 48*4, 48
  ; _ "DrumTweak", 0 + 48*4+40, 8

  ; $PATTERN_LOOP(16)
  ;   _ "DrumGrain", i0 + 4, 12
  ;   _ "DrumTweak", i0 + 8, 8
  ; $END_PATTERN_LOOP


  ; VOCAL EVENTS
  ; TO DO: Verse needs to be filled with these types of guttural vocals.
  ; This is where the magic will happen
  ; Then the next loop needs higher pitched vocals that build up into the big final
  ; grained out scream.

  ; 1 - beats 0-48

  ; 2 - beats 48-96
  gkVoxGrainDelayDelayWetAmount = .75
  gaVoxGrainDelayDelayTime = poscil:a(.05, .3) + 1
  gkVoxGrainDelayDelayFeedbackAmount = 0.7
  gkVoxGrainDelayGrainTimeStretch = oscil(.25, .05) + 1
  gkVoxGrainDelayGrainGrainSizeAdjustment = oscil(.25, .1) + 1
  gkVoxGrainDelayGrainGrainFrequencyAdjustment = oscil(.25, .15) + 1

  gkLowVox1Pan = 25
  _ "LowVox1", 73, 3, 100, .4 ; perfect

  ; 3 - beats 96-144
  gkLowVox2Pan = 75
  _ "LowVox2", 100, 3, 100, .5 ; perfect


  _ "LowVox1", 143, 3, 100, .6 ; perfect
  ; 4 - beats 144-192
  gkLowVox3Pan = 0
  gkLowVox4Pan = 100

  _ "LowVox3", 160, 3, 100, .6 ; perfect
  _ "LowVox4", 160, 3, 100, .6 ; perfect

  ; Drums come in at 191 I think
  _ "LowVox5", 184, 3, 127, .75 ; perfect
  _ "LowVox5Ramp", 184, 9 ; perfect

  _ "MidVox1", 191, 1, 100, 1 ; perfect

  ; 5 - beats 192-240
  _ "LowVox6", 201, 3, 127, .6 ;perfect

  _ "MidVox2", 207, 1, 100, 1
  _ "LowVox7", 212, 3, 127, .6

  _ "MidVox1", 224, 1, 100, .9

  _ "LowVox1", 232, 3, 100, .4

  _ "MidVox2", 242, 1, 100, 1.06

  _ "LowVox2", 247, 3, 100, .5

  _ "MidVox3", 255, 1, 100, 1


  ; ; 6 - beats 240-288

  _ "LowVox3", 266, 3, 100, .6
  _ "LowVox4", 268, 3, 100, .6
  _ "MidVox3", 271, 1, 100, 1.125

  ; _ "LowVox8", 282, 3, 100, .8
  _ "LowVox7", stb(p3)-7, 3, 100, .7
  _ "LowVox8", stb(p3)-7, 3, 100, .8
  _ "MidVox1", stb(p3)-7, 3, 100, 1
  ; _ "LowVox8", 0, 3, 100, .8




  gkDrumGrainGrainSizeAdjustment = 1
  gkDrumGrainGrainFrequencyAdjustment = 1
  gkDrumGrainTimeStretch = 1

  ; _ "DrumGrain", 36, 12
  ; _ "DrumTweak", 40, 8

  ; _ "DrumGrain", 180, 11
  ; _ "DrumTweak", 184, 7, 1

  ; _ "DrumGrain", stb(p3)-12, 12
  ; _ "DrumTweak", stb(p3)-8, 8, 2


  ; $PATTERN_LOOP(16)
  ;   _ "DrumGrain", i0 + 7, 12
  ;   ; _ "DrumTweak", i0 + 9, 8
  ; $END_PATTERN_LOOP
endin

instr LowVox5Ramp
  gaLowVox5Tuning = linseg(1, p3, 1.333333)
endin
