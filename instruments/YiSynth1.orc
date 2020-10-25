alwayson "YiSynth1MixerChannel"

gkYiSynth1EqBass init 1
gkYiSynth1EqMid init 1
gkYiSynth1EqHigh init 1
gkYiSynth1Fader init 1
gkYiSynth1Pan init 50
instrumentRoute "YiSynth1", "DefaultEffectChain"


instr YiSynth1
  ; An adaptation of code by Steven Yi
  iPitch = flexiblePitchInput(p4)
  iAmplitude = flexibleAmplitudeInput(p5)

  imodfreq = iPitch * 3

  kmod = oscili:k(imodfreq * 3, imodfreq)
  kmod *= lfo(.5, .3) + .5
  aSignal = vco2(1, iPitch + kmod)
  aSignal += vco2(.5, iPitch * 2 + kmod * .5, 2, .25)

  aSignal = zdf_ladder(aSignal, cpsoct(10 + lfo(2, .1)), .5)

  aSignal *= madsr(.001, .001, 1, .01) * iAmplitude * .2

  outleta "OutL", aSignal
  outleta "OutR", aSignal
endin

instr YiSynth1MixerChannel
  aYiSynth1L inleta "InL"
  aYiSynth1R inleta "InR"

  aYiSynth1L, aYiSynth1R mixerChannel aYiSynth1L, aYiSynth1R, gkYiSynth1Fader, gkYiSynth1Pan, gkYiSynth1EqBass, gkYiSynth1EqMid, gkYiSynth1EqHigh

  outleta "OutL", aYiSynth1L
  outleta "OutR", aYiSynth1R
endin
