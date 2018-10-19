<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        sr = 44100          ; audio sampling rate is 44.1 kHz
        kr = 4410           ; control rate is 4410 Hz
        ksmps = 10          ; number of samples in a control period (sr/kr)
        nchnls = 2          ; number of channels of audio output
        0dbfs = 10           ;

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"


    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 8 #

        #define bpm # 150 #
        #define amenFactor # $bpm / 139 #
        #define funkyDrummerFactor # $bpm / 101 #
        #define itsExpectedFactor # $bpm / 87.25 #
        #define beatsPerMeasure # 4 #

        m intro
            t 0 [$bpm]
            { 1 loopCount
                i "TR606" [($loopCount * $beatsPerMeasure) + 0]       1      "kick"          1    1 0

                i "TR606" [($loopCount * $beatsPerMeasure) + 1]       1      "kick"          1    1 0

                i "TR606" [($loopCount * $beatsPerMeasure) + 2]       1      "kick"          1    1 0

                i "TR606" [($loopCount * $beatsPerMeasure) + 3]       1      "kick"          1    1 0
            }

        s
        m beat1
            ;i "AmenBPMsetter" 0 1 [$amenFactor]
            t 0 [$bpm]

            
            i "AmenBreakFader" 0 0.1 .5 .5
            i "funkyDrummerBreakFader" 0 0.1 .5 .5
            
            { 2 loopCount
                i "AmenBreakPan" + 8 100 0
                i "funkyDrummerBreakPan" + 8 0 100
                i "AmenBreakPan" + 8 0 100
                i "funkyDrummerBreakPan" + 8 100 0
            }
            
            { 4 loopCount
                i "itsExpectedBreakDiskin" + 4 [$itsExpectedFactor] 0
                i "itsExpectedBreakDiskin" + 4 [$itsExpectedFactor] 8
                
                i "AmenBreakDiskin" + 4 [$amenFactor] 4
                i "AmenBreakDiskin" + 2 [$amenFactor] 6
                i "AmenBreakDiskin" + 1.5 [$amenFactor] 6
                i "AmenBreakDiskin" + .25 [$amenFactor] 3
                i "AmenBreakDiskin" + .125 [$amenFactor] 3
                i "AmenBreakDiskin" + .125 [$amenFactor] 3
                
                i "funkyDrummerBreakDiskin" + 8 [$funkyDrummerFactor] 0
            }
        s
        

            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
