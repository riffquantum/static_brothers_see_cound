alwayson "YiSynth3MixerChannel"

gkYiSynth3EqBass init 1
gkYiSynth3EqMid init 1
gkYiSynth3EqHigh init 1
gkYiSynth3Fader init 1
gkYiSynth3Pan init 50
instrumentRoute "YiSynth3", "DefaultEffectChain"

gkModulatorOne init 1.734

instr YiSynth3
  ; An adaptation of code by Steven Yi
  iPitch = flexiblePitchInput(p4)
  iAmplitude = flexibleAmplitudeInput(p5)

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

instr YiSynth3MixerChannel
  aYiSynth3L inleta "InL"
  aYiSynth3R inleta "InR"

  aYiSynth3L, aYiSynth3R mixerChannel aYiSynth3L, aYiSynth3R, gkYiSynth3Fader, gkYiSynth3Pan, gkYiSynth3EqBass, gkYiSynth3EqMid, gkYiSynth3EqHigh

  outleta "OutL", aYiSynth3L
  outleta "OutR", aYiSynth3R
endin
