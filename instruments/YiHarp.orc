instrumentRoute "YiHarp", "Mixer"

instr YiHarp
  ; An adaptation of code by Steven Yi
  iPitch = flexiblePitchInput(p4)
  iAmplitude = flexibleAmplitudeInput(p5)

  aStringSignal = vco2(.5, iPitch, 2, .45)
  aStringSignal += vco2(.25, iPitch * 2, 2, linseg(.5, .1, .05, p3, .05))
  aStringSignal += vco2(.25, iPitch * 0.997934234, 12)
  aSignal = zdf_ladder(aStringSignal, cpsoct(linseg:a(13.4, .1, 10, 1, 5, p3, 4)), 0.5)

  aBodySignal1 = reson(aSignal, 800, 160) * 0.05
  aBodySignal2 = reson(aSignal, 2000, 400) * 0.05
  aBodySignal3 = reson(aSignal, 3000, 650) * 0.05

  aSignal += aBodySignal1 + aBodySignal2 + aBodySignal3

  aSignal = dcblock2(aSignal)
  aSignal *= madsr(.001, .001, 1, .01) * iAmplitude * .2

  outleta "OutL", aSignal
  outleta "OutR", aSignal
endin

$MIXER_CHANNEL(YiHarp)
