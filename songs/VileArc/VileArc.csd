<CsoundSynthesizer>
  <CsOptions>
      ; -Ma
      -m0
      -odac
      ; -W -o "VileArcv1.0.wav" -m0
      ; -iadc
      ; -B512 -b60
      -t80
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/VileArc/config/midiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/VileArc/instruments/orchestra-manifest.orc"
    #include "songs/VileArc/patterns/pattern-manifest.orc"

    instr config
      giGlobalReverbMode = 3
      gkGlobalReverbWetAmount = .275 + oscil(.025, 1/beatsToSeconds(32))

      gkPainSpiralFader = .8

      giDistorted808KickFinalGainAmount = .75

      gkKickHelixEqBass = 1.5
      gkKickHelixFader = .8

      gkHatWarpFader = .8

      gkPreClipMixerFader = .75

      gaDelayForAwfulCrashTime = oscil(0.00004, 15) + 0.00085 + oscil(0.0001, 1/beatsToSeconds(3))
      gkDistortionForAwfulCrashFader = .0025

      gkDistortionForSnareFader = .0025
      gkSnareFader = 2
      gkReverbForSnareWetAmount = .15
    endin

    giMetronomeIsOn = 0

    beatScoreline "config", 0, -1
    beatScoreline "ReverbForSnare", 0, -1
    beatScoreline "GlobalReverb", 0, -1

  </CsInstruments>

  <CsScore>
    ; i "Pattern2" 0 128
    ; i "VersePattern1" 0 128

    i "Intro" 0 8
    i "Bridge" 8 16
    i "VersePattern1" 24 64 ; Quinn's Verse here

    i "Bridge" 88 16 1
    i "VersePattern1" 104 64
    i "Pattern2" 168 64 ; Take it out with scratching and No-Input Mixer
  </CsScore>
</CsoundSynthesizer>
