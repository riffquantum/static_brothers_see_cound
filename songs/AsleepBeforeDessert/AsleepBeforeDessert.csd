<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      -iadc
      ; --realtime
      ; -B512 -b60
      -t73.5
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    ; #include "config/guitarMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"

    instr config
      ; midiMonitor
      ; gkDefaultEffectChainReverbWetAmount = .03
      ; gkSyncLoopSamplerTemplate2Fader = .5
      gkAsleepBeforeDessertEqBass = 3

      ; gkDefaultEffectChainChorusAmount = oscil(2, .5) + 1
      ; gkDefaultEffectChainChorusWetAmount = .5
      ; gkDefaultEffectChainChorusDryAmount = 1
      giMetronomeIsOn = 1
    endin

    #define ASLEEP_IN_THE_DESSERT_GRAIN #
      kTimeStretch = 1 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = 10 * poscil(.2, .25)
      kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
      kPitchAdjustment = 1
      kGrainOverlapPercentageAdjustment = 1
    #

    $SYNCLOOP_SAMPLER(AsleepBeforeDessert'AsleepBeforeDessertEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop2.wav'$ASLEEP_IN_THE_DESSERT_GRAIN'0)
    $EFFECT_CHAIN(AsleepBeforeDessertEffectChain'Mixer)

    instr NewLoop
      $PATTERN_LOOP(4)
        beatScoreline "NewInstrument", iBaseTime, 4, 120, 5.00
      $END_PATTERN_LOOP
    endin

    instr MainLoop
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.05
      $END_PATTERN_LOOP
    endin

    instr MainLoopC
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.00
      $END_PATTERN_LOOP
    endin

    instr MainLoopCLow
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.00
      $END_PATTERN_LOOP
    endin

    instr MainLoop2
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05
      $END_PATTERN_LOOP
    endin

    instr Intro
      gkAsleepBeforeDessertTimeStretch linseg .001, p3, 1

      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05
      $END_PATTERN_LOOP
    endin

    instr PastelLoop
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.00
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05
      $END_PATTERN_LOOP
    endin

    instr BuzzingSprites
      beatScoreline "AsleepBeforeDessert", 0, secondsToBeats(p3), 20, 7.00
      beatScoreline "AsleepBeforeDessert", 0, secondsToBeats(p3), 20, 6.05
    endin

    instr PastelLoopWithFlourish
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 4.00
        beatScoreline "AsleepBeforeDessert", iBaseTime, 4, 120, 3.05

        beatScoreline "AsleepBeforeDessert", iBaseTime+2, 2, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime+2, 2, 120, 5.00
      $END_PATTERN_LOOP
    endin

    instr WorkingPattern

      $PATTERN_LOOP(8)
        beatScoreline "AsleepBeforeDessert", iBaseTime+0, 1, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime+1, 1, 120, 4.07
        beatScoreline "AsleepBeforeDessert", iBaseTime+2, 1, 120, 4.00
        beatScoreline "AsleepBeforeDessert", iBaseTime+3, 1, 120, 4.04
        beatScoreline "AsleepBeforeDessert", iBaseTime+4, 4, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime+4, 4, 120, 4.00
      $END_PATTERN_LOOP
    endin

    instr Bridge
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime+0, 1.15, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime+1, 1.15, 120, 4.07
        beatScoreline "AsleepBeforeDessert", iBaseTime+2, 1.15, 120, 4.00
        beatScoreline "AsleepBeforeDessert", iBaseTime+3, 1.15, 120, 4.04
      $END_PATTERN_LOOP
    endin

    instr BridgeToC
      $PATTERN_LOOP(4)
        beatScoreline "AsleepBeforeDessert", iBaseTime+0, 2, 120, 4.10
        beatScoreline "AsleepBeforeDessert", iBaseTime+2, 2, 120, 4.05
        beatScoreline "AsleepBeforeDessert", iBaseTime+0, 2, 120, 3.10
        beatScoreline "AsleepBeforeDessert", iBaseTime+2, 2, 120, 3.05
      $END_PATTERN_LOOP
    endin


    instr Outro
      gkAsleepBeforeDessertFader linseg 1, p3/2, 1, p3/2, 0
      beatScoreline "AsleepBeforeDessert", 0, secondsToBeats(p3), 56, 4.000000
      beatScoreline "AsleepBeforeDessert", 0.02, secondsToBeats(p3), 67, 4.050000
      beatScoreline "AsleepBeforeDessert", 0.01, secondsToBeats(p3), 65, 3.050000
      beatScoreline "AsleepBeforeDessert", 0.05, secondsToBeats(p3), 73, 5.000000
    endin

    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 4
    ; beatScoreline "WorkingPattern", 0, 128
    ; beatScoreline "DefaultEffectChainWarmDistortion", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1
    beatScoreline "K35LowPassFilter", 0, -1
    ; beatScoreline "DefaultEffectChainChorus", 0, -1

  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    ; i "NewLoop" 0 300
    ; i "WorkingPattern" 0 300


    i "Intro" 0 32
    i "MainLoop2" 32 32
    i "MainLoopC" 48 16

    i "BridgeToC" 64 4

    i "MainLoopC" 68 16
    i "MainLoopCLow" 68 4
    i "PastelLoop" 84 32
    i "BuzzingSprites" 100 32
    i "Outro" 116 64

  </CsScore>
</CsoundSynthesizer>
