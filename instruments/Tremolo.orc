bypassRoute "Tremolo", "Mixer", "Mixer"

alwayson "TremoloInput"
alwayson "TremoloMixerChannel"

gkTremoloEqBass init 1
gkTremoloEqMid init 1
gkTremoloEqHigh init 1
gkTremoloFader init 1
gkTremoloPan init 50

gkTremoloDryAmmount init 0
gkTremoloWetAmmount init 1

gkTremoloRate init 20
gkTremoloDepth init 1


instr TremoloInput
  aTremoloInL inleta "InL"
  aTremoloInR inleta "InR"

  aTremoloOutWetL, aTremoloOutWetR, aTremoloOutDryL, aTremoloOutDryR bypassSwitch aTremoloInL, aTremoloInR, gkTremoloDryAmmount, gkTremoloWetAmmount, "Tremolo"

  outleta "OutWetL", aTremoloOutWetL
  outleta "OutWetR", aTremoloOutWetR

  outleta "OutDryL", aTremoloOutDryL
  outleta "OutDryR", aTremoloOutDryR
endin


instr Tremolo
  aTremoloInL inleta "InL"
  aTremoloInR inleta "InR"

  aTremoloOutL = aTremoloInL
  aTremoloOutR = aTremoloInR

  gkTremoloDepth = limit(gkTremoloDepth, 0, 1)
  aTremoloWave = poscil(gkTremoloDepth, gkTremoloRate) + (1 - gkTremoloDepth)

  aTremoloOutL *= aTremoloWave
  aTremoloOutR *= aTremoloWave

  outleta "OutL", aTremoloOutL
  outleta "OutR", aTremoloOutR
endin

instr TremoloBassKnob
  gkTremoloEqBass linseg p4, p3, p5
endin

instr TremoloMidKnob
  gkTremoloEqMid linseg p4, p3, p5
endin

instr TremoloHighKnob
  gkTremoloEqHigh linseg p4, p3, p5
endin

instr TremoloFader
  gkTremoloFader linseg p4, p3, p5
endin

instr TremoloPan
  gkTremoloPan linseg p4, p3, p5
endin

instr TremoloMixerChannel
  aTremoloL inleta "InL"
  aTremoloR inleta "InR"

  aTremoloL, aTremoloR mixerChannel aTremoloL, aTremoloR, gkTremoloFader, gkTremoloPan, gkTremoloEqBass, gkTremoloEqMid, gkTremoloEqHigh

  outleta "OutL", aTremoloL
  outleta "OutR", aTremoloR
endin
