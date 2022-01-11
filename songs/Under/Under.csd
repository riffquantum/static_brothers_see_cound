<CsoundSynthesizer>
  <CsOptions>
      -odac
      ; -W -o "Underv0.1.wav"
      --midi-device=a
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
      gkNewEffectQ = 4 ;+ oscil(14, 0.1)
      gkNewEffectShift = 5000 ; + oscil(250, 0.5)
      gkNewEffectIntNoise = 0
      gkNewEffectMode = 0
      ; gkNewEffectDryAmount = 1

      gkNewEffectEqBass = 1.5
      gkNewEffectEqHigh = .5

      gkMuffledKickFader = 1.5

      gkBassSynthFader = 0.35
    endin

    instr Intro
      gkPercLoopReverbWetAmount = linseg(0, secondsToBeats(p3/2), 1)
      beatScoreline "PercLoopReverb", 0, secondsToBeats(p3 + 2)

      $PATTERN_LOOP(4)
        beatScoreline "BassSynth", iBaseTime+0, 3, 120, 1.110000
        beatScoreline "PercLoop", iBaseTime+0, 4, 50, 2, 4
      $END_PATTERN_LOOP
    endin

    instr Verse
      $PATTERN_LOOP(48)
        beatScoreline "DrumLoop", iBaseTime+0, 36
        beatScoreline "BassLineVerse", iBaseTime+0, 48
        beatScoreline "VibeLoop", iBaseTime+0, 48
      $END_PATTERN_LOOP
    endin

    instr Chorus
      $PATTERN_LOOP(32)
        beatScoreline "DrumLoop", iBaseTime+0, 32
        beatScoreline "BassLineVerse", iBaseTime+0, 32
        if p4 == 2 then
          beatScoreline "VibeLoop2", iBaseTime+0, 32
        elseif p4 == 3 then
          beatScoreline "VibeLoop3", iBaseTime+0, 32
        elseif p4 == 4 then
          beatScoreline "VibeLoop4", iBaseTime+0, 32
        elseif p4 == 5 then
          beatScoreline "VibeLoop5", iBaseTime+0, 32
        elseif p4 == 6 then
          beatScoreline "VibeLoop6", iBaseTime+0, 32
        endif
      $END_PATTERN_LOOP
    endin

    instr Section
      SinstrumentName = p4

      beatScoreline SinstrumentName, 0, secondsToBeats(p3), p5, p6, p7, p8
    endin

    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 8
  </CsInstruments>
  <CsScore>
    ; i "Section" + 32 "Chorus" 4
    i "Section" + 16 "Intro"
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
