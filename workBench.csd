<CsoundSynthesizer>
  <CsOptions>
      -odac -Ma  -m0
      -iadc
      -B512 -b60
      -t170
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    ; #include "config/guitarMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit/DefaultDrumKit-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    instr Dummy
      ; midiMonitor
    endin

    giMetronomeIsOn = 0

    instr WorkingPattern
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 4
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1
        ; beatScoreline "AmenBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "RafflesiaBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "NothingIDontLikeBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "GettinHappyBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "FunkyDrummerBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "HandInTheHandBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "KissingMyLoveBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "ItsExpectedBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "JbShoutBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "LoserInTheEndBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "JohnnyTheFoxBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 4.5
        ; beatScoreline "ItsOnlyLoveBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+0, iBeatsPerMeasure/2, 100, 1, 0
        ; beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+2, iBeatsPerMeasure/2, 100, 1, 0

        iMeasureIndex += 1
      od
    endin

    beatScoreline "Dummy", 0, -1

  </CsInstruments>
  <CsScore>
  </CsScore>
</CsoundSynthesizer>
