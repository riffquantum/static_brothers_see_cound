instrumentRoute "YiSynth1", "Mixer"

instr YiSynth1
  ; An adaptation of code by Steven Yi
  iPitch = flexiblePitchInput(p5)
  iAmplitude = flexibleAmplitudeInput(p4)

  imodfreq = iPitch * 3

  kmod = oscili:k(imodfreq * 3, imodfreq)
  kmod *= lfo(.5, .3) + .5
  aSignal = vco2(1, iPitch + kmod)
  aSignal += vco2(.5, iPitch * 2 + kmod * .5, 2, .25)

  aSignal = zdf_ladder(aSignal, cpsoct(10 + lfo(2, .1)), .5)

  aSignal *= madsr(.005, .001, 1, .01) * iAmplitude * .2

  outleta "OutL", aSignal
  outleta "OutR", aSignal
endin

$MIXER_CHANNEL(YiSynth1)
