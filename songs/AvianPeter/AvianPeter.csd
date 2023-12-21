<CsoundSynthesizer>
  <CsOptions>
    --messagelevel=0
    ; --midi-device=a
    -t190
    ; -odac
    -d
    ; --realtime
    -W -o "AvianPeter.wav
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/AvianPeter/instruments/orchestra-manifest.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"
    #include "songs/AvianPeter/patterns/pattern-manifest.orc"

    instr config
      gkPhotoshopSamplesFader = .6

      gkDefaultDrumKitReverbWet = 0.02

      gaVocalEffectChainDelayTime = oscil(.1, .3) + 1

      gkVocalEffectChainReverbWetAmount = 0.05

      gkVocalEffectChainPitchShifterPitch = oscil(.5, .3) + 1
      gkVocalEffectChainPitchShifterWetAmount = .33
      gkVocalEffectChainPitchShifterPan = oscil(50, .1) + 50
    endin

    instr Pattern1
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 4
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        iMeasureCount += 1
      od
    endin

    instr Verse1
      beatScoreline "drumPattern1", 0, 126
      ; beatScoreline "VerseOne", 0, 120, 100, 1
      gkVocalEffectChainPitchShifterPitch = oscil(.5, .3) + 1
      gkVocalEffectChainPitchShifterPan = oscil(50, .1) + 50
      beatScoreline "VocalEffectChainDelay", 0, .25

      beatScoreline "VocalEffectChainDelay", 21, .25
      beatScoreline "VocalEffectChainDelay", 40, .25
      beatScoreline "VocalEffectChainDelay", 60, .25
      beatScoreline "VocalEffectChainDelay", 100, .25
      beatScoreline "VocalEffectChainDelay", 119, 1
    endin

    instr Verse2
      beatScoreline "drumPattern1", 0, 126
      ; beatScoreline "VerseTwo", 0, 95, 127, 1

      beatScoreline "VocalEffectChainDelay", 0, .25
      beatScoreline "VocalEffectChainDelay", 21, .25
      beatScoreline "VocalEffectChainDelay", 40, .25
      beatScoreline "VocalEffectChainDelay", 60, .25
      beatScoreline "VocalEffectChainDelay", 94, 1
    endin
      ; beatScoreline "segue2", 96, 8

    beatScoreline "config", 0, -1
    ; beatScoreline "VocalEffectChainCompressor", 0, -1
    beatScoreline "VocalEffectChainReverb", 0, -1
    beatScoreline "VocalEffectChainPitchShifter", 0, -1, .8



    ; beatScoreline "segue1", 0, 4
    ; beatScoreline "drumPattern1", 4, 84

    ; ;verse 1

    ; beatScoreline "segue2", 234, 8
    ; beatScoreline "drumPattern1", 242, 126

    ; beatScoreline "OpenHat", 0, 1, 100, 1
    ; beatScoreline "HatPedal", 1, 1, 120, 1
    ; beatScoreline "ClosedHat", 2, 1, 120, 1

  </CsInstruments>
  <CsScore>
    i "segue1" 0 4
    i "drumPattern1" 4 84

    i "OpenHat" 0 1 100 1
    i "HatPedal" 1 1 120 1
    i "ClosedHat" 2 1 120 1

    i "segue2" 100 8
    i "Verse1" 108 126
    ; ;verse 1

    i "segue2" 238 8
    i "Verse2" 246 126

    ; i "Verse1" 0 126


  </CsScore>
</CsoundSynthesizer>
