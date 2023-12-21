<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    ; -W -o "PurpleAndTurquoisev0.1.wav"
    ; -Ma
    -m0
    -B512 -b256
    -t90
    ; Hark, a frozen disk spins into view
    ; Warpath to heated
    ; Fortunes deleted
    ; A gibbering spike, it gently accrues, a ruse,
    ; too empty to use
    ; too kit to refuse

    ; My preference would be to avoid it entirely, the armature's floppy
    ; No structure or backbone, as likely to shield me as stalk
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/PurpleAndTurquoise/instruments/orchestra-manifest.orc"
    #include "songs/PurpleAndTurquoise/patterns/pattern-manifest.orc"

    instr config
      gkMuffledKickFader = 4
      gkMuffledKickEqMid = 2

      gkTwistedUpKickFader = (0.75 + oscil(0.05, 0.2))
      gkTwistedUpKickEqBass = 2
      gkTwistedUpKickReverbFader = 0.5
      gkTwistedUpKickPan = 40 + oscil(10, 0.05, -1, .75)

      gkBassSynthFader = 0.35

      gkVibeLineGrainPan = 60

      gaGlobalFxTapeWobbleAmount = .2
      gaGlobalFxTapeWobbleSpeed = 0.25
      gkGlobalFxTapeWobbleDryAmount = 0.75
      gkGlobalFxTapeWobbleWetAmount = 0.25


      gaTwistedUpKickDelayTime = .005 + oscil(.00005, 2) + oscil(.0025, .01)
      gkTwistedUpKickDelayXWetAmount = .25 ;+ oscil(.2, .1, -1, 0.75)
      gkTwistedUpKickDelayPan = 90

      gkVibeLineGrainPitchAdjustment = 1 + oscil(0.015, 0.3) ;loopseg 1/beatsToSeconds(8), 0, 0, 1, beatsToSeconds(4), 1, beatsToSeconds(4), 0.5
      gkBassSynthEqBass = 1.25 + oscil(0.25, .01, -1, 0.75)
    endin

    instr WorkingPattern
      gkTwistedUpKickFader = (0.75 + oscil(0.05, 0.2)) * linseg(0, beatsToSeconds(16), 0, beatsToSeconds(16), 1, 0.1, 1)

      $PATTERN_LOOP(8)
        beatScoreline "BassSynth", iBaseTime, 4, 100, 2.00

        if iMeasureCount % 24 == 0 then
          beatScoreline "GlobalFxFreezer", iBaseTime+1, .25, .25
        endif


        if iMeasureCount % 4 == 0 then
          beatScoreline "BassSynth", iBaseTime+4, 4, 80, 1.04
          beatScoreline "BassSynth", iBaseTime+4, 4, 80, 2.04

          beatScoreline "TwistedUpKick", iBaseTime, 8, 80, 4.02, 1.9, 20
          beatScoreline "VibeLineGrain", iBaseTime, 8, 150, 2.05
          beatScoreline "VibeLineGrain", iBaseTime, 8.25, 80, 3.05, 0.001

          beatScoreline "Snare", iBaseTime+5+(2/3), 1, 60, 1
          ; beatScoreline "Snare", iBaseTime+6.333, 1, 40, 1
          ; beatScoreline "Snare", iBaseTime+6.666, 1, 40, 1
          ; beatScoreline "Snare", iBaseTime+7.33, 1, 40, 1
          beatScoreline "Snare", iBaseTime+7.666, 1, 40, 1

        else
          beatScoreline "TwistedUpKick", iBaseTime, 4, 80, 4.02, 1.9, 2 + iMeasureCount/100

          if iMeasureCount % 6 == 5 then
            beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8 + iMeasureCount/1000, 4, 5
          elseif iMeasureCount % 7 == 6 then
            beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8 + iMeasureCount/1000, 4, 5, 3, 0
          elseif iMeasureCount % 8 == 3 then
            beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, .8 + iMeasureCount/1000, 0, 0, 3, 0
          else
            beatScoreline "TwistedUpKick", iBaseTime+4, 4, 80, 4.06, 1.1 + iMeasureCount/1000
          endif

          beatScoreline "BassSynth", iBaseTime+4, 4, 100, 1.04

          beatScoreline "VibeLineGrain", iBaseTime, 4, 150, 3.07, (iMeasureCount % 4 == 3 ? 14 : 0), 0, (iMeasureCount % 16 >= 13 ? .1 : 0)
          beatScoreline "VibeLineGrain", iBaseTime+4, 4, 150, 3.05, 0, 0, (iMeasureCount % 16 >= 13 ? .1 : 0)
        endif

        beatScoreline "MuffledKick", iBaseTime, 2, 127, 1
        beatScoreline "MuffledKick", iBaseTime+1.5, 2, 127, .9
        beatScoreline "MuffledKick", iBaseTime+3.5, 2, 127, .9
        beatScoreline "MuffledKick", iBaseTime+4, 4, 127, 1

        beatScoreline "MuffledKick", iBaseTime+6.5, 2, 127, 1


        beatScoreline "Snare", iBaseTime+1, 1, 120, 1
        beatScoreline "Snare", iBaseTime+1.75, 1, 30, .8
        beatScoreline "Snare", iBaseTime+3, 1, 120, 1
        beatScoreline "Snare", iBaseTime+5, 1, 120, 1
        beatScoreline "Snare", iBaseTime+7, 1, 120, 1

        ; beatScoreline "Snare", iBaseTime+2.25, 1, 60, 1
        ; beatScoreline "Snare", iBaseTime+2.75, 1, 60, 1

      $END_PATTERN_LOOP
    endin

    ; beatScoreline "GlobalFxTapeWobble", 0, -1
    beatScoreline "BassSynthChorus", 0, -1
    beatScoreline "TwistedUpKickDelay", 0, -1
    beatScoreline "BassSynthDist", 0, -1
    beatScoreline "DelayForSnare", 0, -1
    beatScoreline "TwistedUpKickReverb", 0, -1, 0
    beatScoreline "config", 0, -1
    ; beatScoreline "PatternWriter", 0, -1, 8
  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    ; i "NewLoop" 0 300
    i "WorkingPattern" 1 256
    ; i "Break" 0 400
  </CsScore>
</CsoundSynthesizer>
