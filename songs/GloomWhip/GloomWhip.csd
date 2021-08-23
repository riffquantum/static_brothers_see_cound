<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      -iadc
      ; --realtime
      ; -B512 -b60
      -t100
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
    #include "songs/GloomWhip/instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "config/defaultMidiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"



    instr config
      gkLashFxTapeWobbleSpeed = .4 + poscil(.2, .5)
      gaLashFxTapeWobbleAmount = .05
      giGlobalFxReverbMode = 7
    endin


    instr WorkingPattern
      $PATTERN_LOOP(4)
        beatScoreline "MuffledKick", iBaseTime+0, 4, 127, 1
        beatScoreline "MuffledKick", iBaseTime+0.75, 4, 127, 1
        beatScoreline "MuffledKick", iBaseTime+1.5, 4, 127, 1
        beatScoreline "MuffledKick", iBaseTime+2, 4, 127, 1
        beatScoreline "Snare", iBaseTime+1, .1, 60, .8
        beatScoreline "Snare", iBaseTime+3, 1, 60, 0.8

        beatScoreline "Lash", iBaseTime+0, 4, 30, -2.07, 8.25
        beatScoreline "Lash", iBaseTime+0, 4, 30, 2.07, 0

        if iMeasureCount % 8 < 3 then
          beatScoreline "Lash", iBaseTime+0, 4, 70, -3.0, 4.25
        elseif iMeasureCount % 8 < 5 then
          beatScoreline "Lash", iBaseTime+0, 4, 70, 3.0, 6
        elseif iMeasureCount % 8 < 7 then
          beatScoreline "Lash", iBaseTime+0, 4, 70, 3.0, 0
        else
          beatScoreline "Lash", iBaseTime+0, 2, 70, 3.0, 0
          beatScoreline "Lash", iBaseTime+2, 2, 70, -3.0, 2
        endif
      $END_PATTERN_LOOP
      ; beatScoreline "Lash", 0, -1, 40, -3.0, 4.25
    endin

    beatScoreline "LashFxTapeWobble", 0, -1
    ; beatScoreline "GlobalFxReverb", 0, -1
    beatScoreline "config", 0, -1
  </CsInstruments>
  <CsScore>
    i "WorkingPattern" 0 300
  </CsScore>
</CsoundSynthesizer>
