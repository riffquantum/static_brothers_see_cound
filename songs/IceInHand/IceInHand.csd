<CsoundSynthesizer>
  <CsOptions>
    -odac
    ; --midi-device=a
    --messagelevel=0
    ; -B512 -b256
    -t80
    ; -W -o "IceInHand-v0.3.wav"
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "patterns/pattern-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    #include "songs/IceInHand/instruments/orchestra-manifest.orc"

    instr config
      ; Drums
      gkDrumsEqBass = 2
      gkDrumDistPreGain = 80
      giDrumDistLimit = 10
      gkDrumDistWetAmount = 0.05
      gkDrumDistDryAmount = 1
      gkDrumPostBusFader = 0.175
      gkClosedHatFader = 0.55
      gkOpenHat1Fader = 0.55
      gkClosedHatPan = 40
      gkOpenHat1Pan = 40

      ; Samples
      gkStabPan = 70
      gkStabFader = .9
      gkIcemanLoopPan = 40
      gkIcemanLoopFader = 1

      gkIcemanLoop2Pan = 45
      gkIcemanFlutePan = 35

      ; Tape Wobble
      gaGlobalFxTapeWobbleAmount = .0075
      gaGlobalFxTapeWobbleSpeed = .75
    endin

    #include "songs/IceInHand/patterns/pattern-manifest.orc"

    instr DrumCut
      gkDrumPostBusFader = 0
    endin


    instr TapeFlutter
      gaGlobalFxTapeWobbleSpeed = p4
      if p5 != 0 then
        gaGlobalFxTapeWobbleAmount = p5
      endif
    endin

    #define FLUTE_STRETCH_SETTINGS #
      kTimeStretch = .1
      kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
      kTimeStretch = 1 + poscil(1, .25) + poscil(.2, .3) * linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 0)
      kTimeStretch = .1 ;.25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
      kGrainSizeAdjustment = .01 ;* linseg(1, beatsToSeconds(1), 1, beatsToSeconds(3), .2)
      kGrainFrequencyAdjustment = 4 ; .5 * linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
      kPitchAdjustment = linseg(1, p3, .1)
      kGrainOverlapPercentageAdjustment = .9 ;2 * linseg(1, beatsToSeconds(3), 1, beatsToSeconds(1), 5)
    #
    $SYNCLOOP_SAMPLER(FluteStretch'Mixer'localSamples/IcemanFlute.wav'$FLUTE_STRETCH_SETTINGS'0'1.2)


    instr WorkingPattern
      $PATTERN_LOOP(4)

      $END_PATTERN_LOOP
    endin


  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    i "config" 0 -1
    i "GlobalFxTapeWobble" 0 -1

    i "Section" + 16 "CleanLoop"
    i "Section" + 64 "Verse"
    i "Section" + 96 "Chorus"
    i "Section" + 35.9 "PianoInterrupt"
    i "Section" + 32 "Verse"
    i "Section" + 4 "Outro"
    ; ; i "Section" ^+68 32 "Bridge"
    ; e

    ; i "ChorusLoop" 0 200
    ; i "ChorusDrumLoop" 0 200
    ; i "ChorusFluteLoop" 0 200

    ; i "Section" + 16 "DelayBridge"
    ; i "Section" + 35.9 "PianoInterrupt"
    ; i "Section" + 32 "Verse"
    ; i "Section" + 48 "WorkingPattern"
    ; i "Section" + 16 "Verse"
  </CsScore>
</CsoundSynthesizer>
