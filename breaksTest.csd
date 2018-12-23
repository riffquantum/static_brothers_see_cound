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
            scoreline_i beatScoreline( "thinkBreakDiskin", 0, 4, {{ 0 0 }} )
            scoreline_i beatScoreline( "thinkBreakDiskin", 4, 4, {{ 0 0 }} )
            scoreline_i beatScoreline( "sinkingBreakDiskin", 0, 8, {{ 0 0 }} )
            scoreline_i beatScoreline( "AmenBreakDiskin", 0, 8, {{ 4 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 0, 8, {{ 4 }} )
            scoreline_i beatScoreline( "gettinHappyBreakDiskin", 0, 8, {{ 4 }} )
            scoreline_i beatScoreline( "itsExpectedBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "hairOfTheDogBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "handInTheHandBreakDiskin", 0, 8, {{ 0 1 }} )
            scoreline_i beatScoreline( "gumboBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "closeToMeBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "loserInTheEndBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "tastyCakesBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "tenThousandYearsBreakDiskin", 0, 8, {{ 0 }} )
            scoreline_i beatScoreline( "transformationDayBreakDiskin", 0, 8, {{ 0 }} )
        endin


    </CsInstruments>

    <CsScore>

        #define bpm # 170 #


            m section0
                t 0 [$bpm]

                i "breaks" + 8
                i "breaks" + 8

                i "breaks" + 8
                i "breaks" + 8

            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
