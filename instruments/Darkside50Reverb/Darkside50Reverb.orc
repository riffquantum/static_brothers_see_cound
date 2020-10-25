bypassRoute "Darkside50Reverb", "DefaultEffectChain", "DefaultEffectChain"

alwayson "Darkside50ReverbInput"
alwayson "Darkside50ReverbMixerChannel"
alwayson "Darkside50Reverb"

gkDarkside50ReverbEqBass init 1
gkDarkside50ReverbEqMid init 1
gkDarkside50ReverbEqHigh init 1
gkDarkside50ReverbFader init 1
gkDarkside50ReverbPan init 50

gkDarkside50ReverbDryAmount init 0
gkDarkside50ReverbWetAmount init 1

gkDarkside50ReverbRate init 20
gkDarkside50ReverbDepth init 1

instr Darkside50ReverbInput
  aDarkside50ReverbInL inleta "InL"
  aDarkside50ReverbInR inleta "InR"

  aDarkside50ReverbOutWetL, aDarkside50ReverbOutWetR, aDarkside50ReverbOutDryL, aDarkside50ReverbOutDryR bypassSwitch aDarkside50ReverbInL, aDarkside50ReverbInR, gkDarkside50ReverbDryAmount, gkDarkside50ReverbWetAmount, "Darkside50Reverb"

  outleta "OutWetL", aDarkside50ReverbOutWetL
  outleta "OutWetR", aDarkside50ReverbOutWetR

  outleta "OutDryL", aDarkside50ReverbOutDryL
  outleta "OutDryR", aDarkside50ReverbOutDryR
endin


instr Darkside50Reverb
  aDarkside50ReverbInL inleta "InL"
  aDarkside50ReverbInR inleta "InR"

  aDarkside50ReverbOutL = aDarkside50ReverbInL
  aDarkside50ReverbOutR = aDarkside50ReverbInR

  outleta "OutL", aDarkside50ReverbOutL
  outleta "OutR", aDarkside50ReverbOutR
endin

instr Darkside50ReverbBassKnob
  gkDarkside50ReverbEqBass linseg p4, p3, p5
endin

instr Darkside50ReverbMidKnob
  gkDarkside50ReverbEqMid linseg p4, p3, p5
endin

instr Darkside50ReverbHighKnob
  gkDarkside50ReverbEqHigh linseg p4, p3, p5
endin

instr Darkside50ReverbFader
  gkDarkside50ReverbFader linseg p4, p3, p5
endin

instr Darkside50ReverbPan
  gkDarkside50ReverbPan linseg p4, p3, p5
endin

instr Darkside50ReverbMixerChannel
  aDarkside50ReverbL inleta "InL"
  aDarkside50ReverbR inleta "InR"

  aDarkside50ReverbL, aDarkside50ReverbR mixerChannel aDarkside50ReverbL, aDarkside50ReverbR, gkDarkside50ReverbFader, gkDarkside50ReverbPan, gkDarkside50ReverbEqBass, gkDarkside50ReverbEqMid, gkDarkside50ReverbEqHigh

  outleta "OutL", aDarkside50ReverbL
  outleta "OutR", aDarkside50ReverbR
endin
