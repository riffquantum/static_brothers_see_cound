<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    ; -W -o "newLoop.wav"
    --midi-device=a
    --messagelevel=0
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

    ; Midi Assignments
    gSMidiChannelAssignments[] fillarray "", \
      "MidiRouter"

    #include "config/assignMidiChannels.orc"
    ; End Midi Assignments

    #include "config/defaultMidiRouterMappingWithSPD30.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "MidiControlInputs/MidiControlInputs.orc"
    #include "instruments/MidiRouter.orc"

    #include "instruments/DrumKits/BirdshitDrumKit.orc"
    #include "instruments/DrumKits/AvianPeterDrumKit.orc"
    #include "instruments/DrumKits/CharybdisDrumKit.orc"
    #include "instruments/DrumKits/VileArcDrumKit.orc"
    #include "instruments/DrumKits/QuietPracticeDrumKit.orc"

    ; #include "instruments/DrumKits/DefaultDrumKit.orc"
    ; #include "config/defaultMidiRouterEvents.orc"

    giCurrentSong init 5
    if giCurrentSong == 5 then
      beatScoreline "BirdshitInit", 0, -1
    elseif giCurrentSong == 1 then
      beatScoreline "AvianPeterInit", 0, -1
    elseif giCurrentSong == 2 then
      beatScoreline "CharybdisInit", 0, -1
    elseif giCurrentSong == 3 then
      beatScoreline "VileArcInit", 0, -1
    endif

    instr SwitchSong
      event_i "i", "CharybdisInit", 0, 0.01
      event_i "i", "BirdshitInit", 0, 0.01
      event_i "i", "AvianPeterInit", 0, 0.01
      event_i "i", "VileArcInit", 0, 0.01
      event_i "i", "QuietPracticeInit", 0, 0.01

      if p6 == giBirdshitSongIndex then
        event_i "i", "BirdshitInit", 0, 0.01, 0, 0, 1
      elseif p6 == giAvianPeterSongIndex then
        event_i "i", "AvianPeterInit", 0, 0.01, 0, 0, 1
      elseif p6 == giCharybdisSongIndex then
        event_i "i", "CharybdisInit", 0, 0.01, 0, 0, 1
      elseif p6 == giVileArcSongIndex then
        event_i "i", "VileArcInit", 0, 0.01, 0, 0, 1
      elseif p6 == giQuietPracticeSongIndex then
        event_i "i", "QuietPracticeInit", 0, 0.01, 0, 0, 1
      endif
    endin

    instr config
      ; midiMonitor
      ; gkMetronomeFader = 0.65

      gkBirdshitKickBusEqBass = 1.5
      ; gkBirdshitFxMainReverbWetAmount = 0.025
    endin

    instr ToggleDrumDelay
        iDelayForDrumKitIsOn active "DelayForDrumKit"
        if iDelayForDrumKitIsOn > 0 then
            turnoff2  nstrnum("DelayForDrumKit"), 8, 1
            printsBlock "DelayForDrumKit is Off"
        else
            event_i "i", "DelayForDrumKit", 0, -1
            printsBlock "DelayForDrumKit is On"
        endif
    endin

    ; Define Control Events
    giEventsForNoteInstruments[0][giPadC13Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 1/sr, 0, 0, 4
    giEventsForNoteInstruments[0][giPadC14Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 1/sr, 0, 0, 1
    giEventsForNoteInstruments[0][giPadC15Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 1/sr, 0, 0, 2
    giEventsForNoteInstruments[0][giPadC16Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 1/sr, 0, 0, 3
    giEventsForNoteInstruments[0][giPadC12Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("SwitchSong"), 0, 1/sr, 0, 0, 5
    giEventsForNoteInstruments[0][giPadC1Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("MetronomeSwitch"), 0, 1/sr
    giEventsForNoteInstruments[0][giPadC4Note][0] ftgen 0, 0, 0, -2, 0, nstrnum("ToggleDrumDelay"), 0, 1/sr

    beatScoreline "config", 0, -1

  </CsInstruments>
  <CsScore>
    i "Metronome" 0 3600
  </CsScore>
</CsoundSynthesizer>
