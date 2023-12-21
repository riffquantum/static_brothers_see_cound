<CsoundSynthesizer>
  <CsOptions>
    ; This file is meant to serve as place to quickly sketch out ideas or to work on
    ; instruments and opcodes outside of the context of any particular song. Nothing
    ; in this file should be considered permanent or stable.
    -odac
    -d
    ; --midi-device=a
    --messagelevel=0
    ; -B512 -b256
    ; -B512 -b128 ; http://www.csounds.com/manualOLPC/UsingOptimizing.html
    ; -B4096 -b4096
    -t160
    ;--midioutfile=midiout.mid
    ; -W -o workBench.wav"
    -W -o "mankind.wav"
    ; -iadc
    ; --realtime
    ;-F midiout.mid
    ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    ; Config Inclusions
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMappingWithSPD30.orc"

    ; Opcode Inclusions
    #include "opcodes/opcode-manifest.orc"

    ; Orchestra Inclusions
    #include "instruments/orchestra-manifest.orc" ; A few items to clean up in here.
    #include "instruments/NewInstrument.orc"
    #include "instruments/NewEffect.orc"
    #include "instruments/DrumKits/DefaultDrumKit.orc"

    $OCARINA(Ocarina1'Mixer')

    instr config
      giGlobalTuningSystem = 7
      giDivisionsInTuningSystem = 13
      midiMonitor
    endin

    instr setTuning
      if p4 == 0 then
        prints "Equal Temperment"
        giGlobalTuningSystem = 1
      else
        prints "Pythagorean"
        giGlobalTuningSystem = 3
      endif
    endin

    instr WorkingPattern
    endin

    instr Verse
      gkSixerPan = linseg(50, bts(55), 50, 0.1, 0)
      gkSixerLeftPan = linseg(50, bts(55), 50, 0.1, 100)
      $PATTERN_LOOP(55)
        _ "Sixer", i0, 55, 100, 1

        if iMeasureCount > 1 then
          _ "SixerLeft", i0, 55, 100, 1
        else
          _ "Sixer", i0, 55, 100, 1
        endif

        _ "SixPattern", i0, 42
        _ "ThirteenPattern", i0+42, 13
      $END_PATTERN_LOOP
    endin

    instr Verse2
      gkSixerPan = 0
      gkSixerLeftPan = 100
      $PATTERN_LOOP(55)
        _ "Sixer", i0, 55, 100, 1
        _ "SixerLeft", i0, 55, 100, 1

        ; if iMeasureCount == 1 then
          _ "VerseLead", i0, 55, 100, 1
        ; endif

        _ "SixPattern", i0, 42
        _ "ThirteenPattern", i0+42, 13
      $END_PATTERN_LOOP
    endin

    $BREAK_SAMPLE(VerseLead'Mixer'localSamples/Mankind/verseLead.wav'55)
    $BREAK_SAMPLE(Sixer'Mixer'localSamples/Mankind/sixer.wav'55)
    $BREAK_SAMPLE(SixerLeft'Mixer'localSamples/Mankind/sixerLeft.wav'55)
    $BREAK_SAMPLE(ChorusRiff'Mixer'localSamples/Mankind/chorus.wav'32)
    $BREAK_SAMPLE(RossRiff'Mixer'localSamples/Mankind/rossRiff.wav'32)
    $BREAK_SAMPLE(SegueRiff'Mixer'localSamples/Mankind/segue.wav'61)
    $DRUM_SAMPLE(Feedback'Mixer'localSamples/Mankind/feedback.wav'1)
    $DRUM_SAMPLE(BigChord'Mixer'localSamples/Mankind/bigChord.wav'0)
    $DRUM_SAMPLE(OutroRiff'Mixer'localSamples/Mankind/outro.wav'0)


    instr SixPattern
      $PATTERN_LOOP(6)
        _ "DefaultKick", i0, 1, 100, 1
        _ "DefaultKick", i0+1, 1, 100, 1
        _ "DefaultKick", i0+2, 1, 100, 1
        _ "DefaultKick", i0+3, 1, 100, 1
        _ "DefaultKick", i0+4, 1, 100, 1
        _ "DefaultKick", i0+4.5, 1, 100, 1
        _ "DefaultKick", i0+5, 1, 100, 1

        _ "DefaultCrash", i0, 1, 100, 1
        _ "DefaultCrash", i0+3, 1, 100, 1
        _ "DefaultCrash", i0+5, 1, 100, 1

        _ "DefaultSnare", i0+0, 1, 100, 1
        _ "DefaultSnare", i0+2, 1, 100, 1
        ; _ "DefaultSnare", i0+2, 1, 100, 1
        _ "DefaultSnare", i0+5, 1, 100, 1

        ; __ "DefaultRide", i0+5, 1, 100, 1
      $END_PATTERN_LOOP
    endin

    instr ThirteenPattern
      $PATTERN_LOOP(13)
        _ "DefaultKick", i0, 1, 100, 1
        _ "DefaultKick", i0+1, 1, 100, 1
        _ "DefaultKick", i0+2, 1, 100, 1
        _ "DefaultKick", i0+3, 1, 100, 1
        _ "DefaultKick", i0+4, 1, 100, 1
        _ "DefaultKick", i0+4.5, 1, 100, 1
        _ "DefaultKick", i0+5, 1, 100, 1

        _ "DefaultCrash", i0, 1, 100, 1
        _ "DefaultCrash", i0+3, 1, 100, 1
        _ "DefaultCrash", i0+5, 1, 100, 1

        _ "DefaultSnare", i0+0, 1, 100, 1
        _ "DefaultSnare", i0+2, 1, 100, 1
        ; _ "DefaultSnare", i0+2, 1, 100, 1
        _ "DefaultSnare", i0+5, 1, 100, 1

        _ "DefaultSnare", i0+6, 1, 100, 1
        _ "DefaultSnare", i0+7, 1, 100, 1
        _ "DefaultSnare", i0+8, 1, 100, 1
        _ "DefaultSnare", i0+9, 1, 100, 1
        _ "DefaultSnare", i0+10, 1, 100, 1
        _ "DefaultSnare", i0+11, 1, 100, 1
        _ "DefaultSnare", i0+12, 1, 100, 1

        ; __ "DefaultRide", i0+5, 1, 100, 1
      $END_PATTERN_LOOP
    endin

    instr ChorusDrums
      $PATTERN_LOOP(12)
        _ "DefaultKick", i0, 1, 100, 1
        _ "DefaultKick", i0+7, 1, 100, 1
        _ "DefaultKick", i0+8, 1, 100, 1
        _ "DefaultRide", i0, 1, 100, 1
        _ "DefaultRide", i0+4, 1, 100, 1
        _ "DefaultRide", i0+8, 1, 100, 1
      $END_PATTERN_LOOP
    endin

    instr Chorus
      $PATTERN_LOOP(32)
        _ "ChorusRiff", i0, 32, 60, 1
        _ "ChorusDrums", i0, 32

        ; _ "DefaultKick", i0, 1, 100, 1
        ; _ "DefaultKick", i0+7, 1, 100, 1
        ; _ "DefaultKick", i0+8, 1, 100, 1
        ; _ "DefaultKick", i0+12, 1, 100, 1
        ; _ "DefaultKick", i0+15, 1, 100, 1
        ; _ "DefaultKick", i0+16, 1, 100, 1
        ; _ "DefaultKick", i0+20, 1, 100, 1
        ; _ "DefaultKick", i0+23, 1, 100, 1
        ; _ "DefaultKick", i0+24, 1, 100, 1
        ; _ "DefaultKick", i0+31, 1, 100, 1

        ; _ "DefaultRide", i0, 1, 100, 1
        ; _ "DefaultRide", i0+4, 1, 100, 1
        ; _ "DefaultRide", i0+8, 1, 100, 1
        ; _ "DefaultRide", i0+12, 1, 100, 1
        ; _ "DefaultRide", i0+16, 1, 100, 1
        ; _ "DefaultRide", i0+20, 1, 100, 1
        ; _ "DefaultRide", i0+24, 1, 100, 1
        ; _ "DefaultRide", i0+28, 1, 100, 1
      $END_PATTERN_LOOP
    endin

    instr CountIn
      $PATTERN_LOOP(8)
        _ "DefaultRide", i0+0, 1, 100, 1
        _ "DefaultRide", i0+2, 1, 100, 1
        _ "DefaultRide", i0+4, 1, 100, 1
        _ "DefaultRide", i0+6, 1, 100, 1
      $END_PATTERN_LOOP
    endin

    instr Segue
      gkSegueRiffFader = .7
      $PATTERN_LOOP(64)
        _ "SegueRiff", i0, 60, 100, 1
        _ "ChorusDrums", i0, 32

        _ "Feedback", i0+48, 16, 100, 1
        _ "DefaultCrash", i0+48, 1, 100, 1
        _ "DefaultSnare", i0+48, 1, 100, 1
        _ "DefaultCrash", i0+50, 1, 100, 1
        _ "DefaultSnare", i0+50, 1, 100, 1
        _ "DefaultCrash", i0+52, 1, 100, 1
        _ "DefaultSnare", i0+52, 1, 100, 1
        _ "DefaultCrash", i0+54, 1, 100, 1
        _ "DefaultSnare", i0+54, 1, 100, 1
        _ "DefaultCrash", i0+56, 1, 100, 1
        _ "DefaultSnare", i0+56, 1, 100, 1
        _ "DefaultCrash", i0+58, 1, 100, 1
        _ "DefaultSnare", i0+58, 1, 100, 1
        _ "DefaultCrash", i0+60, 1, 100, 1
        _ "DefaultSnare", i0+60, 1, 100, 1
        _ "DefaultCrash", i0+62, 1, 100, 1
        _ "DefaultSnare", i0+62, 1, 100, 1
      $END_PATTERN_LOOP
    endin
    instr RossDrums
      $PATTERN_LOOP(8)
        _ "DefaultCrash", i0, 1, 100, 1
        _ "DefaultCrash", i0+3, 1, 100, 1
        _ "DefaultCrash", i0+4, 1, 100, 1
        _ "DefaultKick", i0, 1, 100, 1
        _ "DefaultKick", i0+3, 1, 100, 1
        _ "DefaultKick", i0+4, 1, 100, 1
        _ "DefaultSnare", i0+4, 1, 100, 1
        ; _ "DefaultSnare", i0+6, 1, 100, 1
      $END_PATTERN_LOOP
    endin

    instr RossPart
      gkRossRiffFader = 2
      $PATTERN_LOOP(32)
        _ "RossDrums", i0, 24
        _ "DefaultKick", i0+24, 1, 100, 1
        _ "DefaultKick", i0+26, 1, 100, 1
        _ "DefaultKick", i0+28, 1, 100, 1
        _ "DefaultKick", i0+30, 1, 100, 1
        _ "DefaultCrash", i0+24, 1, 100, 1
        _ "DefaultCrash", i0+26, 1, 100, 1
        _ "DefaultCrash", i0+28, 1, 100, 1
        _ "DefaultCrash", i0+30, 1, 100, 1

        _ "RossRiff", i0, 32, 100, 1
      $END_PATTERN_LOOP
    endin

    ; TODO
    ; RossPart needs Jason's drums and Ross' update
    ; Fix Outro
    ; Come up with a better lead for second sixer. Maybe mandolin?
    ; Try Blast Beat Chrous
    ; Try a couple intros - a cappella? short guitar lick that foreshadows the last riff?

    instr Outro
      _ "BigChord", 0, 60, 100, 1
      _ "OutroRiff", 0, 60, 100, 1
    endin
  </CsInstruments>

  <CsScore>
    ; i "Metronome" 0 3600
    ; i "config" 0 3600
    ; i "WorkingPattern" 1 3600
    i "Section" 2 8 "CountIn"
    i "Section" + 110 "Verse"
    i "Section" + 64 "Chorus"
    i "Section" + 64 "Segue"
    i "Section" + 110 "Verse2"
    i "Section" + 64 "RossPart"
    i "Section" + 60 "Outro"
  </CsScore>
</CsoundSynthesizer>
