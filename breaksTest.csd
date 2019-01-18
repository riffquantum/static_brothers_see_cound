<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"

        giBPM = 170

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"


        instr breaks
            scoreline_i beatScoreline( "closeToMeBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "tenThousandYearsBreakDiskin", 8, 8, {{ 2 }} )
            scoreline_i beatScoreline( "sinkingBreakDiskin", 16, 8, {{ 0 0 }} )
            scoreline_i beatScoreline( "gumboBreakDiskin", 24, 8, {{ 10 }} )
            scoreline_i beatScoreline( "hairOfTheDogBreakDiskin", 32, 8, {{ 0 }} )
            scoreline_i beatScoreline( "gettinHappyBreakDiskin", 40, 8, {{ 0 }} )
            scoreline_i beatScoreline( "AmenBreakDiskin", 48, 8, {{ 4 }} )
            scoreline_i beatScoreline( "itsExpectedBreakDiskin", 56, 8, {{ 2 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 64, 8, {{ 4 }} )
            scoreline_i beatScoreline( "loserInTheEndBreakDiskin", 72, 8, {{ 2 }} )
            scoreline_i beatScoreline( "transformationDayBreakDiskin", 80, 8, {{ 0 1 }} )
            scoreline_i beatScoreline( "thinkBreakDiskin", 88, 8, {{ 2 0 }} )
            scoreline_i beatScoreline( "tastyCakesBreakDiskin", 96, 8, {{ 0 }} )
            scoreline_i beatScoreline( "handInTheHandBreakDiskin", 104, 8, {{ 6 1 }} )


        endin


    </CsInstruments>

    <CsScore>

        #define bpm # 170 #


            m section0
                t 0 [$bpm]

                i "breaks" + 112
                i "breaks" + 112

            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
