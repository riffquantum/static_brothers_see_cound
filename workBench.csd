<CsoundSynthesizer>
  <CsOptions>
      /*
      * This file is meant to serve as place to quickly sketch out ideas or to work on
      * instruments and opcodes outside of the context of any particular song. Nothing
      * in this file should be considered permanent or stable.
      */
      -odac
      ; -W -o "newLoop.wav"
      --midi-device=a
      --messagelevel=0
      ; -iadc
      ; --realtime
      -B512 -b256
      ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
      ; -B4096 -b4096
      -t170     ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "patterns/pattern-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "instruments/DrumKits/BirdshitDrumKit.orc"
    ; #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    ; #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"

    ; $BREAK_SAMPLE(TestInstrument'DefaultEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop3.wav'24)

    instr config
      gkNewInstrumentEqHigh = 0
      gkNewInstrumentEqMid = 2
      gkNewInstrumentEqBass = 0
    endin


    $MIXER_CHANNEL(SmallSynth)
    instrumentRoute("SmallSynth", "Mixer")
    instr SmallSynth
      iAmplitude flexibleAmplitudeInput p4
      iPitch = flexiblePitchInput(p5)

      kAmplitudeEnvelope madsr .025, .01, 1, .2

      aSignalL = poscil(iAmplitude, iPitch * 1.01) * kAmplitudeEnvelope
      aSignalR = poscil(iAmplitude, iPitch * 0.99) * kAmplitudeEnvelope

      outleta "OutL", aSignalL
      outleta "OutR", aSignalR
    endin

    #define NEW_SETTINGS #
      ; kTimeStretch = 1.33
      ; kGrainSizeAdjustment = 0.5 ;+ oscil(0.25, 0.5)
      ; kGrainFrequencyAdjustment = 1.5 + oscil(0.25, 0.5)
      ; kPitchAdjustment = 0.75 + oscil(0.05, 2)
      ; kGrainOverlapPercentageAdjustment = 0.9
    #

    $SYNCLOOP_SAMPLER(Lose'Mixer'localSamples/Soul Searchers - All In Your Mind Loop 3.wav'$NEW_SETTINGS'4)

    $DRUM_SAMPLE(Kick'Mixer'localSamples/Drums/Alesis-HR16A_Kick_05.wav'1'1)
    $DRUM_SAMPLE(Kick909'Mixer'localSamples/Drums/TR-909_Kick_EA7409.wav'1'1)

    $DRUM_SAMPLE(Cowbell'Mixer'localSamples/Drums/TR-808_Cowbell_EA7327.wav'0'1)


    instr WorkingPattern
      gkCowbellFader = 0.5
      gkKickFader = 0.75
      gkAmenBreakFader = 1.25

      $PATTERN_LOOP(8)
        ; _ "AmenBreak", i0+1.0, .5, 120, 1, 10.5
        ; _ "AmenBreak", i0+1.5, .5, 120, 1, 10.5
        ; _ "AmenBreak", i0+2.0, .5, 120, 1, 11.5
        ; _ "AmenBreak", i0+2.5, .5, 120, 1, 10.
        ; _ "Lose", i0, 8, 120, 3.0, 3

        _ "AmenBreak", i0+0.0, 1.0, 120, 1, 10.5
        _ "Kick909", i0+0.0, 1.0, 120, 0.8
        ; _ "AmenBreak", i0+0.5, 1.0, 120, 1, 10.5
        _ "AmenBreak", i0+1.0, 1.0, 120, 1, 10.5
        _ "Kick909", i0+1.0, 1.0, 120, 0.8
        _ "AmenBreak", i0+2.0,1.0, 120, 1, 11.5
        _ "AmenBreak", i0+3.0, 1.0, 120, 1, 11.5

        _ "Kick909", i0+3, 1.0, 120, 0.8

        _ "AmenBreak", i0+4.0, 1.0, 120, 1, 10.5
        _ "Kick909", i0+4.0, 1.0, 120, 0.8
        _ "AmenBreak", i0+5.0, 1.25, 120, 1, 12
        _ "AmenBreak", i0+6.0, 2.0, 120, 1, 12
        ; _ "AmenBreak", i0+0.0, 0.5, 120, 1, 14.5
        ; _ "AmenBreak", i0+0.5, 0.5, 120, 1, 14.5
        ; _ "AmenBreak", i0+1.0, .75, 120, 1, 11.5
        ; _ "AmenBreak", i0+1.5, .75, 120, 1, 11.5
        ; _ "AmenBreak", i0+2.0, 2, 120, 1, 11.5
        ; _ "AmenBreak", i0+1.5, 0.5, 120, 1, 11.5
        ; _ "AmenBreak", i0+1.75, 0.5, 120, 1, 10.5
        ; _ "AmenBreak", i0+0.0, 3.0, 120, 1, 12
        ; _ "AmenBreak", i0+3.0, 1.0, 120, 1, 12

        ; _ "AmenBreak", i0+2.0, 2, 120, 1, 12

        _ "Kick", i0+0.0, 2, 120, .95
        _ "Kick", i0+3.5, 2, 120, .9
        _ "Kick", i0+6, 2, 120, .75

        _ "Cowbell", i0+1, 2, 20, .75
        _ "Cowbell", i0+1.5, 2, 80, .75
        _ "Cowbell", i0+3, 2, 80, .75
        _ "Cowbell", i0+4.5, 2, 80, .75
        _ "Cowbell", i0+5.5, 2, 80, .75
        _ "Cowbell", i0+7, 2, 80, .75

        ; _ "DefaultKick", i0+2.5, 1, 120, 0.75
        ; _ "DefaultKick", i0+2, 1, 120, 1
        ; _ "DefaultKick", i0+3, 1, 120, 1

        ; _ "DefaultSnare", i0+1, 1, 80, .8
        ; _ "DefaultSnare", i0+3, 1, 80, .8

        ; _ "SmallSynth", i0, 3, 120, iMeasureCount % 4 == 0 ? 2.11 : 3.01

        if iMeasureCount % 2 != 0 then
          _ "Lose", i0+0, 8, 58, 2.090000, 1, 24, 50
          _ "Lose", i0+8, 8, 58, 2.090000, 1
          ; _ "Lose", i0+1.921011, 1.027023, 58, 4.040000
          ; _ "Lose", i0+2.993265, 0.940550, 58, 5.000000
        endif
      $END_PATTERN_LOOP

      ; midiMonitor
    endin

    beatScoreline "config", 0, -1
    beatScoreline "PatternWriter", 0, -1, 4
  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600

    i "WorkingPattern" 1 256
    ; i "Break" 0 400
  </CsScore>
</CsoundSynthesizer>
