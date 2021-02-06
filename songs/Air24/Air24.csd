<CsoundSynthesizer>
  <CsOptions>
      -odac
      -Ma
      -m0
      ; -W -o "MaskDancev0.1.wav" -m0
      -iadc
      ; -B512 -b60
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

      gkDefaultEffectChainChorusAmount = oscil(2, .5) + 1
      gkDefaultEffectChainChorusWetAmount = .5
      gkDefaultEffectChainChorusDryAmount = 1
      giMetronomeIsOn = 1
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
      beatScoreline "DrumPattern", secondsToBeats(19), 50
      beatScoreline "TurbineLoop1", secondsToBeats(19), 192
      beatScoreline "BreezeNudge", secondsToBeats(19), 1.361754, 89, 1.020000
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
      */

    endin

    beatScoreline "config", 0, -1
    beatScoreline "PatternWriter", 0, -1, 24
    beatScoreline "DefaultDrumKitReverb", 0 , -1
    ; beatScoreline "NewInstrumentEffectChainDelay", 0, -1
  </CsInstruments>
  <CsScore>
    i "SuperStructure" 0 500


    ; i "intro" 0  24

    ; i "VerseOutline" 0 360
    ; i "DrumPattern" 0 360
    ; i "DrumPattern" 0 360

  </CsScore>
</CsoundSynthesizer>
