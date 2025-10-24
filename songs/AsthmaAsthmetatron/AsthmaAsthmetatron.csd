<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    ; --midi-device=a
    --messagelevel=0
    ; -B512 -b256
    ; -t65
    ; -t55
    -t55.6875
    ; -W -o "AsthmaAsthmetatron-v0.1.wav"
    ; -j 10 ; parallel execution?
  </CsOptions>

  <CsInstruments>

    #include "config/config.orc"
    gSMidiChannelAssignments[] fillarray ""
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/AsthmaAsthmetatron/instruments/orchestra.orc"
    #include "songs/AsthmaAsthmetatron/patterns/patterns.orc"

    instr config
      gkKickBusEqBass init 2
      gkKickBusFader init .75
    endin

    instr WorkingPattern
      ; $PATTERN_LOOP(16)
      ;   _ "Kiss", i0, 16, 100, 1, 0
      ; $END_PATTERN_LOOP

      ; $PATTERN_LOOP(4)
      ;   _ "Kiss", i0, 4, 100, 1, 0
      ; $END_PATTERN_LOOP

      $PATTERN_LOOP(8)
        ; _ "Kiss", i0, 8, 100, 1, 0
        _ "Kiss2", i0, 8, 100, 1, 0
      $END_PATTERN_LOOP


      $PATTERN_LOOP(8)
        ; _ "Asma6", i0, 8, 100, 1, 0
        ; _ "Asma7", i0, 8, 100, 4/3, 0
        ; _ "Asma9", i0, 8, 100, 2/3, 0

        ; if iMeasureCount % 8 == 0 then
        ;   _ "Asma8", i0, 2, 100, 2/3, 0, 0, 0, .25
        ;   _ "Asma8", i0+4, 2, 100, 4/3, 4, 0, 0, 0
        ;   _ "Asma8", i0+6, 2, 80, 4/3, 5, 0, 0, 0
        ; elseif iMeasureCount % 4 == 0 then
        ;   _ "Asma8", i0, 2, 100, 4/3, 0, 0, 0, .25
        ;   _ "Asma8", i0+4, 2, 100, 2/3, 4, 0, 0, 0
        ; else
        ;   _ "Asma8", i0, 2.25, 100, 2/3, 0, 0, 0, 1
        ;   _ "Asma8", i0+4, 2.25, 100, 2/3, 4, 0, 0, 1
        ; endif
      $END_PATTERN_LOOP
    endin

    instr Bridge
      $PATTERN_LOOP(4)
        _ "DrumLoop1", i0, 4
      $END_PATTERN_LOOP

      $PATTERN_LOOP(8)
        _ "Asma9", i0, 8, 100, 1, 0
      $END_PATTERN_LOOP

        _ "Asma9", 8, 8, 120, 1/3, 0
        ; _ "Asma9", 24, 8, 120, 1/3, 0


        ; ; if iMeasureCount % 4 == 0 then
        ; ; if iMeasureCount % 2 == 0 then

        ; ;   ; _ "Asma9", i0, 8, 100, 4/3, 0, 0, bts(4)
        ;   _ "Asma8", 32, 2, 100, 2/3, 4, 0, 0, 1
        ;   _ "Asma8", 32, 4, 100, 1, 12
        ;   _ "Asma8", 36, 2, 100, 2/3, 4, 0, 0, 1
        ;   _ "Asma8", 36, 4, 100, 1, 12
        ;   _ "Asma8", 40, 2, 100, 2/3, 4, 0, 0, 1
        ;   _ "Asma8", 40, 4, 100, 1, 12
        ;   _ "Asma8", 44, 2, 100, 2/3, 4, 0, 0, 1
        ;   _ "Asma8", 44, 4, 100, 1, 12
        ; else

        ; endif
    endin

    instr TestG
      gkAsma1GPitchAdjustment init 0.99

      $PATTERN_LOOP(8)
        _ "Asma1", i0, 4, 120, 1, 0
        _ "Asma1G", i0+4, 4, 120, 4.0, 0
      $END_PATTERN_LOOP
    endin

  </CsInstruments>
  <CsScore>
    i "config" 0 -1
    ; i "Section" + 360 "WorkingPattern"

    ; i "Section" + 160 "TestG"
    i "Section" + 16 "Intro"
    i "Section" + 64 "Verse"
    i "Section" + 40 "BazoukiBridge"
    i "Section" + 32 "SparkleLoop"
    ; i "Section" + 16 "Bridge"
    ; i "Section" + 16 "Intro"
    i "Section" + 48 "Verse"
  </CsScore>
</CsoundSynthesizer>
