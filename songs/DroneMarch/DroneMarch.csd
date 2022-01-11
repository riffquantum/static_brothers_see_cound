<CsoundSynthesizer>
  <CsOptions>
      -odac
--midi-device=a
--messagelevel=0
      ; -iadc
      -t60
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
    ; #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "instruments/DrumKits/TR606/TR606-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    instr config
      ; midiMonitor
      gaDefaultEffectChainDelayTime = (poscil(1/8, 1) + .25) * (poscil(2.5, .5) + 2.6) * (poscil(.1, .1) + 1)
      gkSyncLoopSamplerTemplate2Fader = .5
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
        beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+0, iBeatsPerMeasure/2, 100, 1, 0
        beatScoreline "KissingMyLoveSpankyBreak", iBaseTime+2, iBeatsPerMeasure/2, 100, 1, 0

        ; beatScoreline "DefaultKick", iBaseTime+0, 1, 100, 1

        beatScoreline "LayeredBassSynth", iBaseTime+0, 8, 60, 4.02
        beatScoreline "LayeredBassSynth", iBaseTime+0, 8, 60, 4.09
        beatScoreline "LayeredBassSynth", iBaseTime+1, 7, 60, 5.02
        beatScoreline "LayeredBassSynth", iBaseTime+1, 1, 60, 5.09
        beatScoreline "LayeredBassSynth", iBaseTime+2, 6, 60, 6.00
        beatScoreline "LayeredBassSynth", iBaseTime+3.5, 5, 60, 5.04

        beatScoreline "TR606Kick", iBaseTime+0, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+1, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+2, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+3, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+4, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+5, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+6, 1, 120, 3.00
        beatScoreline "TR606Kick", iBaseTime+7, 1, 120, 3.00

        beatScoreline "TR606Snare", iBaseTime+1, 1, 60, 3.00
        beatScoreline "TR606Snare", iBaseTime+3, 1, 60, 3.00
        beatScoreline "TR606Snare", iBaseTime+5, 1, 60, 3.00
        beatScoreline "TR606Snare", iBaseTime+7, 1, 60, 3.00

        beatScoreline "TR606ClosedHat", iBaseTime+0.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+0.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+1.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+1.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+2.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+2.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+3.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+3.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+4.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+4.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+5.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+5.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+6.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+6.5, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+7.0, 1, 50, 3.00
        beatScoreline "TR606ClosedHat", iBaseTime+7.5, 1, 50, 3.00

        if iMeasureCount % 4 == 3 then
          beatScoreline "SimpleOscillator", iBaseTime+0.0, 1, 60, 6.02
          beatScoreline "SimpleOscillator", iBaseTime+1.0, 1, 60, 5.02
          beatScoreline "SimpleOscillator", iBaseTime+2.0, 1, 60, 5.09
          beatScoreline "SimpleOscillator", iBaseTime+3.0, 2, 60, 5.06
          beatScoreline "SimpleOscillator", iBaseTime+5.0, 3, 60, 6.00

        endif

        iMeasureIndex += 1
      od

      beatScoreline "FlowingTrumpetingOvertones", 0, beatsToSeconds(p3), 120, 1.10
      beatScoreline "FlowingTrumpetingOvertones", 0.01, beatsToSeconds(p3), 120, 1.10
      gkLayeredBassSynthFader = .75
      gkKissingMyLoveSpankyBreakFader = .1
      gkFlowingTrumpetingOvertonesFader = .15
    endin

    beatScoreline "config", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1
    beatScoreline "WorkingPattern", 0, 128
    beatScoreline "GlobalFxTapeWobble", 0, -1

  </CsInstruments>
  <CsScore>
  </CsScore>
</CsoundSynthesizer>
