; String Pads
#define STRING_SYNTH_SETTINGS #
  giStringSynthNumberOfVoices = 9
#
$STRING_PAD(StringSynth'Mixer'$STRING_SYNTH_SETTINGS)

; Bass Synth
$BASS_SYNTH(BassSynth'BassSynthDistInput')
$WARM_DISTORTION(BassSynthDist'BassSynthChorusInput'BassSynthChorusInput)
$CHORUS(BassSynthChorus'Mixer'Mixer)

;Snare
$DRUM_SAMPLE(Snare'DelayForSnareInput'localSamples/Drums/Funk-Kit_Snare_EA8141.wav'1'1)
$DELAY(DelayForSnare'TwistedUpKickReverbInput'TwistedUpKickReverbInput'5'beatsToSeconds(1.75)'0.25'.25'0.5)

$DRUM_SAMPLE(MuffledKick'Mixer'localSamples/Drums/Beatbox-Drums_Kick_EA7538.wav'1'1)

$TWISTED_KICK(TwistedUpKick'TwistedUpKickDelayInput'localSamples/CB_Kick.wav)
$DELAY(TwistedUpKickDelay'TwistedUpKickReverbInput'TwistedUpKickReverbInput'5'0.005'0.999'0.1'0)

$DARKSIDE_50_REVERB(TwistedUpKickReverb'Mixer'Mixer)

;VibeLineGrain
#define VIBE_LINE_GRAIN_SETTINGS #
  kTimeStretch = .3 + (.1 - poscil(10, .25) + poscil(.2, .3))
  kGrainSizeAdjustment = (10 + poscil(2, .25)) * (1 + poscil(3, .05))
  kGrainFrequencyAdjustment = 2 + (.1 - poscil(10, .25) + poscil(.2, .3))
  kPitchAdjustment = 1 ;* (1 + oscil(.025, 2))
  kGrainOverlapPercentageAdjustment = 2
#
$SYNCLOOP_SAMPLER(VibeLineGrain'Mixer'localsamples/ajq - vibe out.wav'$VIBE_LINE_GRAIN_SETTINGS'5)
