<CsoundSynthesizer>
  <CsOptions>
    -m0
    ; -Ma
    -t144
    -odac
    ; -W -o "Cathedrals.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/Cathedrals/config/midiAssignments.orc"

    #include "opcodes/opcode-manifest.orc"
    #include "songs/Cathedrals/config/MidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/Cathedrals/instruments/orchestra-manifest.orc"
    ; #include "config/defaultMidiRouterEvents.orc"
    #include "songs/Cathedrals/patterns/pattern-manifest.orc"
    ; #include "instruments/DrumKits/DefaultDrumKit.orc"

    instr DrumLoop
      $PATTERN_LOOP(6)
        beatScoreline "ExpectedBreak1", iBaseTime, 5.5, 100, 3.0

        iMeasureCount += 1
      $END_PATTERN_LOOP
    endin

    instr config
    endin
    beatScoreline "config", 0, -1

  </CsInstruments>

  <CsScore>
    ; m section1
      i "DrumLoop" 0 128
    ; s
  </CsScore>
</CsoundSynthesizer>
