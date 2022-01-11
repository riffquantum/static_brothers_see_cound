<CsoundSynthesizer>
  <CsOptions>
      -odac
      --midi-device=a
      --messagelevel=0
      ; -W -o "EscapePrismv0.1.wav
      ; -iadc
      ; -B512 -b60
      -t80
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/EscapePrism/config/MidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "songs/EscapePrism/config/midiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/EscapePrism/instruments/orchestra-manifest.orc"
    #include "songs/EscapePrism/patterns/pattern-manifest.orc"

    #define NEW_GRAIN #
      kTimeStretch = .1 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = 1
      kGrainFrequencyAdjustment = 1 ;*(.1 - poscil(10, .25) + poscil(.2, .3))
      kPitchAdjustment = 1
      kGrainOverlapPercentageAdjustment = 1
    #
    $SYNCLOOP_SAMPLER(NewInst'NewInstFx'localSamples/gloria7.wav'$NEW_GRAIN'0)
    $EFFECT_CHAIN(NewInstFx'Mixer)
    beatScoreline "NewInstFxDelay", 0, -1
    ; beatScoreline "NewInst", 0, -1, 100, 2.05
    ; beatScoreline "NewInst", 0, -1, 100, 3.00


    instr config
      gkNewInstFader = 2

      gaNewInstFxDelayTime = .03
      gkNewInstFxDelayFeedbackAmount = .98
      gkNewInstFxDelayWetAmount = .5

      giDefaultEffectChainReverbMode = 3
      gkDefaultEffectChainReverbWetAmount = .3

      gkPainSpiralFader = .8

      gkGlobalFxK35LpfQ = 20 + oscil(19.5, .1)
      gkGlobalFxK35LpfCutoffFrequency = 2500 + oscil(1500, .5)
      gkGlobalFxK35LpfWetAmount = .25
      gkGlobalFxK35LpfDryAmount = .75


      gkDistorted808KickPreGain = 11.25 + poscil(1.25, 1/beatsToSeconds(64), -1, .75)
      giDistorted808KickFinalGainAmount = .5

      gkHatWarpEqBass = 1.5

      gkKickHelixEqBass = 1.5
      gkKickHelixFader = .8

      gkHatWarpFader = .8

      gkDefaultSnareFader = 2
      gkDefaultClosedHatFader = .35

      gkPreClipMixerFader = .5

      gkEscapePrismFader = .1

      gkSnareFader = 2
      gkSnareTuning = 1.25 + oscil(.025, .1)
      gkKickTuning = .8
      gkKickFader = 1.5

      gkLayeredBassSynthFxWarmDistortionPreGain = 1.2
      gkLayeredBassSynthFxWarmDistortionPostGain = 1.75
      gkLayeredBassSynthFxWarmDistortionDutyOffset = .001
      gkLayeredBassSynthFxWarmDistortionSlopeShift = .001
    endin

    instr Intro
      beatScoreline "IntroDrums", 0, secondsToBeats(p3)
      beatScoreline "IntroPattern", 0, secondsToBeats(p3)
    endin

    instr Verse
      beatScoreline "DrumPattern1", 0, secondsToBeats(p3)
      beatScoreline "Pattern1", 0, secondsToBeats(p3)
    endin

    instr Verse2
      beatScoreline "DrumPattern2", 0, secondsToBeats(p3)
      beatScoreline "Pattern2", 0, secondsToBeats(p3)
    endin

    instr PreIntro
      beatScoreline "DefaultKick", 0, .5, 127, 1
      beatScoreline "Distorted808Kick", 0, .5, 127, .35

      beatScoreline "EscapePrism2", 0.0, 16, 120, 5.07
    endin

    beatScoreline "config", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1
    ; beatScoreline "GlobalFxTapeWobble", 0, -1
    beatScoreline "GlobalFxK35Lpf", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 8
    beatScoreline "LayeredBassSynthFxWarmDistortion", 0, -1
    beatScoreline "LayeredBassSynthFxReverb", 0, -1
    beatScoreline "LayeredBassSynthFxChorus", 0, -1
  </CsInstruments>
  <CsScore>
    ; good scratch sample souce - April in Pris by Australian Jazz Quartet
    ; i "PreIntro" 0 16

    i "Intro" 0 16
    i "Verse" 16 32
    i "Verse2" 48 32
    i "Verse" 80 32
    i "Verse2" 112 32

    ; i "Verse" 0 64
    ; i "Verse2" 0 64

  </CsScore>
</CsoundSynthesizer>
