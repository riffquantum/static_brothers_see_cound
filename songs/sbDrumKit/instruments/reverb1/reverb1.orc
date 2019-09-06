alwayson "Reverb1"
alwayson "Reverb1MixerChannel"

connect "Reverb1", "Reverb1OutL", "Reverb1MixerChannel", "Reverb1InL"
connect "Reverb1", "Reverb1OutR", "Reverb1MixerChannel", "Reverb1InR"

connect "Reverb1MixerChannel", "Reverb1OutL", "Mixer", "MixerInL"
connect "Reverb1MixerChannel", "Reverb1OutR", "Mixer", "MixerInR"


gkReverb1EqBass init 1
gkReverb1EqMid init 1
gkReverb1EqHigh init 1
gkReverb1Fader init 1
gkReverb1Pan init 50

gkReverb1Wet init .3
gkReverb1Dry init 1

gkReverb1Delay init .8
gkReverb1Cutoff init sr/2-1

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

instr Reverb1BassKnob
    gkReverb1EqBass linseg p4, p3, p5
endin

instr Reverb1MidKnob
    gkReverb1EqMid linseg p4, p3, p5
endin

instr Reverb1HighKnob
    gkReverb1EqHigh linseg p4, p3, p5
endin

instr Reverb1Fader
    gkReverb1Fader linseg p4, p3, p5
endin

instr Reverb1Pan
    gkReverb1Pan linseg p4, p3, p5
endin

instr Reverb1MixerChannel
    aReverb1L inleta "Reverb1InL"
    aReverb1R inleta "Reverb1InR"

    kReverb1Fader = gkReverb1Fader
    kReverb1Pan = gkReverb1Pan
    kReverb1EqBass = gkReverb1EqBass
    kReverb1EqMid = gkReverb1EqMid
    kReverb1EqHigh = gkReverb1EqHigh

    aReverb1L, aReverb1R threeBandEqStereo aReverb1L, aReverb1R, kReverb1EqBass, kReverb1EqMid, kReverb1EqHigh

    if kReverb1Pan > 100 then
        kReverb1Pan = 100
    elseif kReverb1Pan < 0 then
        kReverb1Pan = 0
    endif

    aReverb1L = (aReverb1L * ((100 - kReverb1Pan) * 2 / 100)) * kReverb1Fader
    aReverb1R = (aReverb1R * (kReverb1Pan * 2 / 100)) * kReverb1Fader

    outleta "Reverb1OutL", aReverb1L
    outleta "Reverb1OutR", aReverb1R
endin
