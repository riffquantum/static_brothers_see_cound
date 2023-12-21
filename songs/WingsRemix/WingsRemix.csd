<CsoundSynthesizer>
  <CsOptions>
    -odac
    -d
    ; --midi-device=a
    --messagelevel=0
    ; -B512 -b256
    ; -B512 -b128 ;http://www.csounds.com/manualOLPC/UsingOptimizing.html
    ; -B4096 -b4096
    ; -t160 ; Drum and Bass Mode?
    -t110 ; Doomed Cumbia mode? This one. Much Eviller.
    ; -t95 ; For the fun loop
    ; -W -o "WingsRemix-v0.1.wav"
  </CsOptions>
  <CsInstruments>
    #include "./config/config.orc"
    #include "./config/midiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "./instruments/orchestra.orc"
    #include "./patterns/patterns.orc"

    ; Wings Remix
    ; Part one is the long long build up.
    ; We've got the layered up guitar tones
    ; Steady drum beat
    ; Samples

    ; at 2 minutes in the new drum beat is so intense.

    ; The transition will be good to use

    ; Selection for Drum Loop 1 is 2m 0.348s to 2m 7.866s

    ; John's high vocals around 5:00 should come in along, verbed out to hugeness in a
    ; gap in the other instrumentation

    ; Maybe some shofar samples?

    instr DrumTweak
      gkDrumGrainGrainSizeAdjustment = linseg(1,  p3*.25, 1, p3*.75, .1)
      gkDrumGrainGrainFrequencyAdjustment = linseg(1, p3*.25, 1.5, p3*.75, 20)
      gkDrumGrainTimeStretch = linseg(1, p3/2, .25, p3/2, 1.5)
    endin

    instr VoxScratch
      gkVoxGrainDelayGrainTimeStretch linseg 1, bts(4), 1, bts(4), .01
      gkVoxGrainDelayGrainGrainSizeAdjustment linseg 1, bts(2), 1, bts(4), .1, bts(16), 2
      gaVox1Pointer = (phasor(1/giVox1SampleLength) * giVox1SampleLength)
      _ "Vox1", 0, stb(p3), 20, 1
      gaVox1Pointer = linseg:a( 0, \
        bts(1/2), .35, \
        bts(1/8), .35, \
        bts(1/8), .5, \
        bts(1/8), .5, \
        bts(3/8), .3, \
        bts(1/8), .3, \
        bts(3/8), .15, \
        bts(1/8), .15, \
        bts(1/4), 0, \
        bts(2.5), 1.4 \
      )
    endin

    instr Vox2Scratch
      gkVoxGrainDelayGrainTimeStretch linseg 1, bts(2), 1, bts(4), .01
      gkVoxGrainDelayGrainGrainSizeAdjustment linseg 1, bts(2), 1, bts(4), .1, bts(16), 2
      gaVoxLongScreamPointer = (phasor(1/giVoxLongScreamSampleLength) * giVoxLongScreamSampleLength)
      _ "VoxLongScream", 0, stb(p3), 25, 1
    endin

    instr SmallBridge
      ; gkBPM init 95
      gkVoxGrainDelayDelayWetAmount = 1
       gkVoxGrainDelayDelayDryAmount = linseg(1, p3*.75, 1, p3*.25, 0, .1, 0)
        gkVoxGrainDelayDelayWetAmount = 1
        _ "KickHelix2", 0, stb(p3), 100, 3.04, 10, 10, .001, 10
      _ "Vox2Scratch", 0, stb(p3)+1
    endin

    instr Vox3Scratch
      gkVoxGrainDelayGrainTimeStretch linseg 1, bts(2), 1, bts(4), .01
      gkVoxGrainDelayGrainGrainSizeAdjustment linseg 1, bts(2), 1, bts(4), .1, bts(16), 2
      gaVoxHighBabblePointer = (phasor(1/giVoxHighBabbleSampleLength) * giVoxHighBabbleSampleLength)
      _ "VoxHighBabble", 0, stb(p3), 20, 1
    endin


    ; Make my own version of the think break with Tim's Drums and John's vocals
    instr NewLoop
      $PATTERN_LOOP(8)
      _ "Guitar1_B52", i0+.5, 8, 127, 1, 0
      _ "Guitar2_B52", i0+.5, 8, 127, 1, 32
      _ "KickHelix2", i0, 8, 40, 3.04, 10, 10, .001, 10

      _ "CloserKick", i0+.5, 1, 120, 1
      _ "CloserKick", i0+4.5, 1, 120, 1
      _ "CloserKick", i0+7, 1, 120, 1
      _ "CloserKick", i0+7.5, 1, 120, 1
      ; _ "CloserKick", i0+4, 1, 120, 1

      _ "DL2G_CHINA", i0, 8, 120, 4.04, 1, 1, .001, 1
      _ "DL2G_HH", i0, 8, 120, 4.04, 1, 1, .001, 1
      _ "DL2G_KICK", i0, 8, 120, 4.00, 1, 1, .01, 1, 10
      _ "DL2G_RIDE", i0, 8, 80, 4.04, 1, 10, .002, 1
      _ "DL2G_SNAREBOTTOM", i0, 8, 120, 4.04, 1, 1, (iMeasureIndex % 2 == 0 ? .01 : 1), 1
      _ "DL2G_SNARETOP", i0, 8, 120, 4.04, 1, 1, (iMeasureIndex % 2 == 0 ? .01 : 1), 1
      $END_PATTERN_LOOP
    endin

    instr Spacer
    endin

    instr FadeOut
      iNoInputLevel = i(gkNoInputFader)
      gkNoInputFader linseg iNoInputLevel, bts(16), iNoInputLevel, bts(24), 0
    endin

  </CsInstruments>

  <CsScore>
    i "config" 0 -1
    i "VoxPitch1" 0 -1 1.6666
    i "NoInputDelay"0 -1
    ; Actual Composition
    ; i "Section" + 1 "Spacer"
    i "Section" + 288 "Verse"
    i "Section" + 1 "Spacer"
    i "Section" + 64 "DownGrudgeLoop"
    i "Section" + 15 "SmallBridge"
    i "Section" + 1 "Spacer"
    i "Section" + 96 "ClubSide"
    i "Section" + 100 "FadeOut"

    ; Test loops
    ; i "Section" + 64 "DownGrudgeLoop"

    ; i "Section" + 48 "Verse" 1
    ; i "Section" ^+49 64 "DownGrudgeLoop"
    ; i "Section" + 32 "FunLoop"
    ; i "Section" + 14 "Vox2Scratch"
    ; i "Section" + 32 "TechnoLoop"
    ; i "Section" + 288 "ElectroLoop"
    ; i "Section" + 48 "Verse"
    ; i "Section" ^+50 64 "FunLoop"
    ; i "Section" + 14 "Vox2Scratch"
    ; i "Section" + 64 "DownGrudgeLoop"
    ; i "Section" + 64 "NewLoop"
    ; i "Section" + 15 "Vox2Scratch"
  </CsScore>
</CsoundSynthesizer>

