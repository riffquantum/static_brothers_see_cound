; Mixer

alwayson "Mixer"
alwayson "MixerOutput"

stereoRoute "Mixer", "GlobalFx"

gkPreClipMixerFader init 1
gkPostClipMixerFader init 1

instr Mixer
  aOutL inleta "InL"
  aOutR inleta "InR"

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

$EFFECT_CHAIN(GlobalFx'MixerOutput)

instr MixerOutput
  aOutL inleta "InL"
  aOutR inleta "InR"

  iSafetyMaxAmplitude = 0dbfs * 3

  aOutL *= gkPreClipMixerFader
  aOutR *= gkPreClipMixerFader

  kHardLimitMinimum = iSafetyMaxAmplitude * -1.5
  kHardLimitMaximum = iSafetyMaxAmplitude * 1.5

  aOutL clip aOutL, 1, iSafetyMaxAmplitude
  aOutR clip aOutR, 1, iSafetyMaxAmplitude

  aOutR limit aOutR, kHardLimitMinimum, kHardLimitMaximum
  aOutL limit aOutL, kHardLimitMinimum, kHardLimitMaximum

  aOutL *= gkPostClipMixerFader
  aOutR *= gkPostClipMixerFader

  out aOutL, aOutR
endin
