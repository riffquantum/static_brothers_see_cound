alwayson "ReverbForKick"
alwayson "ReverbForKickMixerChannel"

gSReverbForKickName = "ReverbForKick"
gSReverbForKickRoute = "KickBus"
instrumentRoute gSReverbForKickName, gSReverbForKickRoute

gkReverbForKickEqBass init 1
gkReverbForKickEqMid init 1
gkReverbForKickEqHigh init 1
gkReverbForKickFader init 1
gkReverbForKickPan init 50

gkReverbForKickWet init .2
gkReverbForKickDry init 1

gkReverbForKickDelay init .99
gkReverbForKickCutoff init sr/2-100

instr ReverbForKick
  aReverbForKickInL inleta "ReverbForKickInL"
  aReverbForKickInR inleta "ReverbForKickInR"

  aReverbForKickWetL, aReverbForKickWetR reverbsc aReverbForKickInL, aReverbForKickInR, gkReverbForKickDelay, gkReverbForKickCutoff

  kHighFrequencyDampening = .1
  aReverbForKickWetL, aReverbForKickWetR freeverb aReverbForKickInL, aReverbForKickInR, gkReverbForKickDelay, kHighFrequencyDampening

  aReverbForKickL = (aReverbForKickWetL * gkReverbForKickWet) + (aReverbForKickInL * gkReverbForKickDry)
  aReverbForKickR = (aReverbForKickWetR * gkReverbForKickWet) + (aReverbForKickInR * gkReverbForKickDry)

  outleta "ReverbForKickOutL", aReverbForKickL
  outleta "ReverbForKickOutR", aReverbForKickR
endin

instr ReverbForKickWet
    gkReverbForKickDry linseg p4, p3, p5
endin

instr ReverbForKickDry
    gkReverbForKickWet linseg p4, p3, p5
endin

instr ReverbForKickDelayKnob
    gkReverbForKickDelay linseg p4, p3, p5
endin

instr ReverbForKickCutoffKnob
    gkReverbForKickCutoff linseg p4, p3, p5
endin

instr ReverbForKickBassKnob
    gkReverbForKickEqBass linseg p4, p3, p5
endin

instr ReverbForKickMidKnob
    gkReverbForKickEqMid linseg p4, p3, p5
endin

instr ReverbForKickHighKnob
    gkReverbForKickEqHigh linseg p4, p3, p5
endin

instr ReverbForKickFader
    gkReverbForKickFader linseg p4, p3, p5
endin

instr ReverbForKickPan
    gkReverbForKickPan linseg p4, p3, p5
endin

instr ReverbForKickMixerChannel
    aReverbForKickL inleta "ReverbForKickInL"
    aReverbForKickR inleta "ReverbForKickInR"

    kReverbForKickFader = gkReverbForKickFader
    kReverbForKickPan = gkReverbForKickPan
    kReverbForKickEqBass = gkReverbForKickEqBass
    kReverbForKickEqMid = gkReverbForKickEqMid
    kReverbForKickEqHigh = gkReverbForKickEqHigh

    aReverbForKickL, aReverbForKickR threeBandEqStereo aReverbForKickL, aReverbForKickR, kReverbForKickEqBass, kReverbForKickEqMid, kReverbForKickEqHigh

    if kReverbForKickPan > 100 then
        kReverbForKickPan = 100
    elseif kReverbForKickPan < 0 then
        kReverbForKickPan = 0
    endif

    aReverbForKickL = (aReverbForKickL * ((100 - kReverbForKickPan) * 2 / 100)) * kReverbForKickFader
    aReverbForKickR = (aReverbForKickR * (kReverbForKickPan * 2 / 100)) * kReverbForKickFader

    outleta "ReverbForKickOutL", aReverbForKickL
    outleta "ReverbForKickOutR", aReverbForKickR
endin
