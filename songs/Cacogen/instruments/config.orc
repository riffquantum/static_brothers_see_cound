instr config
  ; giGlobalTuningSystem = 2
  ; giDivisionsInTuningSystem = 24
  ; midiMonitor
  ; gkDrumBitSampleRateModifier = poscil3( 1000, .1, triangleWave()) + 4800
  ; printk2 gkOscyBitSampleRate

  gkDrumVerbWetAmount init .5
  _ "DrumVerb", 0, stb(p3)
  _ "DrumBit", 0, stb(p3), 8, 4410, 1
  gkDrumBitWetAmount init 1/8
  gkDrumBitDryAmount init 7/8
  gkFalseHatFader init .75

  ; _ "DrumBit", 0, stb(p3), 8, 4410, 2
  ; gkDrumBitWetAmount init .5
  ; gkDrumBitDryAmount init .5

  gkCrashFader init .4
  gkCrash2Fader init .4
  gkCrashPan init 25
  gkCrash2Pan init 75
  gkPreClipMixerFader init 1.5
  gkCloserKickEqBass init 1.25
  ; gaCrashTuning init .8
  ; gaCrash2Tuning init 1
endin
