<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        giBPM = 90

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "songs/basketballBeatsEnnui/instruments/hiHat.orc"
        #include "songs/basketballBeatsEnnui/instruments/kick.orc"
        #include "songs/basketballBeatsEnnui/instruments/snare.orc"
        #include "songs/basketballBeatsEnnui/instruments/sharpOpenHat.orc"
        #include "songs/basketballBeatsEnnui/instruments/openHat.orc"
        #include "songs/basketballBeatsEnnui/instruments/santanaBell.orc"
        #include "songs/basketballBeatsEnnui/instruments/plucker.orc"
        #include "songs/basketballBeatsEnnui/instruments/bigSynth.orc"

        #include "patterns/sixteenthHats606.orc"

        #include "songs/basketballBeatsEnnui/patterns/pattern1.orc"



    </CsInstruments>

    <CsScore>
        #define bpm # 90 #

        m section1
          t 0 [$bpm]

          /*
          i "santanaBellSndwarp" 0 4 5 0 1 5
          */

          i "pattern1" 0 64

        s


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>

