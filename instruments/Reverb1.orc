alwayson "Reverb1"
connect "Reverb1", "Reverb1OutL", "Mixer", "MixerInL"
connect "Reverb1", "Reverb1OutR", "Mixer", "MixerInR"

gkReverb1Wet init 1
gkReverb1Dry init 1

gkReverb1Delay init 0
gkReverb1Cutoff init 1200

instr Reverb1
  aReverb1InL inleta "Reverb1InL"
  aReverb1InR inleta "Reverb1InR"
  aReverb1WetL, aReverb1WetR reverbsc aReverb1InL, aReverb1InR, gkReverb1Delay, gkReverb1Cutoff

  aReverb1L = (aReverb1WetL * gkReverb1Wet) + (aReverb1InL * gkReverb1Dry)
  aReverb1R = (aReverb1WetR * gkReverb1Wet) + (aReverb1InR * gkReverb1Dry)

  outleta "Reverb1OutL", aReverb1L
  outleta "Reverb1OutR", aReverb1R

endin

instr Reverb1Wet
    gkReverb1Dry linseg p4, p3, p5
endin

instr Reverb1Dry
    gkReverb1Wet linseg p4, p3, p5
endin

instr Reverb1DelayKnob
    gkReverb1Delay linseg p4, p3, p5
endin

instr Reverb1CutoffKnob
    gkReverb1Cutoff linseg p4, p3, p5
endin
