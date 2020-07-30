<CsoundSynthesizer>
    <CsOptions>
        -odac -Ma  -m0
        -B512 -b128
        -t120
        ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
      #include "config/defaultConfig.orc"

      #include "opcodes/opcode-manifest.orc"
      #include "config/defaultMidiAssignments.orc"
      #include "instruments/orchestra-manifest.orc"
      #include "songs/sbDrumKit/instruments/midiRouter/midiNoteMapping.orc"
      #include "songs/sbDrumKit/instruments/orchestra-manifest.orc"
      #include "songs/sbDrumKit/instruments/midiRouter/noteInstruments/note-instrument-manifest.orc"
      #include "songs/sbDrumKit/instruments/midiRouter/midiControlInputs/midiControlInputs.orc"

      giCurrentSong = 1
      giDoubleKickOn = 1
      giHatClutchIsOpen = 1
      giMetronomeIsOn = 1

      instr Dummy
        ;printk 0.5, gkTriggersLastVelocity[73]
        ; midiMonitor
      endin
    </CsInstruments>

    <CsScore>
        i "Metronome" 0 3600 .100 300
        i "Dummy" 0 3600 .100 300

    </CsScore>
</CsoundSynthesizer>
