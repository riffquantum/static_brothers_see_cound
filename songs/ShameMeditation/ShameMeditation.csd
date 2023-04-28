<CsoundSynthesizer>
  <CsOptions>
    -odac
    ; --midi-device=a
    --messagelevel=0
    -B512 -b256
    -t96
    ;--midioutfile=midiout.mid
    ; -W -o "RNF Drums.wav"
    ; -iadc
    ; --realtime
    ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
    ; -B4096 -b4096
    ;-F midiout.mid
    ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/ShameMeditation/instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "songs/ShameMeditation/patterns/pattern-manifest.orc"

    instr config
      gkDefaultClosedHatFader = 0.4
      gkSpectralDelayWetAmount = 1
      gkSpectralDelayDryAmount = 1
    endin

  </CsInstruments>
  <CsScore>
    i "config" 0 -1
    i "MeditationLoop" 0 264
  </CsScore>
</CsoundSynthesizer>
