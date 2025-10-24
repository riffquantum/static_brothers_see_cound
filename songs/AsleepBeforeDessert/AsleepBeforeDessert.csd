<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    ; --midi-device=a
    --messagelevel=0
    ; -iadc
    ; -W -o "songs/AsleepBeforeDessert/AsleepBeforeDessertv0.3.1.wav"
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
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/AsleepBeforeDessert/instruments/orchestra.orc"
    #include "songs/AsleepBeforeDessert/patterns/patterns.orc"

    $EFFECT_CHAIN(DefaultEffectChain'Mixer)

    instr config
      ; midiMonitor
      ; gkDefaultEffectChainReverbWetAmount = .03
      gkAsleepBeforeDessertEqBass = 3

      ; gkDefaultEffectChainChorusAmount = oscil(2, .5) + 1
      ; gkDefaultEffectChainChorusWetAmount = .5
      ; gkDefaultEffectChainChorusDryAmount = 1
      ; giMetronomeIsOn = 1
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

    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 4
    ; beatScoreline "WorkingPattern", 0, 128
    ; beatScoreline "DefaultEffectChainWarmDistortion", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1
    ; beatScoreline "DefaultEffectChainChorus", 0, -1


  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    ; i "WorkingPattern" 0 300


    ; i "Section" + 32 "Intro" ; Evan Starts halfway through here
    ; i "Section" + 32 "Verse"
    ; i "DarkoVoxWhole" 0 -1 127 1
    ; i "iAliveVoxWhole" 0 -1 127 1


    ; Intercut Version
    ; i "Section" + 80 "DarkoVerse1"
    ; i "Section" + 32 "DarkoChorus" 1
    ; i "Section" + 52 "DonVerse"
    ; i "Section" + 32 "DarkoChorus" 0
    ; i "Section" + 31.75 "DarkoVerse2"
    ; i "Section" + 28 "DonVerse2"
    ; i "Section" + 64 "Outro"

    ; Verse/Verse Version
    ; i "Section" + 80 "DarkoVerse1"
    ; i "Section" + 28 "DarkoChorus"
    ; i "Section" + 31.75 "DarkoVerse2"
    i "Section" + 56 "DonVerse"
    i "Section" + 24 "DonVerse2"
    i "Section" + 64 "Outro"



    ; i "Section" + 15.75 "Test"
    ; i "Section" + 16 "DonBridge"
    ; i "Section" + 16 "DonBridge2"
    ; i "Section" + 32 "DarkoChorus"

    ; i "Section" + 16 "BridgeToC" ; Bullshit artists... Go back to bed america
    ; i "Section" + 32 "Chorus" ; "I ruminate on the subject" starts at buzzsprites
    ; i "Section" + 24 "Verse2"
    ; i "Section" + 32 "Chorus"
    ; i "Section" + 24 "Verse2"


    ; i "MainLoopC" 68 16
    ; i "MainLoopCLow" 68 4
    ; i "PastelLoop" 84 32
    ; i "BuzzingSprites" 100 32





    ; ORIGINAL LAYOUT

    ; i "Intro" 0 32
    ; i "MainLoop2" 32 32
    ; i "MainLoopC" 48 16

    ; i "BridgeToC" 64 4

    ; i "MainLoopC" 68 16
    ; i "MainLoopCLow" 68 4
    ; i "PastelLoop" 84 32
    ; i "BuzzingSprites" 100 32
    ; i "Outro" 116 64

  </CsScore>
</CsoundSynthesizer>
