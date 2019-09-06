; Chorused Synth

connect "ChorusedSynthMidiIn", "ChorusedSynthMidiInOut", "ChorusedSynthMidiInMixerChannel", "ChorusedSynthMidiInIn"

connect "ChorusedSynthMidiInMixerChannel", "ChorusedSynthMidiInOutL", "Mixer", "MixerInL"
connect "ChorusedSynthMidiInMixerChannel", "ChorusedSynthMidiInOutR", "Mixer", "MixerInR"

alwayson "ChorusedSynthMidiInMixerChannel"

gkChorusedSynthMidiInFader init 1
gkChorusedSynthMidiInPan init 50

instr ChorusedSynthMidiIn
    ;CONTROL SIGNALS
    ;output action  args


    kamp     =        0.1
    ifreq   cpsmidi
    kfreq   linseg    ifreq*1.2, 0.1, ifreq

    iTable ftgenonce 100, 0, 16384, 20, 1

    ;AUDIO SIGNALS
    ;output action  args
    ;               amp     hz                    f
    aChorusedSynthMidiIn1      oscil   kamp,    ifreq,          100 ; main oscillator

    aChorusedSynthMidiIn2      oscil   kamp,   (ifreq * 0.99),  100 ; chorus oscillator

    aChorusedSynthMidiIn3      oscil   kamp,   (ifreq * 1.01),  100
                         outleta "ChorusedSynthMidiInOut", aChorusedSynthMidiIn1 + aChorusedSynthMidiIn2 + aChorusedSynthMidiIn3
endin

instr ChorusedSynthMidiInFader
    gkChorusedSynthMidiInFader linseg p4, p3, p5
endin

instr ChorusedSynthMidiInPan
    gkChorusedSynthMidiInPan linseg p4, p3, p5
endin

instr ChorusedSynthMidiInMixerChannel
    aChorusedSynthMidiInL inleta "ChorusedSynthMidiInIn"
    aChorusedSynthMidiInR inleta "ChorusedSynthMidiInIn"

    kChorusedSynthMidiInFader = gkChorusedSynthMidiInFader
    kChorusedSynthMidiInPan = gkChorusedSynthMidiInPan

    if kChorusedSynthMidiInPan > 100 then
        kChorusedSynthMidiInPan = 100
    elseif kChorusedSynthMidiInPan < 0 then
        kChorusedSynthMidiInPan = 0
    endif

    aChorusedSynthMidiInL = (aChorusedSynthMidiInL * ((100 - kChorusedSynthMidiInPan) * 2 / 100)) * kChorusedSynthMidiInFader
    aChorusedSynthMidiInR = (aChorusedSynthMidiInR * (kChorusedSynthMidiInPan * 2 / 100)) * kChorusedSynthMidiInFader

    outleta "ChorusedSynthMidiInOutL", aChorusedSynthMidiInL
    outleta "ChorusedSynthMidiInOutR", aChorusedSynthMidiInR
endin

