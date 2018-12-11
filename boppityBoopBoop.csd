<CsoundSynthesizer>

    <CsOptions>
        -odac -Ma  -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRouting.orc"
        
        giBPM = 120
        
        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        massign 2, "ChorusedSynthQuarterTone"
        massign 3, "ChorusedSynthMidiIn"

    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #
        m beat1

        t 0 200
        i "Reverb1DelayKnob" 0 0.1 1 1
        i "Reverb1CutoffKnob" 0 0.1 .100 300
        { 6 loopCNT
            ;Beat 1
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       1     "kick"          0.75    .5 0
                i "LinnDrum" ^+0.222      1     "kick"          1    .5 0
                i "LinnDrum" ^+0.222      1     "kick"          1    .5 0
                i "LinnDrum" ^+0.222      1     "kick"          1    .5 0

                i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       4     "Crash"          0.5    .1 0
                    


            ;Beat 2
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "kick"          1    .5 0
               i "LinnDrum" ^+0.5      1     "kick"          1    .5 0 

               i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "Rimshot4"          1    .5 0
               
                
                
                
                

            ;Beat 3
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       4     "Ride"          0.3    .1 0
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "Rimshot4"          1    .5 0
            
                
            ;Beat 4
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "kick"          1    .5 1
                
        }
        s

        ;n beat1


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
