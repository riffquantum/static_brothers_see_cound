alwayson "RingModForLeadSynthInput"
alwayson "RingModForLeadSynthMixerChannel"

gkRingModForLeadSynthEqBass init 1
gkRingModForLeadSynthEqMid init 1
gkRingModForLeadSynthEqHigh init 1
gkRingModForLeadSynthFader init 1
gkRingModForLeadSynthPan init 50

bypassRoute "RingModForLeadSynth", "Mixer", "Mixer"

gkRingModForLeadSynthDryAmount init 1
gkRingModForLeadSynthWetAmount init 1

gkRingModForLeadSynthModulator1Frequency init 2000
gkRingModForLeadSynthModulator1Amount init 1
gkRingModForLeadSynthModulator2Frequency init 1200
gkRingModForLeadSynthModulator2Amount init 0
gkRingModForLeadSynthModulator3Frequency init 800
gkRingModForLeadSynthModulator3Amount init 0
gkRingModForLeadSynthModulator4Frequency init 440
gkRingModForLeadSynthModulator4Amount init 0
gkRingModForLeadSynthModulator5Frequency init 263
gkRingModForLeadSynthModulator5Amount init 0

instr RingModForLeadSynthInput
  aRingModForLeadSynthInL inleta "InL"
  aRingModForLeadSynthInR inleta "InR"

  aRingModForLeadSynthOutWetL, aRingModForLeadSynthOutWetR, aRingModForLeadSynthOutDryL, aRingModForLeadSynthOutDryR bypassSwitch aRingModForLeadSynthInL, aRingModForLeadSynthInR, gkRingModForLeadSynthDryAmount, gkRingModForLeadSynthWetAmount, "RingModForLeadSynth"

  outleta "OutWetL", aRingModForLeadSynthOutWetL
  outleta "OutWetR", aRingModForLeadSynthOutWetR

  outleta "OutDryL", aRingModForLeadSynthOutDryL
  outleta "OutDryR", aRingModForLeadSynthOutDryR
endin

instr RingModForLeadSynth
  aRingModForLeadSynthInL inleta "InL"
  aRingModForLeadSynthInR inleta "InR"

  aRingModForLeadSynthOutL = aRingModForLeadSynthInL
  aRingModForLeadSynthOutR = aRingModForLeadSynthInR

  aModulator = 0
  aModulator += oscil(gkRingModForLeadSynthModulator1Amount, gkRingModForLeadSynthModulator1Frequency)
  aModulator += oscil(gkRingModForLeadSynthModulator2Amount, gkRingModForLeadSynthModulator2Frequency)
  aModulator += oscil(gkRingModForLeadSynthModulator3Amount, gkRingModForLeadSynthModulator3Frequency)
  aModulator += oscil(gkRingModForLeadSynthModulator4Amount, gkRingModForLeadSynthModulator4Frequency)
  aModulator += oscil(gkRingModForLeadSynthModulator5Amount, gkRingModForLeadSynthModulator5Frequency)

  aRingModForLeadSynthOutL *= aModulator
  aRingModForLeadSynthOutR *= aModulator

  outleta "OutL", aRingModForLeadSynthOutL
  outleta "OutR", aRingModForLeadSynthOutR
endin

instr RingModForLeadSynthBassKnob
  gkRingModForLeadSynthEqBass linseg p4, p3, p5
endin

instr RingModForLeadSynthMidKnob
  gkRingModForLeadSynthEqMid linseg p4, p3, p5
endin

instr RingModForLeadSynthHighKnob
  gkRingModForLeadSynthEqHigh linseg p4, p3, p5
endin

instr RingModForLeadSynthFader
  gkRingModForLeadSynthFader linseg p4, p3, p5
endin

instr RingModForLeadSynthPan
  gkRingModForLeadSynthPan linseg p4, p3, p5
endin

instr RingModForLeadSynthMixerChannel
  aRingModForLeadSynthL inleta "InL"
  aRingModForLeadSynthR inleta "InR"

  aRingModForLeadSynthL, aRingModForLeadSynthR mixerChannel aRingModForLeadSynthL, aRingModForLeadSynthR, gkRingModForLeadSynthFader, gkRingModForLeadSynthPan, gkRingModForLeadSynthEqBass, gkRingModForLeadSynthEqMid, gkRingModForLeadSynthEqHigh

  outleta "OutL", aRingModForLeadSynthL
  outleta "OutR", aRingModForLeadSynthR
endin
