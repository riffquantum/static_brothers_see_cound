<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t190
    -odac
    ; -W -o "AvianPeter.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/AvianPeter/instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit/DefaultDrumKit-manifest.orc"
    #include "songs/AvianPeter/patterns/pattern-manifest.orc"

    instr Pattern1
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 4
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure



        iMeasureCount += 1
      od
    endin

    gkPhotoshopSamplesFader init .6
    gkDefaultDrumKitReverbWet init 0.02

    beatScoreline "segue1", 0, 4
    beatScoreline "drumPattern1", 4, 84

    ;verse 1
    beatScoreline "segue2", 96, 8
    beatScoreline "drumPattern1", 104, 126

    beatScoreline "segue2", 234, 8
    beatScoreline "drumPattern1", 242, 126

    beatScoreline "OpenHat", 0, 1, 100, 1
    beatScoreline "HatPedal", 1, 1, 120, 1
    beatScoreline "ClosedHat", 2, 1, 120, 1

  </CsInstruments>
  <CsScore>
  </CsScore>
</CsoundSynthesizer>
