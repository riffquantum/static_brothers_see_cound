<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"

        gkBPM init 90

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        instr breaks
            beatScorelineS( "AmenBreakDiskin", 0, 8, {{ 4 }} )

        endin

        instr breaks2
            beatScorelineS( "funkyDrummerBreakDiskin", 0, 8, {{ 4 }} )

        endin
    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 90 #

        m section1
            t 0 [$bpm]

            i "AmenBreakPan" 0 32 100 0
            i "funkyDrummerBreakPan" 0 32 0 100

            i "AmenBreakBassKnob" 0 4 0 8
            i "AmenBreakBassKnob" + 4 8 1

            i "AmenBreakMidKnob" 8 4 0 15
            i "AmenBreakMidKnob" + 4 15 1

            i "AmenBreakHighKnob" 16 4 0 20
            i "AmenBreakHighKnob" + 4 20 1

            i "breaks" 0 8
            i "breaks" + 8
            i "breaks" + 8
            i "breaks" + 8
            i "breaks" + 8

            i "funkyDrummerBreakHighKnob" 0 4 0 20
            i "funkyDrummerBreakHighKnob" + 4 20 1

            i "funkyDrummerBreakBassKnob" 8 4 0 8
            i "funkyDrummerBreakBassKnob" + 4 8 1

            i "funkyDrummerBreakMidKnob" 16 4 0 15
            i "funkyDrummerBreakMidKnob" + 4 15 1


            i "breaks2" 0 8
            i "breaks2" + 8
            i "breaks2" + 8
            i "breaks2" + 8
            i "breaks2" + 8
        s


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
