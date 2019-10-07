gSChorusedSynthName = "ChorusedSynth"
gSChorusedSynthRoute = "Mixer"
instrumentRoute gSChorusedSynthName, gSChorusedSynthRoute

alwayson "ChorusedSynthMixerChannel"

gkChorusedSynthEqBass init 1
gkChorusedSynthEqMid init 1
gkChorusedSynthEqHigh init 1
gkChorusedSynthFader init 1
gkChorusedSynthPan init 50

instr ChorusedSynth
    ;CONTROL SIGNALS
    ;output action  args


    kamp    linseg    p4, (p3 - (p3 * 0.1)), p4, (p3 * 0.1), 0 ; amplitude envelope
    ifreq    =        (p5 < 15 ? cpspch(p5) : p5)
    kfreq   linseg    ifreq*1.2, (p3*0.2), ifreq

    iTable ftgenonce 100, 0, 16384, 20, 1

    ;AUDIO SIGNALS
    ;output action  args
    ;               amp     hz                    f
    aChorusedSynth1      oscil   kamp,    ifreq,          100 ; main oscillator

    aChorusedSynth2      oscil   kamp,   (ifreq * 0.99),  100 ; chorus oscillator

    aChorusedSynth3      oscil   kamp,   (ifreq * 1.01),  100
                         outleta "ChorusedSynthOut", aChorusedSynth1 + aChorusedSynth2 + aChorusedSynth3
endin

instr ChorusedSynthBassKnob
    gkChorusedSynthEqBass linseg p4, p3, p5
endin

instr ChorusedSynthMidKnob
    gkChorusedSynthEqMid linseg p4, p3, p5
endin

instr ChorusedSynthHighKnob
    gkChorusedSynthEqHigh linseg p4, p3, p5
endin

instr ChorusedSynthFader
    gkChorusedSynthFader linseg p4, p3, p5
endin

instr ChorusedSynthPan
    gkChorusedSynthPan linseg p4, p3, p5
endin

instr ChorusedSynthMixerChannel
    aChorusedSynthL inleta "ChorusedSynthIn"
    aChorusedSynthR inleta "ChorusedSynthIn"

    kChorusedSynthFader = gkChorusedSynthFader
    kChorusedSynthPan = gkChorusedSynthPan
    kChorusedSynthEqBass = gkChorusedSynthEqBass
    kChorusedSynthEqMid = gkChorusedSynthEqMid
    kChorusedSynthEqHigh = gkChorusedSynthEqHigh

    aChorusedSynthL, aChorusedSynthR threeBandEqStereo aChorusedSynthL, aChorusedSynthR, kChorusedSynthEqBass, kChorusedSynthEqMid, kChorusedSynthEqHigh

    if kChorusedSynthPan > 100 then
        kChorusedSynthPan = 100
    elseif kChorusedSynthPan < 0 then
        kChorusedSynthPan = 0
    endif

    aChorusedSynthL = (aChorusedSynthL * ((100 - kChorusedSynthPan) * 2 / 100)) * kChorusedSynthFader
    aChorusedSynthR = (aChorusedSynthR * (kChorusedSynthPan * 2 / 100)) * kChorusedSynthFader

    outleta "ChorusedSynthOutL", aChorusedSynthL
    outleta "ChorusedSynthOutR", aChorusedSynthR
endin

