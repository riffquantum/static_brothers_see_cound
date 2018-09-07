; Amen Break

connect "AmenBreak", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"
connect "AmenBreakMixerChannel", "AmenBreakOutL", "Mixer", "MixerInL"
connect "AmenBreakMixerChannel", "AmenBreakOutR", "Mixer", "MixerInR"
alwayson "AmenBreakMixerChannel"

gkAmenBreakFader init 1
gkAmenBreakPan init 50

instr AmenBreak

    iTable ftgenonce 100, 0, 8192, 20, 2, 1

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aAmen diskgrain "instruments/amen-break.wav", 1,    10000,     1,  0.0001,     p4, 100,  1000

    outleta "AmenBreakOut", aAmen

endin

instr AmenBreakFader
    gkAmenBreakFader linseg p4, p3, p5
endin

instr AmenBreakPan
    gkAmenBreakPan linseg p4, p3, p5
endin

instr AmenBreakMixerChannel
    aAmenBreakL inleta "AmenBreakIn"
    aAmenBreakR inleta "AmenBreakIn"

    kAmenBreakFader = gkAmenBreakFader
    kAmenBreakPan = gkAmenBreakPan

    if kAmenBreakPan > 100 then
        kAmenBreakPan = 100
    elseif kAmenBreakPan < 0 then
        kAmenBreakPan = 0
    endif

    aAmenBreakL = (aAmenBreakL * ((100 - kAmenBreakPan) * 2 / 100)) * kAmenBreakFader
    aAmenBreakR = (aAmenBreakR * (kAmenBreakPan * 2 / 100)) * kAmenBreakFader

    outleta "AmenBreakOutL", aAmenBreakL
    outleta "AmenBreakOutR", aAmenBreakR
endin

