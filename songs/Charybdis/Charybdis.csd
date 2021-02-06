<CsoundSynthesizer>
  <CsOptions>
      -Ma
      -m0
      -odac
      -t100
      ; -W -o "Charybdisv0.1.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/Charybdis/config/MidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "patterns/pattern-manifest.orc"
    #include "songs/Charybdis/instruments/orchestra-manifest.orc"
    #include "songs/Charybdis/patterns/pattern-manifest.orc"

    instr config
      gaDelayForDustyBassGrainTime = oscil(.1, .05) + 3
      gkDelayForDustyBassGrainFeedbackAmount = .5
    endin
    beatScoreline "config", 0, -1

    instr PatternOne
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 6
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        ; beatScoreline "CharybdisLoop2", iBaseTime, 3, 120, .5, 0
        ; beatScoreline "CharybdisLoop2", iBaseTime+3, 3, 120, .5, 0

        ; beatScoreline "Distorted808Kick", iBaseTime+6, 4, 90, .8
        ; beatScoreline "Distorted808Kick", iBaseTime+7, 4, 90, .8
        ; beatScoreline "Distorted808Kick", iBaseTime+8, 4, 90, .8
        ; beatScoreline "Distorted808Kick", iBaseTime+9, 4, 90, .8
        ; beatScoreline "Distorted808Kick", iBaseTime+10, 4, 90, .8
        ; beatScoreline "Distorted808Kick", iBaseTime+11, 4, 90, .8


        ; beatScoreline "RaspingTone", iBaseTime+0, 12, 100, 100
        beatScoreline "CharybdisLoop1", iBaseTime+0, 3, 120, 1, 1
        beatScoreline "CharybdisLoop1", iBaseTime+3, 3, 120, 1, 1

        ; beatScoreline "CharybdisLoop1", iBaseTime+6, 2, 120, 1, 1
        ; ; beatScoreline "CharybdisLoop1", iBaseTime+7, 1, 120, 1, 1
        ; beatScoreline "CharybdisLoop1", iBaseTime+8, 2, 120, 1, 1
        ; ; beatScoreline "CharybdisLoop1", iBaseTime+9, 1, 120, 1, 1
        ; beatScoreline "CharybdisLoop1", iBaseTime+10, 2, 120, 1, 1
        ; ; beatScoreline "CharybdisLoop1", iBaseTime+11, 1, 120, 1, 1

        ; beatScoreline "CharybdisLoop1", iBaseTime+12, 6, 120, 1
        ; beatScoreline "CharybdisLoop1", iBaseTime+18, 6, 120, 1
        iMeasureIndex += 1
      od
    endin

    instr CharybdisHits
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 1
      iMeasureIndex = 0
      iKickVelocity = p4 == 0 ? 90 : p4
      iHitVelocity = p5 == 0 ? 120 : p5

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "Distorted808Kick", iBaseTime, 4, iKickVelocity, .8
        beatScoreline "CharybdisLoop1", iBaseTime, 1, iHitVelocity, 1

        iMeasureIndex += 1
      od
    endin

    instr Segue
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 14
      iMeasureIndex = 0

      beatScoreline "RaspingTone", 0, 6, 100, 261
      if iPatternLength > 6 then
        beatScoreline "CharybdisHits", 6, iPatternLength-6
      endif
    endin

    instr CirclingTheMaw
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 6
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "Distorted808Kick", iBaseTime, 4, 90, .8
        beatScoreline "Distorted808Kick", iBaseTime+3, 4, 90, .85+((iMeasureCount%2)/10)
        beatScoreline "Distorted808Kick", iBaseTime+5, 4, 90, .75-((iMeasureCount%2)/10)

        beatScoreline "CharybdisLoop1", iBaseTime, 6, 120, 1
        iMeasureIndex += 1
      od
    endin

    instr ExitMaw
      beatScoreline "CharybdisLoop1", 0, 1, 120, 1
      beatScoreline "DelayForCharybdisLoop1", 0, 1

      ; gaDelayForCharybdisLoop1Time = linseg(beatsToSeconds(.5),  beatsToSeconds(2), beatsToSeconds(.5), beatsToSeconds(1), beatsToSeconds(.25), beatsToSeconds(3), beatsToSeconds(1))
      ; gkDelayForCharybdisLoop1FeedbackAmount
    endin

    instr EvenSlog
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 6
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "CharybdisLoop2", iBaseTime, 3, 120, .5, 0
        beatScoreline "CharybdisLoop2", iBaseTime+3, 3, 120, .5, 0

        beatScoreline "Distorted808Kick", iBaseTime, 4, 90, .8
        beatScoreline "Distorted808Kick", iBaseTime+3, 4, 90, 1
        beatScoreline "Distorted808Kick", iBaseTime+5, 4, 90, .6

        beatScoreline "DefaultSnare", iBaseTime+3, 1, 100, .8

        beatScoreline "DustyBass", iBaseTime+0, 3, 100, (iMeasureCount%4!=0 ? 3.09 : 3.07)

        ; beatScoreline "CharybdisLoop1", iBaseTime, 12, 120, .5
        ; beatScoreline "CharybdisLoop1", iBaseTime+12, 6, 120, 1
        ; beatScoreline "CharybdisLoop1", iBaseTime+18, 6, 120, 1
        iMeasureIndex += 1
      od
    endin


    instr SlowMisery
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 6
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "CharybdisLoop2", iBaseTime, 3.5, 120, .5, 0
        beatScoreline "CharybdisLoop2", iBaseTime+3.5, 2.5, 120, .5, 0
        iMeasureIndex += 1
      od
    endin

    beatScoreline "ChorusForRaspingTone", 0, -1

  </CsInstruments>
  <CsScore>
    ; i "Segue" 0 13
    ; i "CirclingTheMaw" 13 24
    ; i "ExitMaw" 0 8
    ; i "EvenSlog" 8 128

    ; i "CirclingTheMaw" 0 12

    ; The Grain Shofars are lining up really nicely in this layout. I should note
    ; the parts I want to line up and leave this less up to chance.
    ; i "DustyBassGrain" 0 -1 30 2.07
    ; i "DelayForDustyBassGrain" 0 -1
    ; i "SlowMisery" 0 48
    ; i "EvenSlog" 48 48
    ; i "Segue" 96 13
    ; i "CirclingTheMaw" 109 48
    ; i "ExitMaw" 157 4 120 1
    ; i "EvenSlog" 165 48

    ; Current Song Layout
    i "DustyBassGrain" 0 -1 30 2.07
    i "DelayForDustyBassGrain" 0 -1
    i "SlowMisery" 0 48
    i "EvenSlog" 48 72
    i "Segue" 120 14
    i "CirclingTheMaw" 134 48
    i "ExitMaw" 182 4
    i "EvenSlog" 192 72
  </CsScore>
</CsoundSynthesizer>
