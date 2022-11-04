<CsoundSynthesizer>
  <CsOptions>
    ; This file is meant to serve as place to quickly sketch out ideas or to work on
    ; instruments and opcodes outside of the context of any particular song. Nothing
    ; in this file should be considered permanent or stable.
    -odac
    ; --midi-device=a
    --messagelevel=0
    -B512 -b256
    -t96
    ;--midioutfile=midiout.mid
    ; -W -o "RNF Drums.wav"
    ; -iadc
    ; --realtime
    ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
    ; -B4096 -b4096
    ;-F midiout.mid
    ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "instruments/DrumKits/BirdshitDrumKit.orc"
    ; #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    ; #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"
    #include "patterns/AmericasSecondMostBlunted.orc"
    #include "patterns/GrainDelayTests.orc"

    ; General Instrument Inclusions
    $BREAK_SAMPLE(AmenBreak'Mixer'localSamples/amenBreak.wav'16)
    $BREAK_SAMPLE(FunkyDrummerBreak'Mixer'localSamples/funkyDrummerBreak.wav'32)
    #include "instruments/DelayHiHat.orc"
    #include "instruments/TwistedUpHatExample.orc"
    #include "instruments/TwistedUpKickExample.orc"

    instr config
      giCurrentSong = 1
      giDrumSampleReleaseTime = 0.05
      ; gkAmenBreakFader = 4
      ; gkFunkyDrummerBreakFader = 4
      gkKickFader = 1
      gkKickEqBass = 1.25

      midiMonitor
    endin

    giSequencerTable1 ftgenonce 0,  0,  16,  -2,  12, 24, 12, 14, 15, 12, 0, 12, 12, 24, 12, 14, 15, 6, 13, 16 ; sequencer (pitches are 6.00 + p/100)
    giAccentTable1 ftgenonce 0,  0,  32,  -2,   0,  1,  0,  0,  0,  0, 0,  0,  0,  1,  0,  1,  1, 1,  0,  0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1; accent sequence
    giDurationTable1 ftgenonce 0,  0,  16,  -2,   2,     1,  1,  2,    1,  1,  1,  2,     1,  1, 3,       1, 4, 0, 0, 0; fill with zeroes till next power of 2

    giSequencerTable2 ftgenonce 0,  0,  8,  -2,   10, 0, 12, 0, 7, 10, 12, 7; sequencer (pitches are 6.00 + p/100)
    giAccentTable2 ftgenonce 0,  0,  16,  -2,   1, 0,  0, 0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0; accent sequence
    giDurationTable2 ftgenonce 0,  0,  2,  -2,   16, 0; fill with zeroes till next power of 2

    giSequencerTable3 ftgenonce 0,  0,  8,  -2,   0, 12, 0, 0, 12, 0, 0, 12
    giAccentTable3 ftgenonce 0,  0,  8,  -2,   1,  1, 1, 1,  1, 1, 1,  1
    giDurationTable3 ftgenonce 0,  0,  8,  -2,   1,  1, 1, 1,  1, 1, 1,  1

    $TB_303(TB303'Mixer)

    instr TB303Test
      $PATTERN_LOOP(60)
        _ "TB303", i0, 20, .1, .3, .2, .2, .1, .4, .05, .8, 0, 0, \
        120, 2, giSequencerTable2, giAccentTable2, giDurationTable2, 127

        _ "TB303", i0+00, 20, 0 , 1, .5 , 1 , .1, .4, 1 , 1 , 1 , 1, \
          120, 0,  giSequencerTable1,  giAccentTable1,  giDurationTable1,  60

        _ "TB303", i0+20, 40, .2, 1, .5 , 1 , .1, .1, .5, 1 , .5, 1, \
          120, 2,  giSequencerTable2,  giAccentTable2,  giDurationTable2, 127

        _ "TB303", i0+40, 20, .5, 1, .95, 1 , 1 , .9, 1 , .1, .5, 1, \
          120, 0,  giSequencerTable1,  giAccentTable1,  giDurationTable1,  60

        _ "TB303", i0+30, 30, .5, 1, .5 , .5, .5, .5, .5, .5, 0 , 0, \
          120, 0, giSequencerTable3, giAccentTable3, giDurationTable3, 100




      $END_PATTERN_LOOP
    endin

    instr WorkingPattern
      $PATTERN_LOOP(4)
        _ "DefaultClosedHat", i0, 1, 100, 1
        _ "DefaultClosedHat", i0+1, 1, 100, 1
        _ "DefaultClosedHat", i0+2, 1, 100, 1
        _ "DefaultClosedHat", i0+3, 1, 100, 1
      $END_PATTERN_LOOP
    endin
  </CsInstruments>

  <CsScore>
    ; i "Metronome" 0 3600
    i "config" 0 -1
    ; i "WorkingPattern" 0 264

    i "Section" + 72 "TB303Test"
  </CsScore>
</CsoundSynthesizer>
