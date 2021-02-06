<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      -iadc
      ; --realtime
      ; -B512 -b60
      -t160
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    ; #include "config/guitarMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/MaskDance/instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/MaskDance/patterns/pattern-manifest.orc"

    instr config
    endin
    beatScoreline "config", 0, -1

    ; 2 women light dancing
    ; man looking confusing
    ; 1 woman more intense dancing
    ; kaleidoscope shots
    ; woman and man
    ; 4 figures circle prism
    ;     - overlays
    ;     - dance
    ;     - separation
    ; brief circle strobe
    ; hands over glass
    ; mask removal





  </CsInstruments>
  <CsScore>
  </CsScore>
</CsoundSynthesizer>
