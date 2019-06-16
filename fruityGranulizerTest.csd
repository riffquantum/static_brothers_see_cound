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
            SsamplePath = "localSamples/bellMono.wav"
            iamplitude = 5
            iPitch = 1
            iStartTime = 0
            iEndTime = 0

            SparamString sprintfk {{ "%s" %f %f %f %f }}, SsamplePath, iamplitude, iPitch, iStartTime, iEndTime

            scoreline_i beatScoreline( "fruityGranulizer", 0, 16, SparamString )
        endin


    </CsInstruments>

    <CsScore>

        #define bpm # 100 #


            m section0
                t 0 [$bpm]

                i "pattern1" + 15


            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
