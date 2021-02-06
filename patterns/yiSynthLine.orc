$TWISTED_UP_HAT(SnickerSnack'Mixer'localSamples/Drums/Beatbox-Drums_Closed-Hat_EA7544.wav'$TWISTED_UP_HAT_GRAIN_SETTINGS)

instr YiSynthLine
  beatScoreline("DefaultDrumKitTestPattern", 0, secondsToBeats(p3))

  gkDefaultDrumKitPostFxBusFader linseg 0, beatsToSeconds(16), .8, .01, .8
  gkSnickerSnackFader linseg 0, beatsToSeconds(16), .8, .01, .8

  $PATTERN_LOOP(8')
    beatScoreline("SnickerSnack", iBaseTime, 8, 60, 3.0)
    beatScoreline "Distorted808Kick", iBaseTime, 2, 127, .5
    beatScoreline "Distorted808Kick", iBaseTime+2, 2, 127, 1.2

    beatScoreline "YiSynth3", iBaseTime+0, 1.311967, 89, 3.100000
    beatScoreline "YiSynth3", iBaseTime+0, 1.451291, 107, 4.060000
    beatScoreline "YiSynth3", iBaseTime+0, 1.681563, 91, 2.030000
    beatScoreline "YiSynth3", iBaseTime+0, 1.760900, 78, 2.100000
    beatScoreline "YiSynth3", iBaseTime+1.982464, 2.238858, 111, 2.060000
    beatScoreline "YiSynth3", iBaseTime+3.909294, 3.951382, 89, 3.080000
  $END_PATTERN_LOOP
endin
