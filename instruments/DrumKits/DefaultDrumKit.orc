$DRUM_SAMPLE(DefaultClap'DefaultDrumKitBus'localSamples/Drums/FL-Studio-Defaults_Clap_1.wav'0'1)
$DRUM_SAMPLE(DefaultClosedHat'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Closed-Hat_E703.wav'0'1)
$DRUM_SAMPLE(DefaultCowbell'DefaultDrumKitBus'localSamples/Drums/Qdrums_Cowbell_EA9012.wav'0'1)
$DRUM_SAMPLE(DefaultCrash'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Crash_E715.wav'0'1)
$DRUM_SAMPLE(DefaultKick'DefaultDrumKitBus'localsamples/CB_Kick.wav'0'1)
$DRUM_SAMPLE(DefaultOpenHat'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Open-Hat_E704.wav'1'1)
$DRUM_SAMPLE(DefaultRide'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Ride_E741.wav'0'1)
$DRUM_SAMPLE(DefaultSnare'DefaultDrumKitBus'localSamples/Drums/Mixed-Drums_Snare_EA8512.wav'0'1)
$DRUM_SAMPLE(DefaultTomHigh'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Tom_E7662.wav'0'1)
$DRUM_SAMPLE(DefaultTomLow'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Tom_E7661.wav'0'1)
$DRUM_SAMPLE(DefaultTomMid'DefaultDrumKitBus'localSamples/Drums/R8-Drums_Tom_E7662.wav'0'1)

$BUS(DefaultDrumKitBus'DefaultDrumKitDistortionInput)

$WARM_DISTORTION(DefaultDrumKitDistortion'DefaultDrumKitFreezerInput'DefaultDrumKitFreezerInput)
$FREEZER(DefaultDrumKitFreezer'DefaultDrumKitReverbInput'DefaultDrumKitReverbInput)
$FT_CONV_REVERB(DefaultDrumKitReverb'DefaultDrumKitPostFxBus'DefaultDrumKitPostFxBus'./localSamples/IMreverbs/Narrow Bumpy Space.wav)

$BUS(DefaultDrumKitPostFxBus'Mixer)

instr DefaultDrumKitTestPattern
  $PATTERN_LOOP(8)
    beatScoreline "DefaultKick", iBaseTime+0, 1, 100, 1
    beatScoreline "DefaultKick", iBaseTime+1, 1, 100, 1.1
    beatScoreline "DefaultKick", iBaseTime+2, 1, 100, 1
    beatScoreline "DefaultKick", iBaseTime+3, 1, 100, 1.1
    beatScoreline "DefaultKick", iBaseTime+4, 1, 100, .9
    beatScoreline "DefaultKick", iBaseTime+5, 1, 100, .95
    beatScoreline "DefaultKick", iBaseTime+6, 1, 100, 1
    beatScoreline "DefaultKick", iBaseTime+7, 1, 100, 1.1

    beatScoreline "DefaultCowbell", iBaseTime+0, 2, 70, 1
    beatScoreline "DefaultCowbell", iBaseTime+2, 2, 70, 1
    beatScoreline "DefaultCowbell", iBaseTime+4, 2, 70, 1
    beatScoreline "DefaultCowbell", iBaseTime+6, 2, 70, 1

    beatScoreline "DefaultSnare", iBaseTime+2, 1, 120, 1
    beatScoreline "DefaultSnare", iBaseTime+6, 1, 120, 1

    beatScoreline "DefaultDrumKitDistortion", iBaseTime+4, 4

    beatScoreline "DefaultDrumKitFreezer", iBaseTime+7, 1, .25


    if iMeasureIndex % 2 == 1 then
      beatScoreline "DefaultDrumKitFreezer", iBaseTime+3.5, 1.5, 1/6
      beatScoreline "DefaultDrumKitReverb", iBaseTime, 8
    else
      beatScoreline "DefaultCrash", iBaseTime+0, 1, 50
      beatScoreline "DefaultRide", iBaseTime+1.5, 1, 120
    endif

    if iMeasureIndex % 4 == 3 then
      beatScoreline "DefaultTomLow", iBaseTime+2, 1, 120
      beatScoreline "DefaultTomMid", iBaseTime+2.333, 1, 120
      beatScoreline "DefaultTomHigh", iBaseTime+2.666, 1, 120
    endif

    beatScoreline "DefaultClap", iBaseTime+6, 1, 120
    beatScoreline "DefaultClap", iBaseTime+6.5, 1, 120

    beatScoreline "DefaultClosedHat", iBaseTime+0, .25, 100
    beatScoreline "DefaultOpenHat", iBaseTime+.5, .5, 100
    beatScoreline "DefaultClosedHat", iBaseTime+1, .25, 100
    beatScoreline "DefaultClosedHat", iBaseTime+3.5, .25, 100
    beatScoreline "DefaultClosedHat", iBaseTime+5.5, .25, 100
  $END_PATTERN_LOOP
endin
