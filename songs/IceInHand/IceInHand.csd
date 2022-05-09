<CsoundSynthesizer>
  <CsOptions>
    -odac
    ; --midi-device=a
    --messagelevel=0
    -B512 -b256
    -t80
    ; -W -o "IceInHand-v0.0.wav"
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
    #include "songs/IceInHand/patterns/pattern-manifest.orc"


    alwayson "DrumDist"

    instr config
      ; gkDrumsStereoShifterLeftPan = oscil(50, 1/beatsToSeconds(8), -1, 0) + 50
      ; gkDrumsStereoShifterRightPan = oscil(50, 1/beatsToSeconds(8), -1, 0.5) + 50

      gkClosedHatFader = 0.55
      gkOpenHat1Fader = 0.55
      gkClosedHatPan = 40
      gkOpenHat1Pan = 40

      gkStabPan = 70
      gkIcemanLoopPan = 40

      gkDrumDistPreGain = 80
      giDrumDistLimit = 10
      gkDrumDistWetAmount = 0.05
      gkDrumDistDryAmount = 1

      gkDrumPostBusFader = 0.25

      gkDrumsEqBass = 2
    endin

    instr DrumCut
      gkDrumPostBusFader = 0
    endin

    instr Verse
      _ "DrumCut", 24, 3
      _ "DrumCut", 56, 4

      _ "VerseLoop", 0, secondsToBeats(p3)
      _ "DrumLoop1", 0, secondsToBeats(p3)
    endin

  </CsInstruments>
  <CsScore>
    ; i "Metronome" 0 3600
    i "config" 0 -1
    ; i "Section" + 16 "CleanLoop"
    i "Section" + 64 "Verse"
  </CsScore>
</CsoundSynthesizer>
