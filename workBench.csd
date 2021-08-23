<CsoundSynthesizer>
  <CsOptions>
      -odac
      ; -W -o "newLoop.wav"
      -Ma
      -m0
      -iadc
      ; --realtime
      -B512 -b256
      ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
      ; -B4096 -b4096
      -t90      ;--midioutfile=midiout.mid
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

    ; #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "instruments/DrumKits/BirdshitDrumKit.orc"
    ; #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    ; #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"

    ; $BREAK_SAMPLE(TestInstrument'DefaultEffectChain'localSamples/ZZ Top - Asleep In The Desert/asleepInTheDesertLoop3.wav'24)

    instr config
      giCurrentSong = 1
      gkNewEffectQ = 4 ;+ oscil(14, 0.1)
      gkNewEffectShift = 5000 ; + oscil(250, 0.5)
      gkNewEffectIntNoise = 0
      gkNewEffectMode = 0
      ; gkNewEffectDryAmount = 1

      gkNewEffectEqBass = 1.5
      gkNewEffectEqHigh = .5

      gkMuffledKickFader = 1.5

      gkBassSynthFader = 0.35
    endin

    #define STRING_SYNTH_SETTINGS #
      giStringSynthNumberOfVoices = 1
    #

    $STRING_PAD(StringSynth'Mixer'$STRING_SYNTH_SETTINGS)

    $OCARINA(Ocarina'Mixer')

    $BASS_SYNTH(BassSynth'BassSynthDistInput')
    $WARM_DISTORTION(BassSynthDist'BassSynthChorusInput'BassSynthChorusInput)
    $CHORUS(BassSynthChorus'BassSynthDelayInput'BassSynthDelayInput)
    $DELAY(BassSynthDelay'Mixer'VocoderCarrier'5'0.25'0.85'1'0.0)

    $ARPEGGIATOR(BassArp'BassSynth)

    $DRUM_SAMPLE(Snare'Mixer'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)
    $DRUM_SAMPLE(MuffledKick'Mixer'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)
    $TWISTED_KICK(TwistedUpKick'Mixer'localSamples/CB_Kick.wav)
    $EFFECT_CHAIN(TwistedUpKickFx'Mixer)

    #define VIBE_LINE_GRAIN_SETTINGS #
      kTimeStretch = .3 + (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = (10 + poscil(2, .25)) * (1 + poscil(3, .05))
      kGrainFrequencyAdjustment = 2 + (.1 - poscil(10, .25) + poscil(.2, .3))
      kPitchAdjustment = 1 ;* (1 + oscil(.025, 2))
      kGrainOverlapPercentageAdjustment = 2
    #
    $SYNCLOOP_SAMPLER(VibeLineGrain'Mixer'localsamples/ajq - vibe out.wav'$VIBE_LINE_GRAIN_SETTINGS'5)

    instr WorkingPattern
      beatScoreline "BassSynthChorus", 0, -1
      beatScoreline "BassSynthDist", 0, -1
      gkTwistedUpKickEqBass = 2
      gkVibeLineGrainPitchAdjustment = 1 + oscil(0.01, 0.3) ;loopseg 1/beatsToSeconds(8), 0, 0, 1, beatsToSeconds(4), 1, beatsToSeconds(4), 0.5
      $PATTERN_LOOP(8)
        ; beatScoreline "BassSynth", iBaseTime, 4, 100, 2.00
        ; beatScoreline "BassSynth", iBaseTime+4, 4, 100, 2.04
        beatScoreline "VibeLineGrain", iBaseTime, 4, 50, 3.07
        beatScoreline "VibeLineGrain", iBaseTime+4, 4, 50, 3.05

        beatScoreline "TwistedUpKick", iBaseTime, 4, 80, 4.02, 1.9, 2
        beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8

        beatScoreline "Snare", iBaseTime+1, 1, 120, 1
        beatScoreline "Snare", iBaseTime+3, 1, 120, 1
        beatScoreline "Snare", iBaseTime+5, 1, 120, 1
        beatScoreline "Snare", iBaseTime+7, 1, 120, 1

      $END_PATTERN_LOOP
    endin

    beatScoreline "NewEffect", 0, -1
    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 8
  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    ; i "NewLoop" 0 300
    ; i "WorkingPattern" 1 256
    ; i "Break" 0 400
  </CsScore>
</CsoundSynthesizer>
