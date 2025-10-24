<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    --midi-device=a
    --messagelevel=0
    -B512 -b256
    ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
    ; -B4096 -b4096
    -t100
    ; -W -o "NewProjectTemplate-v0.1.wav"
  </CsOptions>
  <CsInstruments>
    #include "./config/config.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "./config/midiAssignments.orc"
    #include "./instruments/orchestra.orc"
    #include "./patterns/patterns.orc"

    instr config

    endin
  </CsInstruments>
  <CsScore>
    i "config", 0, -1
    i "Section", +, 16, "Verse"
  </CsScore>
</CsoundSynthesizer>
