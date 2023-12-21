<CsoundSynthesizer>
  <CsOptions>
      -odac
    -d
      ; -W -o "Underv0.1.wav"
      ; --midi-device=a
      --messagelevel=0
      ; -iadc
      ; --realtime
      ; -B512 -b60
      ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
      ; -B4096 -b4096
      -t80
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/Under/config/midiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/Under/instruments/orchestra-manifest.orc"
    #include "songs/Under/patterns/pattern-manifest.orc"

    instr config
      gkMuffledKickFader = 1.5

      gkBassSynthFader = 0.35
    endin

    instr Intro
      gkPercLoopReverbWetAmount = linseg(0, secondsToBeats(p3/2), 1)
      _ "PercLoopReverb", 0, secondsToBeats(p3 + 2)

      $PATTERN_LOOP(4)
        _ "BassSynth", iBaseTime+0, 3, 120, 1.110000
        _ "PercLoop", iBaseTime+0, 4, 50, 2, 4
      $END_PATTERN_LOOP
    endin

    instr DrumShift
      gkMelodyGrainDryAmount = linseg(1, p3 - bts(12), 0, bts(4), 1, 0, 1)
      gkMelodyGrainWetAmount = linseg(0, p3 - bts(12), 1, bts(4), 0, 0, 0)
      gkMelodyGrainGrainSizeAdjustment = linseg(1, p3, .01)
      gkMelodyGrainGrainFrequencyAdjustment = oscil(.05, 1/p3) + 1
      _ "MelodyGrain", 0, stb(p3)
    endin

    instr Verse
      _ "DrumShift", 0, stb(p3)
      $PATTERN_LOOP(48)
        _ "DrumLoop", iBaseTime+0, 36
        _ "BassLineVerse", iBaseTime+0, 48
        _ "VibeLoop", iBaseTime+0, 48
      $END_PATTERN_LOOP
    endin

    instr Chorus
      $PATTERN_LOOP(32)
        _ "DrumLoop", iBaseTime+0, 32
        _ "BassLineVerse", iBaseTime+0, 32
        if p4 == 2 || p4 == 1 then
          _ "VibeLoop2", iBaseTime+0, 32
        elseif p4 == 3 then
          _ "VibeLoop3", iBaseTime+0, 32
        elseif p4 == 4 then
          _ "VibeLoop4", iBaseTime+0, 32
        elseif p4 == 5 then
          _ "VibeLoop5", iBaseTime+0, 32
        elseif p4 == 6 then
          _ "VibeLoop6", iBaseTime+0, 32
        endif
      $END_PATTERN_LOOP
    endin

    _ "config", 0, -1
    ; _ "PatternWriter", 0, -1, 8
  </CsInstruments>
  <CsScore>
    ; i "Section" + 32 "Chorus" 4
    ; i "Section" + 16 "Intro"
    i "Section" + 48 "Verse"
    i "Section" + 32 "Chorus" 1
    i "Section" + 48 "Verse"
    i "Section" + 32 "Chorus" 3
    i "Section" + 48 "Verse"
    i "Section" + 32 "Chorus" 4
    i "Section" + 48 "Verse"
    i "Section" + 32 "Chorus" 5
    i "Section" + 48 "Verse"
    i "Section" + 32 "Chorus" 6
  </CsScore>
</CsoundSynthesizer>
