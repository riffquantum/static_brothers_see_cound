instr DrumLoop1
  _ "TwistedKickGrainDelay", 0, stb(p3)

  gaTwistedKickGrainDelayDelayTime = bts(2)
  gkTwistedKickGrainDelayTimeStretch = 0.251 + poscil:a(.25, .2)
  gkTwistedKickGrainDelayGrainSizeAdjustment = 5
  gkTwistedKickGrainDelayGrainFrequencyAdjustment = 1 + poscil:a(.25, .1)
  gkTwistedKickGrainDelayPitch = 1 + poscil:a(.25, .2)
  gkTwistedKickGrainDelayGrainOverlapPercentageAdjustment = 1 + poscil:a(.25, .5)


  $PATTERN_LOOP(4)
    _ "Distorted808Kick", i0+3.6666666, .333334, 120, .5
    _ "Distorted808Kick", i0+0, 1, 120, .5
    _ "Distorted808Kick", i0+1.66666, 1, 120, .5
    _ "Distorted808Kick", i0+2, 1, 120, .5
    _ "Snare", i0+1, 1, 60, .5
    _ "Snare", i0+3, 1, 60, .5
    ; _ "TwistedUpKickExample", i0, 4, 40, 3.06, .3, 2, .8
    ; _ "Drums", i0, 4, 30, 3.095, 1, .25, 1.5, .7, 1
    ; _ "Drums", i0, 4, 30, 3.095, 1, .1, 1.5, .7, .9
    ; _ "Drums", i0+2, 2, 30, 3.095, 1, .1, 1.5, .7, .9

  $END_PATTERN_LOOP
endin
$TWISTED_KICK(TwistedUpKickExample'TwistedKickGrainDelayInput'localSamples/CB_Kick.wav)
$DELAY_TO_GRAIN(TwistedKickGrainDelay'Mixer'Mixer)



#define DRUMS_SETTINGS #
  ; kTimeStretch = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1), 1.8, beatsToSeconds(1), .8)
  ; kTimeStretch = .35 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  ; kTimeStretch = .25 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kTimeStretch = .5 + poscil(1, .25) + poscil(.2, .3) * linseg(0, beatsToSeconds(1), 0, beatsToSeconds(1.5), 1)
  kGrainSizeAdjustment = 1
  kGrainFrequencyAdjustment = linseg(1, beatsToSeconds(1), 1, beatsToSeconds(1.5), 1.93)
  kPitchAdjustment = 1
  kGrainOverlapPercentageAdjustment = 1 ;linseg(1, beatsToSeconds(4), .5)
#
$SYNCLOOP_SAMPLER(Drums'DrumBus'localSamples/jbShoutBreakClean.wav'$DRUMS_SETTINGS'0'0)
