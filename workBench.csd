<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      -iadc
      ; --realtime
      ; -B512 -b60
      -t125
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
    #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    instr config
      ; midiMonitor

      gkDefaultEffectChainReverbWetAmount = .03
      gkSyncLoopSamplerTemplate2Fader = .5

      ; gkJeanetteChorusAmount = oscil(2, .5) + 1
      gkJeanetteChorusWetAmount = .5
      gkJeanetteChorusDryAmount = 1
    endin

    giMetronomeIsOn = 0

    instr WorkingPattern
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 8
      iMeasureIndex = 0

      ; gkNothingIDontLikeBreakPitch = linseg(-3, beatsToSeconds(2), 1)

      ; beatScoreline "NothingIDontLikeBreak", 0, p3, 60, 1, 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1
        ; beatScoreline "AmenBreak", iBaseTime+0, iBeatsPerMeasure, 120, 1, 0
        ; beatScoreline "RafflesiaBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "GettinHappyBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "FunkyDrummerBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "HandInTheHandBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "KissingMyLoveBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "ItsExpectedBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "JbShoutBreak", iBaseTime+0, iBeatsPerMeasure, 120, 1, 0
        ; beatScoreline "LoserInTheEndBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "JohnnyTheFoxBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 4.5
        ; beatScoreline "ItsOnlyLoveBreak", iBaseTime+0, iBeatsPerMeasure, 60, 1, 0
        ; beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+0, iBeatsPerMeasure/2, 100, 1, 0
        ; beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+2, iBeatsPerMeasure/2, 100, 1, 0

        ; beatScoreline "BasicSamplerTemplate", iBaseTime+0, 4, 120, 261.3, 32
        ; beatScoreline "BasicSamplerTemplate", iBaseTime+4, 4, 120, 261.3, 32
        ; beatScoreline "DefaultEffectChainDelay", iBaseTime+4, 4

        iMeasureIndex += 1

        ; beatScoreline "SimpleOscillator", iBaseTime, 8, 120, 2.11
        ; beatScoreline "SimpleOscillator", iBaseTime+1, 7, 100, 4.03
        ; beatScoreline "SimpleOscillator", iBaseTime+2, 6, 100, 5.01
        ; beatScoreline "SimpleOscillator", iBaseTime+4, 1, 100, 3.04
        ; beatScoreline "SimpleOscillator", iBaseTime+6, 1, 100, 3.04

        ; beatScoreline "DefaultCrash", iBaseTime, 1, 80, 1
        ; beatScoreline "DefaultKick", iBaseTime, 1, 100, 1
        ; beatScoreline "DefaultKick", iBaseTime+0.5, 1, 100, 1
        ; beatScoreline "DefaultKick", iBaseTime+1.5, 1, 100, 1

        ; beatScoreline "DefaultSnare", iBaseTime+2, 1, 80, 1
        ; beatScoreline "DefaultKick", iBaseTime+4, 1, 100, 1
        ; beatScoreline "DefaultSnare", iBaseTime+6, 1, 80, 1
        ; beatScoreline "DefaultKick", iBaseTime+7, 1, 100, 1

        ; beatScoreline "DefaultClosedHat", iBaseTime+0.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+0.50, 1, 80, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+1.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+1.50, 1, 80, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+2.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+2.50, 1, 80, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+3.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+3.50, 1, 80, 1

        ; beatScoreline "DefaultClosedHat", iBaseTime+4.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+4.50, 1, 80, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+5.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+5.50, 1, 80, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+6.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+6.50, 1, 80, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+7.00, 1, 100, 1
        ; beatScoreline "DefaultClosedHat", iBaseTime+7.50, 1, 80, 1

      od
    endin

    beatScoreline "config", 0, -1
    beatScoreline "WorkingPattern", 0, 128
    ; beatScoreline "DefaultEffectChainWarmDistortion", 0, -1
    ; beatScoreline "DefaultEffectChainReverb", 0, -1
    beatScoreline "K35LowPassFilter", 0, -1
    beatScoreline "JeanetteChorus", 0, -1

  </CsInstruments>
  <CsScore>
  </CsScore>
</CsoundSynthesizer>
