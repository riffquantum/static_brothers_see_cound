<CsoundSynthesizer>

  <CsOptions>
    -odac
--midi-device=a
--messagelevel=0
    ; -W -o "GiantSteps.wav
    -iadc
    ; -B512 -b60
    -t250
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "SimpleOscillator.orc"

    instr MainRiff
        iRiffVelocity = 100

        ;measure 0
        ;beatScoreline "SimpleOscillator", 0.0, 1.0, iRiffVelocity, 8
        beatScoreline "SimpleOscillator", 0.0, 2.0, iRiffVelocity, 5.10
        beatScoreline "SimpleOscillator", 2.0, 2.0, iRiffVelocity, 5.06 ;D

        ;measure 1
        beatScoreline "SimpleOscillator", 4.0, 2.0, iRiffVelocity, 5.03 ;B
        beatScoreline "SimpleOscillator", 6.0, 1.5, iRiffVelocity, 4.11 ;G
        beatScoreline "SimpleOscillator", 7.5, 4.5, iRiffVelocity, 5.02 ;A#

        ;measure 2

        ;measure 3
        beatScoreline "SimpleOscillator", 12, 1.5, iRiffVelocity, 5.03 ;B
        beatScoreline "SimpleOscillator", 13.5, 2.5, iRiffVelocity, 5.01 ;A

        ;measure 4

        beatScoreline "SimpleOscillator", 16, 2.0, iRiffVelocity, 5.06 ;D
        beatScoreline "SimpleOscillator", 18, 2.0, iRiffVelocity, 5.02 ;A#

        ;measure 5
        beatScoreline "SimpleOscillator", 20, 2.0, iRiffVelocity, 4.11 ;G
        beatScoreline "SimpleOscillator", 22, 1.5, iRiffVelocity, 4.07 ;D#
        beatScoreline "SimpleOscillator", 23.5, 4.5, iRiffVelocity, 4.10 ;F#

        ;measure 6

        ;measure 7
        beatScoreline "SimpleOscillator", 28, 2.0, iRiffVelocity, 4.11 ; G
        beatScoreline "SimpleOscillator", 30, 1.5, iRiffVelocity, 4.09 ; F
        beatScoreline "SimpleOscillator", 31.5, 4.5 , iRiffVelocity, 5.02 ; F

        ;measure 8

        ;measure 9
        beatScoreline "SimpleOscillator", 36, 2.0, iRiffVelocity, 5.03 ; B
        beatScoreline "SimpleOscillator", 38, 1.5, iRiffVelocity, 5.01 ; A
        beatScoreline "SimpleOscillator", 39.5, 4.5 , iRiffVelocity, 5.06 ; D

        ;measure 10

        ;measure 11

        beatScoreline "SimpleOscillator", 44, 2.0, iRiffVelocity, 5.07 ; D#
        beatScoreline "SimpleOscillator", 46, 1.5, iRiffVelocity, 5.05 ; C#
        beatScoreline "SimpleOscillator", 47.5, 2.5 , iRiffVelocity, 5.10 ; F#

        ;measure 12
        beatScoreline "SimpleOscillator", 50, 2.0, iRiffVelocity, 5.10 ; F#

        ;measure 13
        beatScoreline "SimpleOscillator", 52, 2.0, iRiffVelocity, 5.11 ; G
        beatScoreline "SimpleOscillator", 54, 1.5, iRiffVelocity, 5.09 ; F
        beatScoreline "SimpleOscillator", 55.5, 4.5, iRiffVelocity, 6.02 ; F#

        ;measure 14

        ;measure 15
        beatScoreline "SimpleOscillator", 60, 1.5, iRiffVelocity, 5.10 ; F#
        beatScoreline "SimpleOscillator", 61.5, 2.5, iRiffVelocity, 5.10 ; F
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

        iChordVolume = 40

        ;Measure 1
        majorSeventhChord "SimpleOscillator", 0, 1.5, iChordVolume, 3.03

        dominantSeventhChord "SimpleOscillator", 2, 1.5, iChordVolume, 3.06

        majorSeventhChord "SimpleOscillator", 4, 1.5, iChordVolume, 3.11

        thirteenthChord "SimpleOscillator", 6, 1.5, iChordVolume, 3.02

        majorChord "SimpleOscillator", 8, 1.5, iChordVolume, 3.07
        majorChord "SimpleOscillator", 10, 1.5, iChordVolume, 3.07

        minorSeventhChord "SimpleOscillator", 12, 1.5, iChordVolume, 3.01

        dominantSeventhChord "SimpleOscillator", 14, 1.5, iChordVolume, 3.06

        ;Measure 5
        majorSeventhChord "SimpleOscillator", 16, 1.5, iChordVolume, 3.11

        dominantSeventhChord "SimpleOscillator", 18, 1.5, iChordVolume, 3.02

        majorSeventhChord "SimpleOscillator", 20, 1.5, iChordVolume, 3.07

        dominantSeventhChord "SimpleOscillator", 22, 1.5, iChordVolume, 3.10

        majorSeventhChord "SimpleOscillator", 24, 1.5, iChordVolume, 3.03
        majorSeventhChord "SimpleOscillator", 26, 1.5, iChordVolume, 3.03

        minorSeventhChord "SimpleOscillator", 28, 1.5, iChordVolume, 3.09

        dominantSeventhChord "SimpleOscillator", 30, 1.5, iChordVolume, 3.02

        ;Measure 9
        majorSeventhChord "SimpleOscillator", 32, 1.5, iChordVolume, 3.07

        majorSeventhChord "SimpleOscillator", 34, 1.5, iChordVolume, 3.07

        minorSeventhChord "SimpleOscillator", 36, 1.5, iChordVolume, 3.01

        dominantSeventhChord "SimpleOscillator", 38, 1.5, iChordVolume, 3.06

        majorSeventhChord "SimpleOscillator", 40, 1.5, iChordVolume, 3.11
        majorSeventhChord "SimpleOscillator", 42, 1.5, iChordVolume, 3.11

        minorSeventhChord "SimpleOscillator", 44, 1.5, iChordVolume, 3.05

        dominantSeventhChord "SimpleOscillator", 46, 1.5, iChordVolume, 3.10

        ;Measure 13
        majorSeventhChord "SimpleOscillator", 48, 1.5, iChordVolume, 3.03

        majorSeventhChord "SimpleOscillator", 50, 1.5, iChordVolume, 3.03

        minorSeventhChord "SimpleOscillator", 52, 1.5, iChordVolume, 3.09

        dominantSeventhChord "SimpleOscillator", 54, 1.5, iChordVolume, 3.02

        majorSeventhChord "SimpleOscillator", 56, 1.5, iChordVolume, 3.07
        majorSeventhChord "SimpleOscillator", 58, 1.5, iChordVolume, 3.07

        minorSeventhChord "SimpleOscillator", 60, 1.5, iChordVolume, 3.05

        dominantSeventhChord "SimpleOscillator", 62, 1.5, iChordVolume, 3.10
    endin

  </CsInstruments>

  <CsScore>
    ; 1  2  3  4  5  6  7  8  9  10  11 12
    ; A  A# B  C  C# D  D# E  F  F#  G  G#
    ; C# D  D# E  F  F# G  G# A  A#  B  C
    i "MainRiff" 0 64
    i "ChordProgression" 0 64
    i "MainRiff" 64 64
    i "ChordProgression" 64 64

  </CsScore>
</CsoundSynthesizer>
