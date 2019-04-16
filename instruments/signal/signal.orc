; Signal

connect "Signal", "SignalOut", "SignalMixerChannel", "SignalIn"

alwayson "SignalMixerChannel"

gkSignalEqBass init 1
gkSignalEqMid init 1
gkSignalEqHigh init 1
gkSignalFader init 1
gkSignalPan init 50

instr Signal
    iKamp = p4
    iFreq = (p5 < 15 ? cpspch(p5) : p5)
    iWave ftgenonce 0, 0, 2^10, 10, 1, 0.5, 2

    timout (p3/2), (p3/2), branch

    aSignal oscil iKamp/2, iFreq, iWave
            outleta "SignalOut", aSignal

    branch:
      aSignal2 oscil iKamp/2, iFreq*1.5, iWave
      aSignal = aSignal + aSignal2
endin

instr SignalBassKnob
    gkSignalEqBass linseg p4, p3, p5
endin

instr SignalMidKnob
    gkSignalEqMid linseg p4, p3, p5
endin

instr SignalHighKnob
    gkSignalEqHigh linseg p4, p3, p5
endin

instr SignalFader
    gkSignalFader linseg p4, p3, p5
endin

instr SignalPan
    gkSignalPan linseg p4, p3, p5
endin

instr SignalMixerChannel
    aSignalL inleta "SignalIn"
    aSignalR inleta "SignalIn"

    kpanvalue linseg 0, 1, 100

    kSignalFader = gkSignalFader
    kSignalPan = gkSignalPan
    kSignalEqBass = gkSignalEqBass
    kSignalEqMid = gkSignalEqMid
    kSignalEqHigh = gkSignalEqHigh

    aSignalL, aSignalR threeBandEqStereo aSignalL, aSignalR, kSignalEqBass, kSignalEqMid, kSignalEqHigh

    if kSignalPan > 100 then
        kSignalPan = 100
    elseif kSignalPan < 0 then
        kSignalPan = 0
    endif

    aSignalL = (aSignalL * ((100 - kSignalPan) * 2 / 100)) * kSignalFader
    aSignalR = (aSignalR * (kSignalPan * 2 / 100)) * kSignalFader

    outleta "SignalOutL", aSignalL
    outleta "SignalOutR", aSignalR

endin
