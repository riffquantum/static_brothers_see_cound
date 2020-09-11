<CsoundSynthesizer>
  <CsOptions>
      -odac -Ma  -m0
      ; -W -o "VileArcv0.1.wav" -m0
      -iadc
      -B512 -b60
      -t80
      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit/DefaultDrumKit-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    instr config
      gaDefaultEffectChainDelayTime = (poscil(1/8, 1) + .25) * (poscil(2.5, .5) + 2.6) * (poscil(.1, .1) + 1)
      gkSyncLoopSamplerTemplate2Fader = .8
      giDistorted808KickFinalGainAmmount = .75
      gkTwistedUpKickExampleEqBass = 1.5
      gkTwistedUpKickExampleFader = .8
      gkTwistedUpHatExampleFader = .8
      gkPreClipMixerFader = .5
    endin

    giMetronomeIsOn = 0

    instr Intro
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 8
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1


        beatScoreline "Distorted808Kick", iBaseTime, 2, 127, .5
        beatScoreline "DefaultKick", iBaseTime, 2, 127, 1


        beatScoreline "TwistedUpHatExample", iBaseTime+2, 1.7, 100, 3.05
        beatScoreline "TwistedUpHatExample", iBaseTime+7, 1.7, 100, 3.045
        ; beatScoreline "TwistedUpHatExample", iBaseTime+5, 3, 100, 3.05



        beatScoreline "DefaultKick", iBaseTime+5.5, 2, 127, 1
        beatScoreline "Distorted808Kick", iBaseTime+5.5, 2, 127, .5
        beatScoreline "DefaultKick", iBaseTime+6, 2, 127, 1
        beatScoreline "Distorted808Kick", iBaseTime+6, 2, 127, .4

        ; beatScoreline "TwistedUpKickExample", iBaseTime+0, 4, 100, 3.05
        ; beatScoreline "TwistedUpKickExample", iBaseTime+4, 4, 100, 3.05
        ; beatScoreline "TwistedUpKickExample", iBaseTime+8, 4, 120, 3.05
        ; beatScoreline "TwistedUpKickExample", iBaseTime+12, 4, 120, 3.05



        beatScoreline "SyncLoopSamplerTemplate2", iBaseTime, 12, 127, 2.01
        ; beatScoreline "SyncLoopSamplerTemplate2", iBaseTime+7, 2, 120, 4.06
        iMeasureIndex += 1
      od
    endin


    instr VersePattern1
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 8
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "DefaultSnare", iBaseTime+1.05, 1, 127, 1
        beatScoreline "DefaultSnare", iBaseTime+3, 1, 127, 1
        beatScoreline "DefaultSnare", iBaseTime+5, 1, 127, 1
        beatScoreline "DefaultSnare", iBaseTime+7, 1, 127, 1

        beatScoreline "Distorted808Kick", iBaseTime, 2, 127, .5
        beatScoreline "DefaultKick", iBaseTime, 2, 127, 1
        beatScoreline "DefaultKick", iBaseTime+3.5, 2, 127, 1
        beatScoreline "DefaultKick", iBaseTime+4, 2, 127, 1
        beatScoreline "Distorted808Kick", iBaseTime+4, 2, 127, .4
        beatScoreline "Distorted808Kick", iBaseTime+3.5, 2, 127, .5

        beatScoreline "TwistedUpKickExample", iBaseTime+0, 4, 100, 3.05
        beatScoreline "TwistedUpKickExample", iBaseTime+4, 4, 100, 3.05
        ; beatScoreline "TwistedUpKickExample", iBaseTime+8, 4, 120, 3.05
        ; beatScoreline "TwistedUpKickExample", iBaseTime+12, 4, 120, 3.05

        beatScoreline "TwistedUpHatExample", iBaseTime, iBeatsPerMeasure, 100, 3.05

        if iMeasureCount > 4 then
          beatScoreline "TwistedUpHatExample", iBaseTime, iBeatsPerMeasure, 40, 2.05
        endif

        beatScoreline "SyncLoopSamplerTemplate2", iBaseTime+0.0, 2.5, 120, 2.06
        beatScoreline "SyncLoopSamplerTemplate2", iBaseTime+0.0, 2.5, 120, 4.06

        beatScoreline "SyncLoopSamplerTemplate2", iBaseTime+3, 5, 127, 2.01
        ; beatScoreline "SyncLoopSamplerTemplate2", iBaseTime+7, 2, 120, 4.06
        iMeasureIndex += 1
      od
    endin

    instr Bridge
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 16
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex * iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "SyncLoopSamplerTemplate2", iBaseTime, 16, 120, 2.06
        beatScoreline "SyncLoopSamplerTemplate2", iBaseTime, 16, 120, 4.06

        iMeasureIndex += 1
      od
    endin

    beatScoreline "config", 0, -1
    beatScoreline "DefaultEffectChainReverb", 0, -1

  </CsInstruments>
  <CsScore>
    i "VersePattern1" 0 128
    ; i "Intro" 0 8
    ; i "Bridge" 8 16
    ; i "VersePattern1" 24 128
  </CsScore>
</CsoundSynthesizer>
