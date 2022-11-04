instrumentRoute "YiSynth3", "Mixer"

gkModulatorOne init 1.734

instr YiSynth3
  ; An adaptation of code by Steven Yi
  iAmplitude = flexibleAmplitudeInput(p4)
  iPitch = flexiblePitchInput(p5)

  imodfreq = iPitch
  kfreq = iPitch * semitone(lfo(12, .1, 5))

  kmod = oscili:k(imodfreq * 2, imodfreq)
  kmod *= lfo(.5, .3) + .5
  aSignal = vco2(1, kfreq + kmod)
  aSignal += vco2(.5, kfreq * 2 + kmod * .5, 2, .25)

  aSignal = zdf_ladder(aSignal, cpsoct(9.5 + lfo(3, gkModulatorOne)), .5)

  aSignal *= madsr(.001, .001, 1, .01) * iAmplitude * .2

  outleta "OutL", aSignal
  outleta "OutR", aSignal
endin

$MIXER_CHANNEL(YiSynth3)
