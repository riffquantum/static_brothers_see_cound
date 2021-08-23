<CsoundSynthesizer>
  <CsOptions>
      -odac
      ; -W -o "newLoop.wav"
      -Ma
      -m0
      ; -iadc
      ; --realtime
      ; -B512 -b256
      ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
      ; -B4096 -b4096
      -t100      ;--midioutfile=midiout.mid
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

    #include "instruments/DrumKits/BirdshitDrumKit.orc"
    #include "instruments/DrumKits/CharybdisDrumKit.orc"

    ; #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "config/defaultMidiRouterEvents.orc"


    beatScoreline "config", 0, -1

  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
  </CsScore>
</CsoundSynthesizer>
