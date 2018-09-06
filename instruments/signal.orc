; Signal

connect "Signal", "SignalOut", "SignalMixerChannel", "SignalIn"
connect "SignalMixerChannel", "SignalOutL", "Mixer", "MixerInL"
connect "SignalMixerChannel", "SignalOutR", "Mixer", "MixerInR"
alwayson "SignalMixerChannel"

gkSignalFader init 1
gkSignalPan init 50

instr Signal
    iKamp = p4
    iFreq = (p5 < 15 ? cpspch(p5) : p5)
    iWave ftgenonce 0, 0, 2^10, 10, 1, 0.5, 2

    aSignal oscil iKamp, iFreq, iWave
            outleta "SignalOut", aSignal
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
