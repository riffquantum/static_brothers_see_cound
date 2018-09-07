; Chorused Synth

connect "SimpleOscillator", "SimpleOscillatorOut", "SimpleOscillatorMixerChannel", "SimpleOscillatorIn"
connect "SimpleOscillatorMixerChannel", "SimpleOscillatorOutL", "Mixer", "MixerInL"
connect "SimpleOscillatorMixerChannel", "SimpleOscillatorOutR", "Mixer", "MixerInR"
alwayson "SimpleOscillatorMixerChannel"

gkSimpleOscillatorFader init 1
gkSimpleOscillatorPan init 50

instr SimpleOscillator
    ;CONTROL SIGNALS
    ;output action  args
    kamp   = p4

    ;AUDIO SIGNALS
    ;output action  args
    ;               amp     hz                    f
    aSimpleOscillator1      oscil   kamp,    cpspch(p5),          2 ; main oscillator
                         outleta "SimpleOscillatorOut", aSimpleOscillator1
endin

instr SimpleOscillatorFader
    gkSimpleOscillatorFader linseg p4, p3, p5
endin

instr SimpleOscillatorPan
    gkSimpleOscillatorPan linseg p4, p3, p5
endin

instr SimpleOscillatorMixerChannel
    aSimpleOscillatorL inleta "SimpleOscillatorIn"
    aSimpleOscillatorR inleta "SimpleOscillatorIn"

    kSimpleOscillatorFader = gkSimpleOscillatorFader
    kSimpleOscillatorPan = gkSimpleOscillatorPan

    if kSimpleOscillatorPan > 100 then
        kSimpleOscillatorPan = 100
    elseif kSimpleOscillatorPan < 0 then
        kSimpleOscillatorPan = 0
    endif

    aSimpleOscillatorL = (aSimpleOscillatorL * ((100 - kSimpleOscillatorPan) * 2 / 100)) * kSimpleOscillatorFader
    aSimpleOscillatorR = (aSimpleOscillatorR * (kSimpleOscillatorPan * 2 / 100)) * kSimpleOscillatorFader

    outleta "SimpleOscillatorOutL", aSimpleOscillatorL
    outleta "SimpleOscillatorOutR", aSimpleOscillatorR
endin
