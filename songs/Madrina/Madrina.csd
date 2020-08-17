<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t30
    -odac
    ; -W -o "Madrina.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/Madrina/instruments/orchestra-manifest.orc"
    #include "songs/Madrina/patterns/pattern-manifest.orc"

    instr Intro
      beatScoreline "DisonantPianoRise", 0, 4, 110, 1
    endin

    instr Verse1
      beatScoreline "DrumPattern1", 0, 16
      beatScoreline "MadrinaLoopHalf1", 0, 12
      beatScoreline "MadrinaLoop1", 12, 4

      beatScoreline "DrumPattern1", 16, 16
      beatScoreline "MadrinaLoopHalf2", 16, 12
      beatScoreline "MadrinaLoop2", 28, 4

      beatScoreline "Melody1", 16, 16
    endin

    instr Bridge
      beatScoreline "DisonantPianoRise", 0, 4, 110, 1
    endin

    instr Verse2
      beatScoreline "DrumPattern1", 0, 32
      beatScoreline "MadrinaLoop3", 0, 32
    endin

    instr Chorus
      beatScoreline "GuitarLoop1", 0, 16
      beatScoreline "DrumPattern2", 0, 16
    endin

    instr Outro
      beatScoreline "WeThoughtLoop1", 0, 16
      beatScoreline "DrumPattern1", 0, 16
    endin

    beatScoreline "DrumKitReverb", 0, -1
    beatScoreline "DrumKitLPF", 0, -1

    instr Config
      gkKickFader = .55
      gkDrumKitReverbWetAmmount = poscil(.025, .15) + .05
      gkDrumKitLPFHalfPowerPoint = poscil(1000, .05) + 5500
      gkDrumKitLPFAmount = limit(poscil(.1, .1) + .75, 0, 1)
    endin
  </CsInstruments>

  <CsScore>
    m section1
      i "Config" 0 -1
      i "Intro" 0 4
      i "Verse1" 4 32
      i "Chorus" 36 16
      i "Bridge" 52 4
      i "Verse2" 56 32
      i "Chorus" 88 16
      i "Outro" 104 16
      i "Bridge"  120 4
    s
  </CsScore>
</CsoundSynthesizer>
