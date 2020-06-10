<CsoundSynthesizer>

    <CsOptions>
        -odac -m0 -t100
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        gkBPM init 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"
        #include "songs/basketballBeatsEnnui/instruments/orchestra-manifest.orc"
        #include "songs/basketballBeatsEnnui/patterns/pattern-manifest.orc"
    </CsInstruments>

    <CsScore>
        m section1
          i "pattern2" 0 128
          i "weirdBigCymbalPattern" 0 128
        s
    </CsScore>
</CsoundSynthesizer>

