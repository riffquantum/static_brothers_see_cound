<CsoundSynthesizer>
  <CsOptions>
      -odac
      ; -W -o "newLoop.wav"
      -Ma
      -m0
      ; -iadc
      ; --realtime
      ; -B512 -b256
      -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
      ; -B4096 -b4096
      -t100      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMappingWithSPD30.orc"
    ; #include "config/guitarMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/BirdshitDrumKit.orc"
    #include "instruments/DrumKits/AvianPeterDrumKit.orc"
    #include "instruments/DrumKits/CharybdisDrumKit.orc"
    #include "instruments/DrumKits/VileArcDrumKit.orc"

    ; #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "config/defaultMidiRouterEvents.orc"

    giCurrentSong init 0

    if giCurrentSong == 0 then
      beatScoreline "BirdshitConfig", 0, -1
    elseif giCurrentSong == 1 then
      beatScoreline "AvianPeterConfig", 0, -1
    elseif giCurrentSong == 2 then
      beatScoreline "CharybdisConfig", 0, -1
    elseif giCurrentSong == 3 then
      beatScoreline "VileArcConfig", 0, -1
    endif

    instr config
      ; midiMonitor

      gkBirdshitKickBusEqBass = 1.5
      ; gkBirdshitFxMainReverbWetAmount = 0.025
    endin

    instr SwitchSong
      giCurrentSong = p6

      print giCurrentSong

      ; turnoff2 "BirdshitConfig", 0, 1
      turnoff2 "AvianPeterConfig", 0, 1
      turnoff2 "CharybdisConfig", 0, 1
      turnoff2 "DustyBassGrain", 0, 1
      turnoff2 "DelayForDustyBassGrain", 0, 1
      turnoff2 "VileArcConfig", 0, 1

      if giCurrentSong == 0 then
        prints "%n%n Playing Birdshit %n%n"
        ; event_i "i", "BirdshitConfig", 0, -1
      elseif giCurrentSong == 1 then
        prints "%n%n Playing AvianPeter %n%n"
        event_i "i", "AvianPeterConfig", 0, -1
      elseif giCurrentSong == 2 then
        prints "%n%n Playing Charybdis %n%n"
        event_i "i", "CharybdisConfig", 0, -1
      elseif giCurrentSong == 3 then
        prints "%n%n Playing VileArc %n%n"
        event_i "i", "VileArcConfig", 0, -1
      endif
    endin

    beatScoreline "config", 0, -1

  </CsInstruments>
  <CsScore>
    i "Metronome" 0 3600
  </CsScore>
</CsoundSynthesizer>
