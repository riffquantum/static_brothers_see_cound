<CsoundSynthesizer>

    <CsOptions>
        -odac -m0 -t250
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        gkBPM init 250

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        instr MainRiff
            ;measure 0
            ;beatScoreline "SimpleOscillator", 0.0, 1.0, 0.5, 8
            beatScoreline "SimpleOscillator", 0.0, 2.0, 0.5, 9.10
            beatScoreline "SimpleOscillator", 2.0, 2.0, 0.5, 9.06 ;D

            ;measure 1
            beatScoreline "SimpleOscillator", 4.0, 2.0, 0.5, 9.03 ;B
            beatScoreline "SimpleOscillator", 6.0, 1.5, 0.5, 8.11 ;G
            beatScoreline "SimpleOscillator", 7.5, 4.5, 0.5, 9.02 ;A#

            ;measure 2

            ;measure 3
            beatScoreline "SimpleOscillator", 12, 1.5, 0.5, 9.03 ;B
            beatScoreline "SimpleOscillator", 13.5, 2.5, 0.5, 9.01 ;A

            ;measure 4

            beatScoreline "SimpleOscillator", 16, 2.0, 0.5, 9.06 ;D
            beatScoreline "SimpleOscillator", 18, 2.0, 0.5, 9.02 ;A#

            ;measure 5
            beatScoreline "SimpleOscillator", 20, 2.0, 0.5, 8.11 ;G
            beatScoreline "SimpleOscillator", 22, 1.5, 0.5, 8.07 ;D#
            beatScoreline "SimpleOscillator", 23.5, 4.5, 0.5, 8.10 ;F#

            ;measure 6

            ;measure 7
            beatScoreline "SimpleOscillator", 28, 2.0, 0.5, 8.11 ; G
            beatScoreline "SimpleOscillator", 30, 1.5, 0.5, 8.09 ; F
            beatScoreline "SimpleOscillator", 31.5, 4.5 , 0.5, 9.02 ; F

            ;measure 8

            ;measure 9
            beatScoreline "SimpleOscillator", 36, 2.0, 0.5, 9.03 ; B
            beatScoreline "SimpleOscillator", 38, 1.5, 0.5, 9.01 ; A
            beatScoreline "SimpleOscillator", 39.5, 4.5 , 0.5, 9.06 ; D

            ;measure 10

            ;measure 11

            beatScoreline "SimpleOscillator", 44, 2.0, 0.5, 9.07 ; D#
            beatScoreline "SimpleOscillator", 46, 1.5, 0.5, 9.05 ; C#
            beatScoreline "SimpleOscillator", 47.5, 2.5 , 0.5, 9.10 ; F#

            ;measure 12
            beatScoreline "SimpleOscillator", 50, 2.0, 0.5, 9.10 ; F#

            ;measure 13
            beatScoreline "SimpleOscillator", 52, 2.0, 0.5, 9.11 ; G
            beatScoreline "SimpleOscillator", 54, 1.5, 0.5, 9.09 ; F
            beatScoreline "SimpleOscillator", 55.5, 4.5, 0.5, 10.02 ; F#

            ;measure 14

            ;measure 15
            beatScoreline "SimpleOscillator", 60, 1.5, 0.5, 9.10 ; F#
            beatScoreline "SimpleOscillator", 61.5, 2.5, 0.5, 9.10 ; F
        endin

        instr ChordProgression
            ; majorChord "SimpleOscillator", 0, 3.5, 1, 6.0
            ; minorChord "SimpleOscillator", 4, 3.5, 1, 6.0
            ; majorSeventhChord "SimpleOscillator", 8, 3.5, 1, 6.0
            ; minorSeventhChord "SimpleOscillator", 12, 3.5, 1, 6.0
            ; dominantSeventhChord "SimpleOscillator", 16, 3.5, 1, 6.0
            ; powerChord "SimpleOscillator", 20, 3.5, 1, 6.0
            ; augmentedFifthChord "SimpleOscillator", 24, 3.5, 1, 6.0
            ; diminishedFifthChord "SimpleOscillator", 28, 3.5, 1, 6.0
            ; halfDiminishedSeventhChord "SimpleOscillator", 32, 3.5, 1, 6.0

            iChordVolume = 1

            ;Measure 1
            majorSeventhChord "SimpleOscillator", 0, 1.5, iChordVolume, 7.03

            dominantSeventhChord "SimpleOscillator", 2, 1.5, iChordVolume, 7.06

            majorSeventhChord "SimpleOscillator", 4, 1.5, iChordVolume, 7.11

            thirteenthChord "SimpleOscillator", 6, 1.5, iChordVolume, 7.02

            majorChord "SimpleOscillator", 8, 1.5, iChordVolume, 7.07
            majorChord "SimpleOscillator", 10, 1.5, iChordVolume, 7.07

            minorSeventhChord "SimpleOscillator", 12, 1.5, iChordVolume, 7.01

            dominantSeventhChord "SimpleOscillator", 14, 1.5, iChordVolume, 7.06

            ;Measure 5
            majorSeventhChord "SimpleOscillator", 16, 1.5, iChordVolume, 7.11

            dominantSeventhChord "SimpleOscillator", 18, 1.5, iChordVolume, 7.02

            majorSeventhChord "SimpleOscillator", 20, 1.5, iChordVolume, 7.07

            dominantSeventhChord "SimpleOscillator", 22, 1.5, iChordVolume, 7.10

            majorSeventhChord "SimpleOscillator", 24, 1.5, iChordVolume, 7.03
            majorSeventhChord "SimpleOscillator", 26, 1.5, iChordVolume, 7.03

            minorSeventhChord "SimpleOscillator", 28, 1.5, iChordVolume, 7.09

            dominantSeventhChord "SimpleOscillator", 30, 1.5, iChordVolume, 7.02

            ;Measure 9
            majorSeventhChord "SimpleOscillator", 32, 1.5, iChordVolume, 7.07

            majorSeventhChord "SimpleOscillator", 34, 1.5, iChordVolume, 7.07

            minorSeventhChord "SimpleOscillator", 36, 1.5, iChordVolume, 7.01

            dominantSeventhChord "SimpleOscillator", 38, 1.5, iChordVolume, 7.06

            majorSeventhChord "SimpleOscillator", 40, 1.5, iChordVolume, 7.11
            majorSeventhChord "SimpleOscillator", 42, 1.5, iChordVolume, 7.11

            minorSeventhChord "SimpleOscillator", 44, 1.5, iChordVolume, 7.05

            dominantSeventhChord "SimpleOscillator", 46, 1.5, iChordVolume, 7.10

            ;Measure 13
            majorSeventhChord "SimpleOscillator", 48, 1.5, iChordVolume, 7.03

            majorSeventhChord "SimpleOscillator", 50, 1.5, iChordVolume, 7.03

            minorSeventhChord "SimpleOscillator", 52, 1.5, iChordVolume, 7.09

            dominantSeventhChord "SimpleOscillator", 54, 1.5, iChordVolume, 7.02

            majorSeventhChord "SimpleOscillator", 56, 1.5, iChordVolume, 7.07
            majorSeventhChord "SimpleOscillator", 58, 1.5, iChordVolume, 7.07

            minorSeventhChord "SimpleOscillator", 60, 1.5, iChordVolume, 7.05

            dominantSeventhChord "SimpleOscillator", 62, 1.5, iChordVolume, 7.10
        endin

    </CsInstruments>

    <CsScore>
        ; 1  2  3  4  5  6  7  8  9  10  11 12
        ; A  A# B  C  C# D  D# E  F  F#  G  G#
        
        i "MainRiff" 0 64
        i "ChordProgression" 0 64
        i "MainRiff" 64 64
        i "ChordProgression" 64 64

    </CsScore>
</CsoundSynthesizer>
