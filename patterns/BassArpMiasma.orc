$BASS_SYNTH(BassSynth'BassSynthDistInput')
$WARM_DISTORTION(BassSynthDist'BassSynthDelayInput'BassSynthDelayInput)
$DELAY(BassSynthDelay'Mixer'Mixer'5'0.05'0.85'1'0.0)
$ARPEGGIATOR(BassArp'BassSynth)

$DRUM_SAMPLE(Snare'Mixer'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)

$DRUM_SAMPLE(MuffledKick'Mixer'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)

$TWISTED_KICK(TwistedUpKick'Mixer'localSamples/CB_Kick.wav)
$EFFECT_CHAIN(TwistedUpKickFx'Mixer)

instr BassArpMiasma
  gkMuffledKickEqBass = 1.5
  gkSnareFader = 0.5
  gkTwistedUpKickFader = .005
  gkBassSynthFader = 0.25
  gkBassSynthBandwidth = 150 ;+ oscil(30, .05)
  gkBassSynthCenterFrequency = 150 ;+ oscil(250, .05)
  gkBassArpNoteDuration = beatsToSeconds(1/4) - .2
  gkBassArpNoteFrequency = 1/beatsToSeconds(1/4)
  giBassArpNotes ftgen 0, 0, 0, -2, 0.00, 0.01, 0.03, 0.05, 0.07, 0.085, 0.09, 0.11
  gkBassSynthDelayDryAmount = 0
  gkBassSynthDelayWetAmount = 0.75
  gkTwistedUpKickPan = 50 + oscil(50, .25)
  gaGlobalFxTapeWobbleAmount = 0.1 + oscil(0.08, .1) + oscil(0.01, 1)

  beatScoreline "GlobalFxTapeWobble", 0, -1

  $PATTERN_LOOP(6)
    beatScoreline "Distorted808Kick", iBaseTime, 2, 120, .5
    beatScoreline "MuffledKick", iBaseTime, 2, 120
    beatScoreline "MuffledKick", iBaseTime+0.5, 2, 120
    beatScoreline "MuffledKick", iBaseTime+0.5+1/6, 2, 120
    beatScoreline "MuffledKick", iBaseTime+0.5+2/6, 2, 120
    beatScoreline "MuffledKick", iBaseTime+3.5, 2, 120
    beatScoreline "Distorted808Kick", iBaseTime+3.5, 1, 120, .5
    beatScoreline "Distorted808Kick", iBaseTime+4, 1, 120, .5
    beatScoreline "Distorted808Kick", iBaseTime+4.5, 2, 40, 1.5
    beatScoreline "Distorted808Kick", iBaseTime+5.25, 1, 120, .5

    beatScoreline "Snare", iBaseTime+1, 2, 120, 1.0
    beatScoreline "Snare", iBaseTime+3, 2, 120, 1.0
    beatScoreline "Snare", iBaseTime+4.5, 2, 70, 1.0

    if iMeasureIndex % 5 == 4 then
      beatScoreline "BassArp", iBaseTime, 6, 20, 4.0
    endif

    if iMeasureIndex % 2 == 0 then
      beatScoreline "BassSynth", iBaseTime, 5.867574, 120, 2.040000
    else
      beatScoreline "BassSynth", iBaseTime, 5.957067, 120, 1.050000
    endif

    if iMeasureIndex % 3 == 2 then
      beatScoreline "BassArp", iBaseTime+0.25, 6, 20, 4.035
    endif

    if iMeasureIndex > 3 && iMeasureIndex % 4 == 0 then
      beatScoreline "BassSynthDist", iBaseTime, 12, -7, 0, 0, 0, 0, -0.02
    elseif iMeasureIndex > 3 && iMeasureIndex % 4 == 2 then
      beatScoreline "BassSynthDelay", iBaseTime, 12
    endif

    ; beatScoreline "TwistedUpKick", iBaseTime, 4, 100, 6.0;, 0, 3, 10, 3
    beatScoreline "TwistedUpKick", iBaseTime, 6, 100, 1.0, 0, .01, .10, 14
    beatScoreline "TwistedUpKick", iBaseTime, 6, 100, 5.0, 0, .01, .10, 14
    beatScoreline "TwistedUpKick", iBaseTime, 6, 120, 7.01, 1.250, .75
    beatScoreline "TwistedUpKick", iBaseTime, 6, 120, 7.05, 1.250, .75

    beatScoreline "AmenBreak", iBaseTime+0, 1, 7, 1, 6
    beatScoreline "AmenBreak", iBaseTime+1, 1, 7, 1, 6
    beatScoreline "AmenBreak", iBaseTime+2, 1, 7, 1, 6
    beatScoreline "AmenBreak", iBaseTime+3, 1, 7, 1, 3
    beatScoreline "AmenBreak", iBaseTime+4, 1, 7, 1, 3
    beatScoreline "AmenBreak", iBaseTime+5, 1, 7, 1, 3
  $END_PATTERN_LOOP
endin
