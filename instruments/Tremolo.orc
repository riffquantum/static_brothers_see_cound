bypassRoute "Tremolo", "Mixer", "Mixer"

alwayson "TremoloInput"
alwayson "TremoloMixerChannel"

gkTremoloEqBass init 1
gkTremoloEqMid init 1
gkTremoloEqHigh init 1
gkTremoloFader init 1
gkTremoloPan init 50

gkTremoloDryAmount init 0
gkTremoloWetAmount init 1

giTremoloWaveShapes[] fillarray sineWave(), triangleWave()
giTremoloWaveShape init 1
gaTremoloWaveSquareness init 0
gkTremoloRate init 2
gkTremoloDepth init 1


instr TremoloInput
  aTremoloInL inleta "InL"
  aTremoloInR inleta "InR"

  aTremoloOutWetL, aTremoloOutWetR, aTremoloOutDryL, aTremoloOutDryR bypassSwitch aTremoloInL, aTremoloInR, gkTremoloDryAmount, gkTremoloWetAmount, "Tremolo"

  outleta "OutWetL", aTremoloOutWetL
  outleta "OutWetR", aTremoloOutWetR

  outleta "OutDryL", aTremoloOutDryL
  outleta "OutDryR", aTremoloOutDryR
endin


instr Tremolo
  aTremoloInL inleta "InL"
  aTremoloInR inleta "InR"

  kTremoloDepth = limit(gkTremoloDepth, 0, 1)
  aSquareness = (((gaTremoloWaveSquareness/100)^(1/.3))*20) + 1 ; NOTE: the opcode squinewave may be a better option for this.
  aTremoloWave = (poscil(.5, gkTremoloRate, giTremoloWaveShapes[giTremoloWaveShape])) * aSquareness
  aTremoloWave = limit(aTremoloWave, -0.5, 0.5) + 0.5
  aTremoloWave = 1 - (aTremoloWave*kTremoloDepth)

  ; optional monitor
  ; printk .01, k(aTremoloWave)

  aTremoloOutL = aTremoloInL
  aTremoloOutR = aTremoloInR

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
