<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"

        giBPM = 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        instr pattern1
            scoreline_i beatScoreline( "fruityGranulizer", 0, 8, {{ "robSmithDooDoo.wav" 5 1 }} )
            ;scoreline_i beatScoreline( "fruityGranulizer", 0, 8, {{ "../instruments/TR808/RolandTR-808/KickDrum5.aif" 5 1 }} )


            ;scoreline_i beatScoreline( "AmenBreakDiskgrain", 0, 8, {{ 10 1 .8 0 }} )
        endin


    </CsInstruments>

    <CsScore>

        #define bpm # 100 #


            m section0
                t 0 [$bpm]

                i "pattern1" + 8


            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
