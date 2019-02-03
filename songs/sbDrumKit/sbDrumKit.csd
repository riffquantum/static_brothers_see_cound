<CsoundSynthesizer>
    <CsOptions>
        -odac -Ma  -m0
        ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        ;#include "config/defaultMixerRoutes.orc"

        giBPM = 120

        #include "opcodes/opcode-manifest.orc"
        #include "songs/sbDrumKit/instruments/orchestra-manifest.orc"
        #include "songs/sbDrumKit/instruments/midiRouter/midiNoteMapping.orc"
        #include "songs/sbDrumKit/instruments/midiRouter/noteInstruments/note-instrument-manifest.orc"

      instr Dummy
      endin



    </CsInstruments>

    <CsScore>
        i "Dummy" 0 3600 .100 300

    </CsScore>
</CsoundSynthesizer>
