<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      ; -W -o "EscapePrismv0.1.wav" -m0
      -iadc
      ; -B512 -b60
      -t80
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit/DefaultDrumKit-manifest.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/EscapePrism/instruments/orchestra-manifest.orc"
    #include "songs/EscapePrism/patterns/pattern-manifest.orc"

    instr config
      giDefaultEffectChainReverbMode = 3
      gkDefaultEffectChainReverbWetAmount = .3

      gkPainSpiralFader = .8

      gkDistorted808KickPreGain = 11.25 + poscil(1.25, 1/beatsToSeconds(64), -1, .75)
      giDistorted808KickFinalGainAmount = .5

      gkKickHelixEqBass = 1.5
      gkKickHelixFader = .8

      gkHatWarpFader = .8

      gkDefaultSnareFader = 2

      gkPreClipMixerFader = .5
    endin

    beatScoreline "config", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1

  </CsInstruments>
  <CsScore>
    i "Pattern1_dnb" 0 128

  </CsScore>
</CsoundSynthesizer>
