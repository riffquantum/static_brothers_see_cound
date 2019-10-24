<CsoundSynthesizer>
    <CsOptions>
        -odac -Ma  -m0
        ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"

        giBPM = 120

        #include "opcodes/opcode-manifest.orc"
        #include "songs/sbDrumKit/instruments/orchestra-manifest.orc"
        #include "songs/sbDrumKit/instruments/midiRouter/midiNoteMapping.orc"
        #include "songs/sbDrumKit/instruments/midiRouter/noteInstruments/note-instrument-manifest.orc"

      giMetronomeIsOn = 0

      instr Dummy
        midiMonitor
      endin
    </CsInstruments>

    <CsScore>
        i "Metronome" 0 3600 .100 300
        i "Dummy" 0 3600 .100 300
        /*i "BigSynth" 0 4 .559 164
        i "BigSynth" 2 2 .559 148

        i "BigSynth" 5 15 .559 164
        i "BigSynth" 5 15 .559 100
        i "BigSynth" 5 15 .559 144
        i "BigSynth" 5 15 .5 800*/

    </CsScore>
</CsoundSynthesizer>
