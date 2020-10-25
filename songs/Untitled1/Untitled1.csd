<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t60
    -odac
    ; -W -o "Untitled1.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/Untitled1/config/midiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit/DefaultDrumKit-manifest.orc"
    #include "songs/Untitled1/instruments/orchestra-manifest.orc"
    #include "songs/Untitled1/patterns/pattern-manifest.orc"


    instr config
      gaDelayForGrainStabTime = (poscil(1/8, 1) + .25) * (poscil(2.5, .5) + 2.6) * (poscil(.1, .1) + 1)
      gkGrainStabFader = .25
      gkDistorted808KickFader = .4
      gkDelayForGrainStabWetAmount = linseg(0, beatsToSeconds(40), 0, beatsToSeconds(8), .4) * (1 + oscil(.5, .5))
    endin
    beatScoreline "DelayForGrainStab", 32, -1

    beatScoreline "config", 0, -1
    beatScoreline "ReverbForGrainStab", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1

    beatScoreline "DrumPattern1", 0, 32
    beatScoreline "HatPattern1", 8, 24
    beatScoreline "HatPattern2", 24, 8

    beatScoreline "DrumPattern1", 40, 88
    beatScoreline "HatPattern1", 32, 128
    beatScoreline "HatPattern2", 32, 128
    beatScoreline "GrainStabPattern1", 32, 128

    beatScoreline "BreakPattern1", 32, 128
    beatScoreline "GrainStabPattern1", 32, 128

  </CsInstruments>

  <CsScore>
  </CsScore>
</CsoundSynthesizer>
