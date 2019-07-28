alwayson "Reverb"
alwayson "ReverbMixerChannel"

connect "Reverb", "ReverbOutL", "ReverbMixerChannel", "ReverbInL"
connect "Reverb", "ReverbOutR", "ReverbMixerChannel", "ReverbInR"

gkReverbEqBass init 1
gkReverbEqMid init 1
gkReverbEqHigh init 1
gkReverbFader init 1
gkReverbPan init 50

gkReverbWet init .3
gkReverbDry init 1

gkReverbDelay init .8
gkReverbCutoff init sr/2-1

instr Reverb
  aReverbInL inleta "ReverbInL"
  aReverbInR inleta "ReverbInR"

  aReverbWetL, aReverbWetR reverbsc aReverbInL, aReverbInR, gkReverbDelay, gkReverbCutoff

  aReverbL = (aReverbWetL * gkReverbWet) + (aReverbInL * gkReverbDry)
  aReverbR = (aReverbWetR * gkReverbWet) + (aReverbInR * gkReverbDry)

  outleta "ReverbOutL", aReverbL
  outleta "ReverbOutR", aReverbR
endin

instr ReverbWet
    gkReverbDry linseg p4, p3, p5
endin

instr ReverbDry
    gkReverbWet linseg p4, p3, p5
endin

instr ReverbDelayKnob
    gkReverbDelay linseg p4, p3, p5
endin

instr ReverbCutoffKnob
    gkReverbCutoff linseg p4, p3, p5
endin

instr ReverbBassKnob
    gkReverbEqBass linseg p4, p3, p5
endin

instr ReverbMidKnob
    gkReverbEqMid linseg p4, p3, p5
endin

instr ReverbHighKnob
    gkReverbEqHigh linseg p4, p3, p5
endin

instr ReverbFader
    gkReverbFader linseg p4, p3, p5
endin

instr ReverbPan
    gkReverbPan linseg p4, p3, p5
endin

instr ReverbMixerChannel
    aReverbL inleta "ReverbInL"
    aReverbR inleta "ReverbInR"

    kReverbFader = gkReverbFader
    kReverbPan = gkReverbPan
    kReverbEqBass = gkReverbEqBass
    kReverbEqMid = gkReverbEqMid
    kReverbEqHigh = gkReverbEqHigh

    aReverbL, aReverbR threeBandEqStereo aReverbL, aReverbR, kReverbEqBass, kReverbEqMid, kReverbEqHigh

    if kReverbPan > 100 then
        kReverbPan = 100
    elseif kReverbPan < 0 then
        kReverbPan = 0
    endif

    aReverbL = (aReverbL * ((100 - kReverbPan) * 2 / 100)) * kReverbFader
    aReverbR = (aReverbR * (kReverbPan * 2 / 100)) * kReverbFader

    outleta "ReverbOutL", aReverbL
    outleta "ReverbOutR", aReverbR
endin
