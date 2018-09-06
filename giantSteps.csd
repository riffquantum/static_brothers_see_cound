<CsoundSynthesizer>

    <CsOptions>
        -odac
    </CsOptions>

    <CsInstruments>
        sr = 48000          ; audio sampling rate is 44.1 kHz
        kr = 4800           ; control rate is 4410 Hz
        ksmps = 10          ; number of samples in a control period (sr/kr)
        nchnls = 2          ; number of channels of audio output
        0dbfs = 10          ;

        #include "instruments/collected-orchestra.orc"

    </CsInstruments>

    <CsScore>
        ; 1  2  3  4  5  6  7  8  9  10  11 12
        ; A  A# B  C  C# D  D# E  F  F#  G  G#
        t 0 200
        ;measure 0
            ; instrument             start    dur               amp      pitch
        i "ChorusedSynth" 0 1 .5 8            
        i "ChorusedSynth" 0    2     0.5        8.10 
        i "ChorusedSynth"  +        2                  0.5    8.06 ;D


        ;measure 1
        i "ChorusedSynth"  +        2                  0.5    8.03 ;B
        i "ChorusedSynth"  +        1.5      0.5    7.11 ;G
        i "ChorusedSynth"  +        4.5     0.5    8.02 ;A#

        ;measure 2

        ;measure 3
        i "ChorusedSynth"  +        1.5   0.5    8.03 ;B
        i "ChorusedSynth"  +        2.5      0.5    8.01 ;A

        ;measure 4

        i "ChorusedSynth"  +        2                  0.5    8.06 ;D
        i "ChorusedSynth"  +        2                  0.5    8.02 ;A#

        ;measure 5
        i "ChorusedSynth"  +        2                  0.5    7.11 ;G
        i "ChorusedSynth"  +        1.5      0.5    7.07 ;D#
        i "ChorusedSynth"  +        4.5     0.5    7.10 ;F#

        ;measure 6

        ;measure 7
        i "ChorusedSynth" +           2                  0.5    7.11 ; G
        i "ChorusedSynth" +           1.5        0.5    7.09 ; F
        i "ChorusedSynth" +           4.5         0.5    8.02 ; F

        ;measure 8

        ;measure 9
        i "ChorusedSynth" +           2                  0.5    8.03 ; B
        i "ChorusedSynth" +           1.5        0.5    8.01 ; A
        i "ChorusedSynth" +           4.5         0.5    8.06 ; D

        ;measure 10

        ;measure 11

        i "ChorusedSynth" +           2                  0.5    8.07 ; D#
        i "ChorusedSynth" +           1.5        0.5    8.05 ; C#
        i "ChorusedSynth" +           2.5         0.5    8.10 ; F#

        ;measure 12
        i "ChorusedSynth" +           2                  0.5    8.10 ; F#

        ;measure 13
        i "ChorusedSynth" +           2                     0.5    8.11 ; G
        i "ChorusedSynth" +           1.5        0.5    8.09 ; F
        i "ChorusedSynth" +           4.5         0.5    9.02 ; F#

        ;measure 14

        ;measure 15
        i "ChorusedSynth" +           1.5        0.5    8.10 ; F#
        i "ChorusedSynth" +           2.5         0.5   8.10 ; F



    </CsScore>

</CsoundSynthesizer>
