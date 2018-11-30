<CsoundSynthesizer>

    <CsOptions>
        -odac
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        
        giBPM = 120

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"


    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 8 #
        m beat1

         t 0 152
        
        i "LinnDrumPan" 0 16 100 0 
        i "TR808Pan" 0 16 0 100

        { 16 loopCNT
            i "LinnDrum" +       1    "kick"          1    1 0
            i "LinnDrum" +       1    "kick"          1    1 0
            i "LinnDrum" ^       1    "Snare5"          1    1 0
            i "LinnDrum" +       1    "kick"          1    1 0
            i "LinnDrum" +       1    "Snare5"          1    1 0
            i "LinnDrum" ^       .5    "kick"          1    1 0
            i "LinnDrum" +       .5    "kick"          1    1 0
        }

        { 16 loopCNT
            i "TR808" +       1    "KickDrum0003"          1    1 0
            i "TR808" +       1    "KickDrum0003"          1    1 0
            i "TR808" ^       1    "SnareDrum0003"          1    1 0
            i "TR808" +       1    "KickDrum0003"          1    1 0
            i "TR808" +       1    "SnareDrum0003"          1    1 0
            i "TR808" ^       .5    "KickDrum0003"          1    1 0
            i "TR808" +       .5    "KickDrum0003"          1    1 0
        }

        { 4 loopCNT
            i "AmenBreak2" + 4 1
            i "AmenBreak2" + 4 1
            i "AmenBreak2" + 8 1
        }
        

        
        
        s


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
