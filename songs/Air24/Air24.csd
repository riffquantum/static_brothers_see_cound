<CsoundSynthesizer>
  <CsOptions>
      -odac
      -W -o "Credits.wav
      --midi-device=a
      --messagelevel=0
      -iadc
      -t100
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/Air24/config/MidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "songs/Air24/config/midiRouterEvents.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/Air24/instruments/orchestra-manifest.orc"
    #include "songs/Air24/patterns/pattern-manifest.orc"

    instr config
      ; midiMonitor
      gkDefaultEffectChainReverbWetAmount = .03
      gkMachineSicknessFader = .5
      gkCloudThoughtsFader = .5

      gkDefaultDrumKitReverbWet = .005
      gkDefaultDrumKitBusFader = .75
      gkDefaultDrumKitClosedHatFader = 0.5
      gkDefaultDrumKitClosedRideFader = 0.5

      gkKickTuning = .5

      gkDefaultRideTuning = 1.3 + oscil(.025, .1)
      gkDefaultRidePan = 60

      gkRimTuning = .7
      gkRimFader = .5

      ; gkHatFlowFader = .75

      gkDefaultEffectChainChorusAmount = oscil(2, .5) + 1
      gkDefaultEffectChainChorusWetAmount = .5
      gkDefaultEffectChainChorusDryAmount = 1
      giMetronomeIsOn = 1
    endin

    ; instr WomanTwirling
    ;   gkHatFlowPan = 50 + (oscil(15, 1) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1), 1, 1, 1))

    ;   $PATTERN_LOOP(24)
    ;     ; beatScoreline "HatFlow", iBaseTime+0.00, 23, 52, 4.0, 1, 1, .25
    ;     ; beatScoreline "HatFlow", iBaseTime+.5, 23, 52, 4.0, 1, 1, .25

    ;     beatScoreline "HatFlow", iBaseTime+0.00, 23, 52, 4.0

    ;     beatScoreline "Rim", iBaseTime+0, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+2, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+4, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+6, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+8, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+10, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+12, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+14, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+16, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+18, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+20, 4, 60, 1
    ;     beatScoreline "Rim", iBaseTime+22, 4, 60, 1

    ;     beatScoreline "Kick", iBaseTime+0, 4, 100, .75
    ;     beatScoreline "Distorted808Kick", iBaseTime+1, 4, 100, .5
    ;     beatScoreline "Rim", iBaseTime+4, 4, 60, .5

    ;     beatScoreline "BreezeNudge", iBaseTime, 24, 73, 2.000000
    ;     beatScoreline "BreezeNudge", iBaseTime, 3, 73, 2.020000
    ;     beatScoreline "BreezeNudge", iBaseTime+2, 3, 73, 2.020000

    ;     beatScoreline "BreezeNudge", iBaseTime+14.5, 6, 73, 2.020000

    ;     beatScoreline "MachineSickness", iBaseTime+0, 24, 20, 3.030000
    ;     beatScoreline "MachineSickness", iBaseTime+0, 24, 20, 2.030000
    ;   $END_PATTERN_LOOP
    ; endin

    instr WomanTwirling
      gkHatFlowFader = linseg(1, beatsToSeconds(12), .75)
      $PATTERN_LOOP(4)
        beatScoreline "Rim", iBaseTime+0, 4, 60, .8
        ; beatScoreline "Rim", iBaseTime+1, 4, 60, .8
        ; beatScoreline "Rim", iBaseTime+2, 4, 60, .8
        ; beatScoreline "Rim", iBaseTime+3, 4, 60, .8
        ; beatScoreline "HatFlow", iBaseTime+0.00, 4, 52, 4.0, 1, 1, .255
      $END_PATTERN_LOOP

      $PATTERN_LOOP(32)
        beatScoreline "BreezeNudge", iBaseTime, 3.346334, 52, 1.070000
        beatScoreline "BreezeNudge", iBaseTime+4.5, 3.346334, 52, 1.055000
        beatScoreline "BreezeNudge", iBaseTime+1, 3.346334, 52, 1.03000

        beatScoreline "BreezeNudge", iBaseTime+15, 3.346334, 52, 1.070000
        ; beatScoreline "BreezeNudge", iBaseTime+15+1, 3.346334, 52, 1.03000
        beatScoreline "BreezeNudge", iBaseTime+15+6.5, 3.346334, 52, 1.04000

        beatScoreline "HatFlow", iBaseTime+0.00, 32, 52, 4.0, 1, 1, .25
        beatScoreline "MachineSickness", iBaseTime+0, 32, 70, 2.030000
        beatScoreline "Distorted808Kick", iBaseTime+0, 4, 100, .75

        beatScoreline "Distorted808Kick", iBaseTime+4.5, 4, 80, .5
        beatScoreline "Distorted808Kick", iBaseTime+6, 4, 100, .5

        beatScoreline "Distorted808Kick", iBaseTime+10, 4, 80, .5
        beatScoreline "Rim", iBaseTime+12, 4, 60, .8

        beatScoreline "DefaultRide", iBaseTime+16, 1, 60, 1
        beatScoreline "DefaultRide", iBaseTime+20, 1, 40, 1

        beatScoreline "Rim", iBaseTime+24, 4, 60, .8

        beatScoreline "CloudThoughts", iBaseTime+0, 32, 60, 2.090000
        beatScoreline "CloudThoughts", iBaseTime+17.602419, 11, 81, 3.050000

        beatScoreline "CloudThoughts", iBaseTime+27, 6, 34, 3.100000
      $END_PATTERN_LOOP

      ; beatScoreline "BreezeNudge", 32+1.105367, 3.346334, 52, 1.000000
      ; beatScoreline "BreezeNudge", 32+4.520635, 4.420257, 60, 1.070000
    endin

    instr ManAlone
      gkHatFlowFader = linseg(1, beatsToSeconds(12), .75)

      $PATTERN_LOOP(32)
        beatScoreline "HatFlow", iBaseTime+0.00, 32, 52, 4.0, 1, 1, .25
        beatScoreline "MachineSickness", iBaseTime+0, 32, 70, 2.030000
        beatScoreline "Distorted808Kick", iBaseTime+0, 4, 100, .75

        beatScoreline "Distorted808Kick", iBaseTime+4.5, 4, 80, .5
        beatScoreline "Distorted808Kick", iBaseTime+6, 4, 100, .5

        beatScoreline "Distorted808Kick", iBaseTime+10, 4, 80, .5
        beatScoreline "Rim", iBaseTime+12, 4, 60, .8

        beatScoreline "DefaultRide", iBaseTime+16, 1, 60, 1
        beatScoreline "DefaultRide", iBaseTime+20, 1, 40, 1

        beatScoreline "Rim", iBaseTime+24, 4, 60, .8

        beatScoreline "CloudThoughts", iBaseTime+0, 32, 60, 2.090000
        beatScoreline "CloudThoughts", iBaseTime+17.602419, 11, 81, 3.050000

        beatScoreline "CloudThoughts", iBaseTime+27, 6, 34, 3.100000
      $END_PATTERN_LOOP

      beatScoreline "BreezeNudge", 32+1.105367, 3.346334, 52, 1.000000
      beatScoreline "BreezeNudge", 32+4.520635, 4.420257, 60, 1.070000
    endin

    instr WomenMarchAndDance
      gkHatFlowPan = 50 + (oscil(15, 1) * linseg(0, beatsToSeconds(20), 0, beatsToSeconds(48), 1, 1, 1))

      beatScoreline "DrumPatternLight", 0, 144
      beatScoreline "TurbineLoop1", 0, 144
      beatScoreline "BreezeNudge", 0, 1.361754, 89, 1.020000

      beatScoreline "Clatter", 48, 24
      beatScoreline "CloudDrift1", 48, 111

      beatScoreline "EmContent", 72, 87
      beatScoreline "OffBreeze", 96, 63

      beatScoreline "HatFlow", 144, 15, 52, 4.0, 1, 1, .25
      beatScoreline "BubblingNudge", 144, 15
    endin

    instr WomenMarchAndDance2
      gkHatFlowPan = 50 + (oscil(15, 1) * linseg(0, beatsToSeconds(20), 0, beatsToSeconds(48), 1, 1, 1))

      beatScoreline "DrumPatternLight", 0, 144
      beatScoreline "TurbineLoop1", 0, 144
      beatScoreline "BreezeNudge", 0, 1.361754, 89, 1.020000

      beatScoreline "Clatter", 48, 24
      beatScoreline "CloudDrift1", 48, 111

      beatScoreline "EmContent", 72, 200
      beatScoreline "OffBreeze", 96, 200

      ; beatScoreline "HatFlow", 144, secondsToBeats(p3) - 144, 52, 4.0, 1, 1, .25
      ; beatScoreline "BubblingNudge", 144, secondsToBeats(p3) - 144
    endin

    instr SuperStructure
      /*
        Opening Eye - 0 - 10
      */
      gkMachineSicknessFader linseg 0, 3, .5
      ; beatScoreline "MachineSickness", iBaseTime+14.165382, 4.178382, 50, 2.050000
      beatScoreline "MachineSickness", secondsToBeats(13), secondsToBeats(6), 80, 3.070000

      ; Swirling Women 10 - 19
      beatScoreline "MachineSickness", 0, secondsToBeats(19), 120, 2.110000

      ; Women March - 19 -  28
      ; beatScoreline "WomenMarchAndDance", secondsToBeats(19), 134
      ; beatScoreline "VerseOutline", secondsToBeats(19), 50

      /*
        Women Dance - 28 - 1:48
        repetitive drum cycle. How can we ramp up intensity? Introduce the verse elements, raise filters and pitches throughout
      */

      /*
        Women Recede - 1:48 - 1:53
        take the twitchy hats down to half time
      */

      /*
        Man Appears - 1:53
        Introduce a deeper, bassy element
        high cloud drift bits
      */

    endin

    instr EndDrone
      ; beatScoreline "EmContent", 0, 200
      beatScoreline "Voidlessness", 0, secondsToBeats(p3), 111, 2.060000
      beatScoreline "OffBreeze", 0, secondsToBeats(p3)
      beatScoreline "GlobalFxDelay", 0, secondsToBeats(p3) + 10
      beatScoreline "GlobalFxReverb", 0, secondsToBeats(p3) + 10

      gkGlobalFxReverbWetAmount = linseg(0, p3*2/3, .3)
      gkGlobalFxDelayLevel = linseg(0, p3/2, 1)
      gaGlobalFxDelayTime = 2 + poscil(.25, .01)

    endin

    instr Credits
      ; beatScoreline "EmContent", 0, 200
      beatScoreline "MachineSickness", 0, secondsToBeats(p3), 115, 2.060000
      ; beatScoreline "MachineSickness", 0, secondsToBeats(p3), 115, 2.10000
      beatScoreline "MachineSickness", 0, secondsToBeats(p3), 100, 3.00000
      beatScoreline "LayeredBassSynth", 0, secondsToBeats(p3), 100, 2.040000

    endin

    instr MiddleSegment
      beatScoreline "GlobalFxDelay", 0, secondsToBeats(p3) + 10
      beatScoreline "GlobalFxReverb", 0, secondsToBeats(p3) + 10
      gkGlobalFxReverbWetAmount = linseg(0, p3*2/3, .3)
      gkGlobalFxDelayLevel = linseg(0, p3/2, 1)
      gaGlobalFxDelayTime = 2 + poscil(.25, .01)

      iTotalMeasures = p3/8
      $PATTERN_LOOP(8)
        if iMeasureCount != 1 && iMeasureCount < (iTotalMeasures-2) then
          beatScoreline "HatFlow", iBaseTime+0.00, 7.5, 32, 4.0

          beatScoreline "Kick", iBaseTime+0, 1, 120, 1

          beatScoreline "DefaultRide", iBaseTime+0.5, 1, 20, 1
          beatScoreline "DefaultRide", iBaseTime+2, 1, 20, 1.2

          beatScoreline "Rim", iBaseTime+6.5, 1, 60, 1
          beatScoreline "Rim", iBaseTime+7, 1, 60, 1
          beatScoreline "Rim", iBaseTime+7.5, 1, 60, 1
        endif
      $END_PATTERN_LOOP

      $PATTERN_LOOP(16)
        beatScoreline "MachineSickness", iBaseTime+0, 16, 70, (iMeasureCount % 2 == 1 ? 2.030000 : 2.06)

        beatScoreline "BreezeNudge", iBaseTime+8.611943, (iMeasureCount % 2 != 0 ? 12.303855 : 4.75), 81, (iMeasureCount % 2 != 0 ? 2.050000 : 2.045)

        if iMeasureCount > 2 then
          beatScoreline "Distorted808Kick", iBaseTime+1.5, 4, 80, .75
          beatScoreline "Voidlessness", iBaseTime+0, 16, 45, 1.040000
        endif
      $END_PATTERN_LOOP
    endin

    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 24
    beatScoreline "DefaultDrumKitReverb", 0 , -1
    ; beatScoreline "NewInstrumentEffectChainDelay", 0, -1
  </CsInstruments>
  <CsScore>
    ; i "SuperStructure" 0 40
    ; i "ManAlone" 0 200
    ; i "WomenMarchAndDance" 0 159
    ; i "WomanTwirling" 0 200

    ; i "WomenMarchAndDance2" 0 144
    ; i "EndDrone" 0 12
    i "Credits" 0 144
    ; i "MiddleSegment" 0 200

    ; i "intro" 0  24

    ; i "VerseOutline" 0 360
    ; i "DrumPattern" 0 360
    ; i "DrumPattern" 0 360

  </CsScore>
</CsoundSynthesizer>
