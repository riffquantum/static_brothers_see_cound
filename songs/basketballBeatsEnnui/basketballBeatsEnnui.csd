<CsoundSynthesizer>

    <CsOptions>
        -odac -m0 -t160
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        ; #include "config/defaultMidiAssignments.orc"

        gkBPM init 160

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"
        #include "songs/basketballBeatsEnnui/instruments/orchestra-manifest.orc"
        #include "songs/basketballBeatsEnnui/patterns/pattern-manifest.orc"
    </CsInstruments>

    <CsScore>
        m section1
          i "dBeat" 0 12
          i "weirdBigCymbalPattern" 12 4
          i "dBeat" 16 12
          i "dBeatFill1" 28 4
        s
    </CsScore>
</CsoundSynthesizer>

