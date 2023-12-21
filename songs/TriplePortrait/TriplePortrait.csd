<CsoundSynthesizer>
  <CsOptions>
    --messagelevel=0
    ; --midi-device=a
    ; -t87.5
    -t100
    -odac
    -d
    ; -W -o "TriplePortrait.wav
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/TriplePortrait/config/midiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "songs/TriplePortrait/config/MidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/TriplePortrait/instruments/orchestra-manifest.orc"
    #include "songs/TriplePortrait/patterns/pattern-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"

    instr DrumLoop2
      $PATTERN_LOOP(8)
        beatScoreline "Drum1", iBaseTime, 4, 120, 1, 0
        beatScoreline "Drum1", iBaseTime+4, 4, 120, 1, 0
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr DrumLoop3
      $PATTERN_LOOP(8)
        beatScoreline "Drum2", iBaseTime, 8, 120, 1, 0.75
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr Intro
      $PATTERN_LOOP(8)
        beatScoreline "Violin1", iBaseTime, 8, 120, 1
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr ViolinLoop1
      $PATTERN_LOOP(8)
        beatScoreline "Violin1", iBaseTime, 8, 120, 1
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr ViolinLoop2
      $PATTERN_LOOP(8)
        beatScoreline "Violin2", iBaseTime, 8, 120, 1
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr ViolinLoop3
      $PATTERN_LOOP(8)
        beatScoreline "Violin3", iBaseTime, 8, 120, 1
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr ViolinLoop4
      $PATTERN_LOOP(8)
        beatScoreline "Violin4", iBaseTime, 8, 120, 1
        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr Pattern4
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 32
      iMeasureCount = 0
      iSampleMode = 0
      ; gkTriplePortraitLoop1Pan = oscil(50, 1/beatsToSeconds(8)) + 50
      ; gkTriplePortraitLoop2Pan = 100 - (oscil(50, 1/beatsToSeconds(8)) + 50)


      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure
        beatScoreline "TriplePortraitDrumLoop", iBaseTime, 16, 0
        beatScoreline "TriplePortraitDrumLoop", iBaseTime+16, 8, 2
        beatScoreline "TriplePortraitDrumLoop", iBaseTime+24, 8, 3
        iMeasureCount += 1
      od
    endin

    instr config
      ; gkDistorted808KickPreGain = 50
      gkDistorted808KickPostGain = 1
      gkDistorted808KickDutyOffset = .001
      gkDistorted808KickSlopeShift = .001
      giDistorted808KickStage2ClipLevel = 0dbfs/2
      giDistorted808KickFinalGainAmount = .25

      gkTriplePortraitLoop1EqBass = 3
      gkTriplePortraitLoop2EqBass = 3
    endin
    beatScoreline "config", 0, -1



  </CsInstruments>

  <CsScore>
      ; i "PatternWriter" 0 128 8
    ; m section1
      i "Section" + 32 "Intro"
      i "Section" + 8 "WeirdoMarch"
      i "Section" + 4 "OddBopLoop"
      i "Section" + 8 "WeirdoMarch"
      i "Section" + 8 "CreepLoop"
      i "Section" + 16 "DrumLoop2"
    ; s
  </CsScore>
</CsoundSynthesizer>
