#include "../instruments/DrumKits/HeavyMetalDrumKit.orc"

instr HeavyMetalDrumIdeas
  ; localSamples/Drums/Alesis-HR16A_Snare_42.wav
  giDistorted808KickFinalGainAmount = .75
  gkDistorted808KickPreGain = 25

  $PATTERN_LOOP(5)
    ; _ "Distorted808Kick", i0+0, 2, 50, .5
    ; _ "Distorted808Kick", i0+0, 2, 40, .75
    ; _ "HMKick", i0+0, 2, 100, 1
    _ "HMAggKick", i0+0, 2, 70, 1
    _ "HMAggKick", i0+2, 2, 70, 1


    _ "HMLoudSnare", i0, 1, 100, 1
    _ "HMHighSnare", i0, 1, 100, .5

    _ "HMLoudSnare", i0+3, 1, 100, 1
    _ "HMHighSnare", i0+3, 1, 100, .5

    if iMeasureCount % 4 == 0 then
      _ "HMOpenHat1", i0+3, .5, 120, 1.0
    elseif iMeasureCount % 2 == 0 then
    endif
    ; _ "TwistedUpHatExample", i0, 5, 80, 4.0

    _ "HMClosedHat2", i0+0, .5, 120, 1
    _ "HMClosedHat2", i0+1, .5, 120, 1
    _ "HMClosedHat2", i0+2, .5, 120, 1
    _ "HMClosedHat2", i0+3, .5, 120, 1
    _ "HMClosedHat2", i0+4, .5, 120, 1
    ; _ "HMSnare", i0+1, 1, 120, 1
    ; _ "HMKick", i0+.666, .333, 100, 1

    ; _ "HMAmenBreak", i0, .5, 120, 1, 10
    ; _ "HMAmenBreak", i0+.333, .333, 120, 1, 14
    ; _ "HMAmenBreak", i0+.666, .666, 120, 1, 14

    ; _ "HMKick", i0+1.0, .333, 120, 1
    ; _ "HMKick", i0+1.333, .333, 100, 1
    ; _ "HMKick", i0+1.666, .333, 100, 1

    ; _ "HMKick", i0+2, .333, 100, 1
    ; _ "HMKick", i0+2.666, .333, 100, 1
    ; _ "HMKick", i0+4.666, .333, 100, 1
    ; _ "HMKick", i0+5.333, .333, 100, 1

    ; _ "HMAmenBreak", i0+0, .75, 120, 1, 2.5
    ; _ "HMAmenBreak", i0+.75, .75, 120, 1, 2.5
    ; _ "HMAmenBreak", i0+1.5, .75, 120, 1, 2.5
    ; _ "HMAmenBreak", i0+2.25, .75, 120, 1, 1.25
    ; _ "HMAmenBreak", i0+3, 1, 120, 1, 1.25
    ; _ "HMAmenBreak", i0+3, 1, 120, 1, 1.25
    ; _ "HMAmenBreak", i0+4, 1, 120, 1, 1.25
  $END_PATTERN_LOOP
endin
