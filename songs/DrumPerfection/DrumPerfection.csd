<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t80
    -odac
    ; -W -o "DrumPerfection.wav" -m0
  </CsOptions>

  <CsInstruments>
  #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/DrumPerfection/instruments/orchestra-manifest.orc"
    #include "songs/DrumPerfection/patterns/pattern-manifest.orc"
    ; #include "instruments/DrumKits/LinnDrumKit/LinnDrumKit-manifest.orc"
    ; #include "instruments/DrumKits/TR606/TR606Kit-manifest.orc"

    instr Config
      gkDrumKitReverbEqBass = 0
      gkDrumKitReverbEqMid = .25 + poscil(.25, 1/beatsToSeconds(16))
      gkDrumKitReverbWetAmount = .05;poscil(.01, 1/beatsToSeconds(8), -1, 1) + .03

      ; gkDrumKitLPFAmount = poscil(.5, 1/beatsToSeconds(16), -1, 1) + .5
      gkDrumKitLPFHalfPowerPoint = poscil(1000, 1/beatsToSeconds(16)) + 1100

      gkDrumKitKickLPFAmount = 1
      gkDrumKitKickLPFHalfPowerPoint = 200 ;+ poscil(100, 1/beatsToSeconds(16))

      gkDrumKitLPFAmount = 0.25

      gkSnareFader = .55
      gkRimFader = .25

      gkRideBellPan = 60
      gkClosedHatPan = 40
      gkSnarePan = 45
      gkHeftyPan = 45
      gkRimPan = 45
      gkCrashPan = 30

      ; gkSnareEqHigh = 50
      ; gkSnareEqBass = 50
      gkSnareEqMid = 2
      gkSnareFader = 1.13

      ; gkSineWaveForKickFrequency = 60 * (1 + oscil(.3, .3))

      gkDrumKitChorusAmount = 2
    endin

    beatScoreline "DrumKitReverb", 0, -1
    beatScoreline "Config", 0, -1
    beatScoreline "DrumKitKickLPF", 0, -1
    beatScoreline "DrumKitLPF", 0, -1
    ; beatScoreline "DrumKitChorus", 0, -1
    beatScoreline "DrumPattern1", 1, 128
  </CsInstruments>

  <CsScore>
  </CsScore>
</CsoundSynthesizer>
