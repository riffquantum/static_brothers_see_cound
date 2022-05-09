<CsoundSynthesizer>
  <CsOptions>
      -odac
      --midi-device=a
      --messagelevel=0
      ; -W -o "Jormungandrv0.1.wav"
      ;aka Thulsa Doom Transitioning to the Afterworld by Sliding Along the Back of a Green Snake
      ;aka Thulsa Doom Transitioning Into A Serpent of Pure Spirit As His Head Rolls Down The Stairs.
      ;aka Walking Snake Way With No Intention of Resurrection
      ; -iadc
      ; --realtime
      ; -B512 -b60
      -t105
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/SnakeskinEternal/config/midiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    ; #include "config/guitarMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"

    #define SCALE_FLOW_GRAIN #
      kTimeStretch = 1 * (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = 10 * poscil(.2, .25)
      kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
      kPitchAdjustment = 1
      kGrainOverlapPercentageAdjustment = 1
    #
    $SYNCLOOP_SAMPLER(ScaleFlow'ScaleFlowEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop1.wav'$SCALE_FLOW_GRAIN'0'0)
    $EFFECT_CHAIN(ScaleFlowEffectChain'Mixer)

    #define SCALE_FLOW_GRAIN2 #
      kTimeStretch = 1 * (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = 1 * poscil(.2, .25)
      kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
      kPitchAdjustment = 1
      kGrainOverlapPercentageAdjustment = 1
    #
    $SYNCLOOP_SAMPLER(ScaleFlow2'ScaleFlowEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop2.wav'$SCALE_FLOW_GRAIN2'0'0)

    instr config
      beatScoreline "ScaleFlowEffectChainReverb", 0, -1
    endin

    instr ScaleFlowPattern1
      $PATTERN_LOOP(4)
        if iMeasureIndex % 4 == 3 then
          beatScoreline "ScaleFlow", iBaseTime, 4, 60, 3.06, 0, 0, 0, 2
        elseif iMeasureIndex % 8 == 6 then
          beatScoreline "ScaleFlow", iBaseTime, 4, 60, 3.055
        else
          beatScoreline "ScaleFlow", iBaseTime, 4, 60, 3.06
        endif
      $END_PATTERN_LOOP
    endin

    instr ScaleFlowPattern2
      $PATTERN_LOOP(14)
        repeatNotes "DefaultClosedHat", iBaseTime+0, 14, 1, 1, 30, 1
        beatScoreline "Distorted808Kick", iBaseTime+0, 4, 127, .5
        beatScoreline "Distorted808Kick", iBaseTime+4, 4, 127, .5
        beatScoreline "Distorted808Kick", iBaseTime+8, 4, 127, .5
        beatScoreline "ScaleFlow", iBaseTime, 4, 60, 3.06
        beatScoreline "ScaleFlow", iBaseTime+4, 4, 60, 3.06
        beatScoreline "ScaleFlow", iBaseTime+8, 6, 60, 3.06
      $END_PATTERN_LOOP
    endin

    ; instr ScaleFlowPattern2
    ;   $PATTERN_LOOP(21)
    ;     beatScoreline "ScaleFlow", iBaseTime, 4, 60, 3.06
    ;     beatScoreline "ScaleFlow", iBaseTime+4, 4, 60, 3.06
    ;     beatScoreline "ScaleFlow", iBaseTime+8, 4, 60, 3.06
    ;     beatScoreline "ScaleFlow", iBaseTime+12, 4, 60, 3.055
    ;     beatScoreline "ScaleFlow", iBaseTime+16, 5, 60, 3.06
    ;   $END_PATTERN_LOOP
    ; endin


    instr ScaleFlowBass1
      $PATTERN_LOOP(4)
        if iMeasureIndex % 4 == 3 then
          beatScoreline "ScaleFlow", iBaseTime+3, 1, 60, 3.11, 0, 0, 4, 3/5
        endif

        beatScoreline "ScaleFlow", iBaseTime+0, .25, 50, 3.11, 0, 0, 4
        beatScoreline "ScaleFlow", iBaseTime+1, 1, 50, 3.11, 0, 0, 4
      $END_PATTERN_LOOP
    endin

    instr ScaleFlowMelody
      $PATTERN_LOOP(8)
        if iMeasureIndex % 2 == 0 then
          beatScoreline "ScaleFlow", iBaseTime+0, 2, 30, 5.11, 0, 0, 1+(iMeasureIndex%8)/5
        else
          beatScoreline "ScaleFlow", iBaseTime+1, 1.5, 30, 5.06, 0, 0, 1+(iMeasureIndex%8)/5
        endif
      $END_PATTERN_LOOP
    endin

    instr DrumPattern1
      $PATTERN_LOOP(4)
        if iMeasureIndex % 4 == 3 then
          beatScoreline "Distorted808Kick", iBaseTime+2.5, 4, 127, .5
        endif
        beatScoreline "DefaultClosedHat", iBaseTime+0, 1, 30, 1
        beatScoreline "DefaultClosedHat", iBaseTime+0.75, 1, 20, 1
        beatScoreline "DefaultClosedHat", iBaseTime+1.5, 1, 20, 1
        beatScoreline "DefaultClosedHat", iBaseTime+2, 1, 20, 1
        beatScoreline "DefaultClosedHat", iBaseTime+2.75, 1, 30, 1
        beatScoreline "DefaultClosedHat", iBaseTime+3.25, 1, 20, 1

        beatScoreline "Distorted808Kick", iBaseTime+0, 4, 127, .5
        if iMeasureIndex % 2 == 0 then
          beatScoreline "Distorted808Kick", iBaseTime+3.5, 4, 127, .5
        endif

        beatScoreline "DefaultSnare", iBaseTime+4/6, 2, 10, 1
        beatScoreline "DefaultSnare", iBaseTime+5/6, 2, 10, 1
        beatScoreline "DefaultSnare", iBaseTime+1, 2, 20, 1
        beatScoreline "DefaultSnare", iBaseTime+3, 2, 50, 1
      $END_PATTERN_LOOP
    endin

    instr Verse
        beatScoreline "ScaleFlowPattern1", 0, secondsToBeats(p3)
        beatScoreline "ScaleFlowBass1", 0+8, secondsToBeats(p3)-8

        beatScoreline "DrumPattern1", 0+8, secondsToBeats(p3)-8

        beatScoreline "ScaleFlowMelody", 0+40, secondsToBeats(p3)-32
    endin

    instr Chorus
      $PATTERN_LOOP(8)
        beatScoreline "ScaleFlow", iBaseTime+0, 3, 89, 6.050000
        beatScoreline "ScaleFlow", iBaseTime+0, 5, 89, 4.050000
        beatScoreline "ScaleFlow", iBaseTime+5, 3, 89, 4.020000
      $END_PATTERN_LOOP
    endin

    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 8
    ; beatScoreline "WorkingPattern", 0, 128
    ; beatScoreline "DefaultEffectChainWarmDistortion", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1
    beatScoreline "K35LowPassFilter", 0, -1
    ; beatScoreline "DefaultEffectChainChorus", 0, -1
  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    ; i "Chorus" 0 64
    i "ScaleFlow" 0 12 60 3.06
    i "ScaleFlowPattern2" 12 42
    i "Verse" 54 300
  </CsScore>
</CsoundSynthesizer>
