instrumentRoute "YiBanjo", "DefaultEffectChain"

instr YiBanjo
  ; An adaptation of code by Steven Yi
  iPitch = flexiblePitchInput(p4)
  iAmplitude = flexibleAmplitudeInput(p5)

  ;; Adjusting index for amod2 depending on base frequency and sr/3
  imodindx = ((sr / 3) - iPitch) / iPitch
  imodindx *= .1

  imodf1 = iPitch * 8
  imodf2 = iPitch * 1

  ;; FM
  amod1 = oscili(imodf1 * expseg(2, 0.2, .001, p3, 0.001), imodf1)
  amod2 = oscili(imodf2 * imodindx, amod1 + imodf2)
  acar = oscili(0.25, iPitch + amod2)

  ;; AM
  acar2 = oscili(0.2, iPitch * 0.5)
  acar2 *= oscili(1, iPitch * 1) + 1

  ;; Mixing signals and applying Amp envelopes
  aSignal = acar + acar2

  aSignal *= expseg(iAmplitude, 0.45, .001, p3, 0.001)

  aSignal *= madsr(.001, .001, 1, .001)

  outleta "OutL", aSignal
  outleta "OutR", aSignal
endin

$MIXER_CHANNEL(YiBanjo)
