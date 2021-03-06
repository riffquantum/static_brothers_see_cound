<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t87.5
    -odac
    ; -W -o "TriplePortrait.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/TriplePortrait/config/midiAssignments.orc"
    gkBPM init 87.5

    #include "opcodes/opcode-manifest.orc"
    #include "songs/TriplePortrait/config/MidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/TriplePortrait/instruments/orchestra-manifest.orc"
    #include "config/defaultMidiRouterEvents.orc"
    #include "songs/TriplePortrait/patterns/pattern-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"

    instr DrumLoop
      iPatternLength = secondsToBeats(p3)
      iMode = p4
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      if iMode == 0 || iMode ==1 then
        gkTriplePortraitLoop1Pan = 50
        gkTriplePortraitLoop2Pan = 50
      elseif iMode == 2 then
        gkTriplePortraitLoop1Pan = 0
        gkTriplePortraitLoop2Pan = 100
      elseif iMode == 3 then
        gkTriplePortraitLoop2Pan = 0
        gkTriplePortraitLoop1Pan = 100
      endif
      ; gkTriplePortraitLoop1Pan = oscil(50, 1/beatsToSeconds(8)) + 50
      ; gkTriplePortraitLoop2Pan = 100 - (oscil(50, 1/beatsToSeconds(8)) + 50)

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure
        ; beatScoreline "YiSynth1", iBaseTime, 8, 127, 5.10
        ; beatScoreline "YiSynth1", iBaseTime, 8, 127, 4.10


        if iMode == 0 then
          beatScoreline "TriplePortraitLoop2", iBaseTime, 8, 120, 1
        elseif iMode ==1 then
          beatScoreline "TriplePortraitLoop1", iBaseTime, 8, 120, 1
        elseif iMode == 2 || iMode == 3 then
          beatScoreline "TriplePortraitLoop1", iBaseTime, 8, 70, 1
          beatScoreline "TriplePortraitLoop2", iBaseTime, 8, 70, 1
        endif

        ; beatScoreline "santanaBell2", iBaseTime, 16, 40, .1, 10

        ; beatScoreline "Distorted808Kick", iBaseTime+4, 4, 120, .75
        ; beatScoreline "DustyBass", iBaseTime+0, 4, 100, 3.04
        ; beatScoreline "DustyBass", iBaseTime+4, 4, 100, 3.06

        iMeasureCount += 1
      od
    endin

    instr Pattern2
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0
      ; gkTriplePortraitLoop1Pan = oscil(50, 1/beatsToSeconds(8)) + 50
      ; gkTriplePortraitLoop2Pan = 100 - (oscil(50, 1/beatsToSeconds(8)) + 50)

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure
        beatScoreline "ItsExpected", iBaseTime, 8, 120, 4
        iMeasureCount += 1
      od
    endin

    instr Pattern4
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 32
      iMeasureCount = 0
      iSampleMode = 0
      ; gkTriplePortraitLoop1Pan = oscil(50, 1/beatsToSeconds(8)) + 50
      ; gkTriplePortraitLoop2Pan = 100 - (oscil(50, 1/beatsToSeconds(8)) + 50)

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure
        beatScoreline "DrumLoop", iBaseTime, 16, 0
        beatScoreline "DrumLoop", iBaseTime+16, 8, 2
        beatScoreline "DrumLoop", iBaseTime+24, 8, 3
        iMeasureCount += 1
      od
    endin

    instr config
      ; gkDistorted808KickPreGain = 50
      gkDistorted808KickPostGain = 1
      gkDistorted808KickDutyOffset = .001
      gkDistorted808KickSlopeShift = .001
      giDistorted808KickStage2ClipLevel = 0dbfs/2
      giDistorted808KickFinalGainAmount = .15
    endin
    beatScoreline "config", 0, -1

  </CsInstruments>

  <CsScore>
    ; m section1
      i "Pattern4" 0 128
      i "PatternWriter" 0 128 8

    ; s
  </CsScore>
</CsoundSynthesizer>
