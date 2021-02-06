<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      -iadc
      ; --realtime
      ; -B512 -b60
      -t100
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

    $BREAK_SAMPLE(TestInstrument'DefaultEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop3.wav'24)

    instr config
      ; midiMonitor
      giDefaultEffectChainTapeWobbleBaseDelayTime = .4
      gaDefaultEffectChainTapeWobbleAmount = .02
      gkDefaultDrumKitBusFader = .25
      gaDefaultEffectChainTapeWobbleSpeed = 1 + oscil(.9, .1, -1, .75)
      giMetronomeIsOn = 1

    endin
    beatScoreline "MuffledKickFxClip", 0, -1
    ; beatScoreline "DefaultEffectChainTapeWobble", 0, -1

    ; beatScoreline "DefaultEffectChainTapeWobble", 24, -1
    $DRUM_SAMPLE(Snare'Mixer'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)

    $DRUM_SAMPLE(MuffledKick'MuffledKickFx'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)
    $EFFECT_CHAIN(MuffledKickFx'Mixer)

    instr WorkingPattern
      beatScoreline "DefaultEffectChainK35Lpf", 8, 8
      beatScoreline "DefaultEffectChainReverb", 8, 8
      beatScoreline "DefaultEffectChainChorus", 8, 8

      $PATTERN_LOOP(4)
        beatScoreline "MuffledKick", iBaseTime+0, 4, 127, -1
        beatScoreline "MuffledKick", iBaseTime+0.75, 4, 127, 1
        beatScoreline "MuffledKick", iBaseTime+1.5, 4, 127, 1
        beatScoreline "MuffledKick", iBaseTime+2, 4, 127, 1
        beatScoreline "Snare", iBaseTime+1, .1, 60, .8
        beatScoreline "Snare", iBaseTime+3, 4, 60, -0.8

        ; beatScoreline "TestInstrument", iBaseTime+0, 4, 70, -3.0, 4.25
        ; beatScoreline "TestInstrument", iBaseTime+0, 4, 70, 3.0, 6
        ; beatScoreline "TestInstrument", iBaseTime+0, 4, 70, 3.0, 0
      $END_PATTERN_LOOP
    endin


    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 4
    ; beatScoreline "WorkingPattern", 0, 128
    ; beatScoreline "DefaultEffectChainWarmDistortion", 0, -1
    ; beatScoreline "DefaultEffectChainReverb", 0, -1
    ; beatScoreline "DefaultEffectChainChorus", 0, -1
    ; beatScoreline "DefaultEffectChainK35Lpf", 0, -1

  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    ; i "NewLoop" 0 300
    i "WorkingPattern" 0 300
  </CsScore>
</CsoundSynthesizer>
