<CsoundSynthesizer>
  <CsOptions>
    -odac
    --messagelevel=0
    --midi-device=a
    -t57.61
    ; -t72 ;and it's in 5
    ; -W -o "songs/ZZZBottom/ZZZBottom-v0.2.wav"
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/ZZZBottom/config/midiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/ZZZBottom/instruments/orchestra-manifest.orc"
    #include "songs/ZZZBottom/patterns/pattern-manifest.orc"

    instr config
      gkPreClipMixerFader = .5
      gkPostClipMixerFader = 1

      gkItsOnlyLoveFader = 1.5

      gkKickFader = .5

      gkGrowlOnFader = .8

      gkBassToneEqBass = .8
      gkBassToneFader = 1
      gkBassTonePan = 48

      gkDistorted808KickPan = 53
      gkDistorted808KickFader = 1
      giDistorted808KickFinalGainAmount = .4

      gkDescentTwinkleFader = .5
      gkDescentTwinklePan = 40

      gkDescentTwinkle2Pan = 75
      gkDescentTwinkle2Fader = .6

      gkSnarePan = 45
      gkClosedHatPan = 40
      gkOpenHatPan = 60
    endin

    instr Intro
      beatScoreline "DescentTwinkle", 0, 48, 100, 3.05
      beatScoreline "DescentTwinkle", 0, 48, 100, 2.05
      beatScoreline "GrowlOn", 0, 24, 100,  2.02

      beatScoreline "GrowlOnPattern1", 8, 40
      beatScoreline "DrumPattern1", 16, 32
      beatScoreline "BassLine1", 32, 16
    endin

    instr Verse
      iPatternLength = secondsToBeats(p3)
      iIncludeCounterMelody = p4
      iBeatsPerMeasure = 32
      iMeasureCount = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        beatScoreline "GrowlOnPattern1", iBaseTime, iBeatsPerMeasure
        beatScoreline "DrumPattern1", iBaseTime, iBeatsPerMeasure
        beatScoreline "BassLine1", iBaseTime, iBeatsPerMeasure

        beatScoreline "TwinkleMelodyShort", iBaseTime, 16
        beatScoreline "TwinkleMelodyLong", iBaseTime+16, 16, iMeasureCount

        if iIncludeCounterMelody == 1 then
          beatScoreline "Twinkle2CounterMelodyShort", iBaseTime, 32
        endif

        iMeasureCount += 1
      od
    endin

    instr Bridge
      beatScoreline "DescentTwinkle2", 0, 2, 70,  4.02
      beatScoreline "DescentTwinkle2", 2.05, 2, 70,  4.05
      beatScoreline "DescentTwinkle2", 4, 4, 70,  3.02
      beatScoreline "DescentTwinkle", 0, 4, 100, 3.05

      beatScoreline "DescentTwinkle2", 4.35, 16, 100,  4.09
      beatScoreline "DescentTwinkle", 4.35, 16, 100, 3.05
      beatScoreline "DescentTwinkle", 16.35, 4, 30, 5.05
      beatScoreline "DescentTwinkle", 14.35, 6, 40, 4.09

      beatScoreline "ItsOnlyLove2", 0.35, 20, 40, 5.02
      beatScoreline "ItsOnlyLove2", 16.85, 1.5, 40, 4.02
      beatScoreline "ItsOnlyLove2", 11.35, 9, 40, 3.07

      gkDescentTwinkle2PitchAdjustment = linseg(1, beatsToSeconds(6), 1, beatsToSeconds(8), 1.01, beatsToSeconds(6), 2, 0, 1)
      gkDescentTwinklePitchAdjustment = linseg(1, beatsToSeconds(4), 1, beatsToSeconds(6), 1.3, beatsToSeconds(8), 2, 0, 1)
    endin

    instr Chorus
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 8
      iMeasureCount = 0

      gkDescentTwinkle2PitchAdjustment = 1
      gkDescentTwinklePitchAdjustment = 1


      ; beatScoreline "ItsOnlyLove", 0, secondsToBeats(p3), 80, 3.09
      gkItsOnlyLove2Pan = oscil(25, .05) + 50
      beatScoreline "ItsOnlyLove2", 0, secondsToBeats(p3), 40, 5.02

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure


        beatScoreline "DescentTwinkle2", iBaseTime+0, .1, 50,  4.07
        beatScoreline "Distorted808Kick", iBaseTime+0, 1, 120, .5

        if iMeasureCount % 2 == 0 then
          beatScoreline "DescentTwinkle2", iBaseTime+0.75, .1, 50,  4.07
          beatScoreline "Distorted808Kick", iBaseTime+0.75, 1, 120, .5
        else
          beatScoreline "DescentTwinkle2", iBaseTime+0.5, .1, 50,  4.07
          beatScoreline "Distorted808Kick", iBaseTime+0.5, 1, 120, .5
        endif

        beatScoreline "DescentTwinkle2", iBaseTime+1, .1, 50,  4.07
        beatScoreline "Distorted808Kick", iBaseTime+1, 1, 120, .5

        beatScoreline "DescentTwinkle2", iBaseTime+0, 8, 30,  5.09
        beatScoreline "DescentTwinkle", iBaseTime+0, 8, 30,  6.09


        beatScoreline "OpenHat", iBaseTime+0.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+0.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+0.75, 1, 100,  1.1

        beatScoreline "OpenHat", iBaseTime+1.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+1.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+1.75, 1, 100,  1.1

        beatScoreline "OpenHat", iBaseTime+2.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+2.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+2.75, 1, 100,  1.1

        beatScoreline "OpenHat", iBaseTime+3.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+3.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+3.75, 1, 100,  1.1

        beatScoreline "OpenHat", iBaseTime+4.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+4.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+4.75, 1, 100,  1.1

        beatScoreline "OpenHat", iBaseTime+5.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+5.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+5.75, 1, 100,  1.1

        beatScoreline "Snare", iBaseTime+4, 1, 100,  .6
        beatScoreline "Snare", iBaseTime+4, 1, 100,  1

        beatScoreline "OpenHat", iBaseTime+6.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+6.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+6.75, 1, 100,  1.1

        beatScoreline "OpenHat", iBaseTime+7.0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+7.5, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+7.75, 1, 100,  1.1



        iMeasureCount += 1
      od


    endin

    ; beatScoreline "DrumPattern1", 0, 4

      beatScoreline "config", 0, -1
  </CsInstruments>

  <CsScore>
    ; m section1

      ; i "Chorus" 0 100
      ; i "Verse" 0 100
      ; i "DrumPattern1" 0 100

      i "Intro" 0 48
      i "Verse" 48 32
      i "TwinklePattern1" 80 8
      i "Verse" 88 32 1
      i "Bridge" 120 20
      i "Chorus" 140 64
      i "Verse" 204 32

      ; i "Bridge" 0 20
      ; i "Chorus" 20 32

      ; i "Verse" 0 32 1
      ; i "Bridge" 32 16
      ; i "Chorus" 48 32
      ; i "Verse" 80 32 1

    ; s
  </CsScore>
</CsoundSynthesizer>
