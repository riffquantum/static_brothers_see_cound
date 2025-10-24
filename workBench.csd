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
    -t95    ;--midioutfile=midiout.mid
    ; -t106.697
    ; -W -o workBench.wav"
    ; -W -o "mankind.wav"
    ; -iadc
    ; --realtime
    ;-F midiout.mid
    ; -rtmidi=virtual
  </CsOptions>

  <CsInstruments>

    ; sample the drum loop around 28:00 in https://www.youtube.com/watch?v=8VE_dP90V84
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

    #include "instruments/SimpleOscillator.orc"

    #include "patterns/BitcrusherTests.orc"


    $BREAK_SAMPLE_N(Late'Mixer'localSamples/latelyItSeemsLoop.wav'32)
    ; gkLate2Pan init 100
    $BREAK_SAMPLE_N(Late3'Mixer'localSamples/latelyItSeemsLoop.wav'32)
    gkLate3Pan init 0

    $BREAK_SAMPLE_N(Late2'Mixer'localSamples/latelyVox.wav'12)


    $BREAK_SAMPLE_N(LatelyDrums1'DrumBus'localSamples/latelyDrumLoop2.wav'8)
    $BREAK_SAMPLE_N(LatelyDrums2'DrumBus'localSamples/latelyDrumLoopOrganic8.wav'8)
    $BREAK_SAMPLE_N(LatelyDrums3'DrumBus'localSamples/latelyDrumLoop1.wav'4)
    $BREAK_SAMPLE_N(LatelyDrums4'DrumBus'localSamples/latelyDrumLoopFill.wav'4)
    $BUS(DrumBus'DrumDelayInput)
    $DELAY(DrumDelay'Mixer'Mixer'2'bts(.25)'.8'1'0)
    giDrumDelayRelease init bts(3)

    #define latelyG #
      kTimeStretch = 1 ;.5 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = 1 ;0 * (poscil(.2, .25+p7))
      kGrainFrequencyAdjustment = 1 ;* (1 + poscil(.7, .25) + poscil(.2, .3))
      kPitchAdjustment = 1 ;.849 ; linseg(.89, p3, .75)
      kPitchAdjustment = .89
      kGrainOverlapPercentageAdjustment = 1
    #

  $SYNCLOOP_SAMPLER2(LateG'Mixer'localSamples/latelyItSeemsLoop.wav'$latelyG'32)

  #define latelyGVox #
      kTimeStretch = .5 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
      kGrainSizeAdjustment = 1 ;0 * (poscil(.2, .25+p7))
      kGrainFrequencyAdjustment = 2 ;* (.1 - poscil(10, .25) + poscil(.2, .3))
      kPitchAdjustment = .89
      kGrainOverlapPercentageAdjustment = 1
    #

  $SYNCLOOP_SAMPLER2(LateGVox'Mixer'localSamples/latelyVox.wav'$latelyGVox'12)


    instr config
      ; giGlobalTuningSystem = 2
      ; giDivisionsInTuningSystem = 24
      ; midiMonitor
    endin

    instr GentleLoop
      $PATTERN_LOOP(32)
        _ "Late", i0, 24, 100, 1, 0
        _ "Late", i0+24, 4, 100, 1, 8
        _ "Late", i0+28, 4, 100, 1, 8
      $END_PATTERN_LOOP
    endin

    instr AccentLoop
      $PATTERN_LOOP(32)
        _ "Late2", i0, 2, 100, 1, 0
        _ "Late2", i0+8, 2, 100, .5, 0
      $END_PATTERN_LOOP
    endin

    instr DrumLoop
      $PATTERN_LOOP(16)
        if iMeasureCount % 4 == 1 then
          _ "LatelyDrums2", i0, 16, 100, 1
          _ "DrumDelay", i0+14.5, 1
        elseif iMeasureCount % 4 == 2 then
          _ "LatelyDrums3", i0, 4, 100, 1
          _ "LatelyDrums2", i0+4, 12, 100, 1
        elseif iMeasureCount % 4 == 3 then
          _ "LatelyDrums4", i0, 4, 100, 1
          _ "LatelyDrums2", i0+4, 4, 100, 1
          _ "LatelyDrums4", i0+8, 4, 100, 1
          _ "LatelyDrums2", i0+12, 4, 100, 1
        elseif iMeasureCount % 4 == 0 then
          _ "LatelyDrums2", i0, 16, 100, 1
        endif
      $END_PATTERN_LOOP
    endin

    instr Verse
      _ "GentleLoop", 0, stb(p3)-32
      _ "DrumLoop", 32, stb(p3)-32
      _ "AccentLoop", 48, stb(p3)-48
    endin


    instr WorkingPattern
      $PATTERN_LOOP(16)
        _ "LateG", i0, 4, 100, 4.00
        _ "LateG", i0+4, 4, 100, 4.01
        _ "LateG", i0+8, 4, 100, 4.02
        _ "LateG", i0+12, 4, 100, 4.03
        ; _ "LateG", i0, 8, 100, 4.0
        ; _ "Late", i0, 4, 100, 1
        ; _ "LateG", i0+4, 4, 100, (iMeasureIndex%2==0 ? 3.09 : 3.11)
        ; _ "Late", i0+8, 4, 100, 1
        ; _ "LateG", i0+12, 4, 100, (iMeasureIndex%2==0 ? 4.0 : 4.05)
        ; _ "Late", i0, 1, 100, 1, 0
        ; _ "Late", i0+1, 2.5, 100, -1, 21
        ; _ "Late", i0+3.5, 4.5, 100, 1, 15.5
        ; _ "Late", i0+2.5, 1.5, 100, 1, 19
        ; _ "Late", i0+5, 3, 100, 1, 15
        ; _ "Late", i0, 4, 100, 4/3, 4
        ; _ "Late", i0, 5, 100, 1, 15.5
        ; _ "Late2", i0, 2, 120, 1
        ; _ "Late2", i0+2, 2, 120, 1, 8
        ; _ "Late2", i0+4, 2, 120, 1, 2
        ; _ "Late2", i0+6, 2, 120, 1, 10
        ; _ "Late", i0+4, 4, 100, 1, 24
      $END_PATTERN_LOOP
      $PATTERN_LOOP(32)
        ; _ "Late", i0, 24, 100, 1, 0
        ; _ "Late", i0+24, 4, 100, 1, 8
        ; _ "Late", i0+28, 4, 100, 1, 8
        ; _ "Late", i0, 8, 100, 1, 0
        ; _ "Late", i0+8, 3.5, 100, 1, 4
        ; _ "Late", i0+11.5, 12.5, 100, 1, 15.5
        ; _ "Late", i0, 8, 100, 1, 24
        ; _ "Late", i0+8, 8, 100, 1, 16.05
      $END_PATTERN_LOOP
    endin


    /*
      I want to understand filtering better.
      Docs:
        List of standard filter opcodes: https://csound.com/docs/manual/SigmodStandard.html
        List of Specialized Filter Opcodes: https://csound.com/docs/manual/SigmodSpeciali.html

      Types:
        Low Pass - attenuates above the cutoff but not below

        High Pass - attenuates below the cutoff but not above

        Parametric EQ

        Band Pass - A low pass and high pass filter around the same cutoff
        Band Stop - The opposite of the above. An aggressive one is called a Notch Filter.

        Butterworth Filter - A filter design that tries to make the bandpass response as flat
        as possible.

        moogladder

        equalizer

        allpass

        hilbert transformer

      Terms:
        Cutoff Frequency: The cutoff frequency is usually defined as the point at which the
        gain falls off −3 dB from the midband response or, if the response is uneven, the
        response at a defined frequency. That means a filter will start attenuating frequencys
        BEFORE the cutoff. The cutoff is the point where that -3db threshold is crossed.

        Resonance, Q: A Boost at the edge of the cutoff frequency. It really becomes noticeable during a sweep
        since the cutoff is emphasized. Very high resonance can produce a whistling feedback.

        Slope - measured in decibels per octave (db/oct). It's the slope of attenuation after the cutoff freq.

        First, Second, Third Order - Seems like this refers to the slope. Higher order is steeper slope.
    */

    /*
      LOUDNESS
      RMS
      Decibel
      Lufs
      0dbfs
      Bit Depth

    */
  </CsInstruments>

  <CsScore>
    ; i "Metronome" 0 3600
    ; i "DrumConfig" 0 3600
    ; i "DrumBeat" 0 360
    i "config" 0 -1

    i "Section" + 1 ""
    ; i "Section" + 400 "WorkingPattern"
    i "Section" + 400 "Verse"
    ; i "BitTests" + 400
  </CsScore>
</CsoundSynthesizer>
