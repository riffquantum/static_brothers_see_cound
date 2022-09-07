<CsoundSynthesizer>
  <CsOptions>
      -odac
      ; --midi-device=a
      --messagelevel=0
      ; -iadc
      ; --realtime
      ; -B512 -b60
      -t160
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
    #include "songs/Uptick/instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/Uptick/patterns/pattern-manifest.orc"

    instr config
      ; midiMonitor
      gkDefaultEffectChainReverbWetAmount = .03

      gkDefaultEffectChainChorusAmount = oscil(2, .5) + 1
      gkDefaultEffectChainChorusWetAmount = .5
      gkDefaultEffectChainChorusDryAmount = 1
      giMetronomeIsOn = 1

      gkKickSquiggleEqBass = 2
      gkKickSquiggleFader = 2
    endin

    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 24
    ; beatScoreline "WorkingPattern", 0, 128
    ; beatScoreline "DefaultEffectChainWarmDistortion", 0, -1
    ; beatScoreline "DefaultEffectChainReverb", 0, -1
    beatScoreline "K35LowPassFilter", 0, -1
    beatScoreline "DefaultEffectChainChorus", 0, -1
  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    i "KickSquiggleGroove" 0 300
    i "BassLine" 32 240
    ; i "YiSynth3Pattern" 0 208
  </CsScore>
</CsoundSynthesizer>
