<CsoundSynthesizer>
    <CsOptions>
        -odac -Ma  -m0
        -B512 -b128
        -t120

        ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"

        gkBPM init 120

        #include "opcodes/opcode-manifest.orc"
        #include "songs/sbDrumKit/instruments/midiRouter/midiNoteMapping.orc"
        #include "songs/sbDrumKit/instruments/orchestra-manifest.orc"
        #include "songs/sbDrumKit/instruments/midiRouter/noteInstruments/note-instrument-manifest.orc"

      giMetronomeIsOn = 0
      giCurrentSong = 0
      giDoubleKickOn = 1
      giHatClutchIsOpen = 1

      instr Dummy
        ;printk 0.5, gkTriggersLastVelocity[73]
        ; midiMonitor
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
