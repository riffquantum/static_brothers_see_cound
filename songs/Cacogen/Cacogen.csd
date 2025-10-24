<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    ; --midi-device=a
    --messagelevel=0
    ; -t155
    -t75
  </CsOptions>
  <CsInstruments>
    #include "config/config.orc"
    gSMidiChannelAssignments[] fillarray ""
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/Cacogen/instruments/orchestra.orc"
    #include "songs/Cacogen/patterns/patterns.orc"

    instr WorkingPattern
      gkHand2EqBass = 2
      $PATTERN_LOOP(4)
        _ "CloserKick", i0, 1, 120, 1.5
        ; _ "CloserKick", i0+2, 1, 60, .8
        ; _ "CloserKick", i0+2, 1, 120, 1.2
        ; _ "CloserKick", i0+3, 1, 60, .8

        ; _ "Hand2", i0, .333, 120, .5, 2.0
        _ "Hand2", i0, 2.25, 120, 1, 2.0
        _ "Hand2", i0+2.495, 1.4, 120, 1, 2.0
        ; _ "Hand2", i0+2, .333, 120, 1, 2.0
      $END_PATTERN_LOOP
    endin

  </CsInstruments>
  <CsScore>
     i "config" 0 -1

    i "Section" + 1 ""
    ; i "Section" + 400 "WorkingPattern"
    i "Section" + 400 "DownStrike"
    ; i "Section" + 16 "SplashBeat"
    ; i "Section" + 16 "CacogenMarch"
    i "Section" + 16 "SplashBeat"
    i "Section" + 16 "CacogenMarch"
    i "Section" + 16 "SplashBeat"
    i "Section" + 16 "CacogenMarch"
    i "Section" + 16 "SplashBeat"
    i "Section" + 16 "CacogenMarch"
    i "Section" + 16 "SplashBeat"
  </CsScore>
</CsoundSynthesizer>
