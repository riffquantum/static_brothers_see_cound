<CsoundSynthesizer>
  <CsOptions>
    --messagelevel=0
    -t85
    -odac
    -d
    ; -W -o "getDiluvian.wav
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    gkBPM init 85

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/ApesConcertOne/instruments/orchestra-manifest.orc"
    #include "songs/ApesConcertOne/patterns/pattern-manifest.orc"

  </CsInstruments>

  <CsScore>
    m section1
    s
  </CsScore>
</CsoundSynthesizer>
