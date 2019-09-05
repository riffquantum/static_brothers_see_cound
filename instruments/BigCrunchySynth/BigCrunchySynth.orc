connect "BigCrunchySynth", "BigCrunchySynthOutL", "BigCrunchySynthMixerChannel", "BigCrunchySynthInL"
connect "BigCrunchySynth", "BigCrunchySynthOutR", "BigCrunchySynthMixerChannel", "BigCrunchySynthInR"

alwayson "BigCrunchySynthMixerChannel"

gkBigCrunchySynthEqBass init 1
gkBigCrunchySynthEqMid init 1
gkBigCrunchySynthEqHigh init 1
gkBigCrunchySynthFader init 1
gkBigCrunchySynthPan init 50

/* MIDI Config Values */
massign giBigCrunchySynthMidiChannel, "BigCrunchySynth"

instr BigCrunchySynth
    iAmplitude flexibleAmplitudeInput p4
    kAmplitudeEnvelope madsr .005, .01, iAmplitude, .5, 0

    ifreq flexiblePitchInput p5
    kfreq   linseg    ifreq*1.02, 0.3, ifreq

    iSineTable sineWave
    iSawTable sawtoothWaveUpAndDown
    iTriangleTable triangleWave
    iSquareTable squareWave


    aBigCrunchySynth1      oscil   kAmplitudeEnvelope,    kfreq,          iSineTable ; main oscillator

    aBigCrunchySynth2      oscil   kAmplitudeEnvelope/2,   (kfreq * 18),  iSawTable ; chorus oscillator

    aBigCrunchySynth3      oscil   kAmplitudeEnvelope/3,   (kfreq * 3),  iTriangleTable
    aBigCrunchySynth4      oscil   kAmplitudeEnvelope/4,   (kfreq * 4),  iSawTable
    aBigCrunchySynth5      oscil   kAmplitudeEnvelope/5,   (kfreq * 5),  iSineTable
    aBigCrunchySynth6      oscil   kAmplitudeEnvelope/6,   (kfreq * 6),  iSquareTable
    aBigCrunchySynth7      oscil   kAmplitudeEnvelope/7,   (kfreq * .3),  iSquareTable
    aBigCrunchySynth8      oscil   kAmplitudeEnvelope/8,   (kfreq * .9),  iTriangleTable

    aOut = aBigCrunchySynth1 + aBigCrunchySynth2 + aBigCrunchySynth3 + aBigCrunchySynth4 + aBigCrunchySynth5 + aBigCrunchySynth6 + aBigCrunchySynth7 + aBigCrunchySynth8

    kcf line 1000, 1, 0
    aOut reson aOut, kcf, 500

    outleta "BigCrunchySynthOutL", aOut
    outleta "BigCrunchySynthOutR", aOut
endin

instr BigCrunchySynthBassKnob
    gkBigCrunchySynthEqBass linseg p4, p3, p5
endin

instr BigCrunchySynthMidKnob
    gkBigCrunchySynthEqMid linseg p4, p3, p5
endin

instr BigCrunchySynthHighKnob
    gkBigCrunchySynthEqHigh linseg p4, p3, p5
endin

instr BigCrunchySynthFader
    gkBigCrunchySynthFader linseg p4, p3, p5
endin

instr BigCrunchySynthPan
    gkBigCrunchySynthPan linseg p4, p3, p5
endin

instr BigCrunchySynthMixerChannel
    aBigCrunchySynthL inleta "BigCrunchySynthInL"
    aBigCrunchySynthR inleta "BigCrunchySynthInR"

    kBigCrunchySynthFader = gkBigCrunchySynthFader
    kBigCrunchySynthPan = gkBigCrunchySynthPan
    kBigCrunchySynthEqBass = gkBigCrunchySynthEqBass
    kBigCrunchySynthEqMid = gkBigCrunchySynthEqMid
    kBigCrunchySynthEqHigh = gkBigCrunchySynthEqHigh

    aBigCrunchySynthL, aBigCrunchySynthR threeBandEqStereo aBigCrunchySynthL, aBigCrunchySynthR, kBigCrunchySynthEqBass, kBigCrunchySynthEqMid, kBigCrunchySynthEqHigh

    if kBigCrunchySynthPan > 100 then
        kBigCrunchySynthPan = 100
    elseif kBigCrunchySynthPan < 0 then
        kBigCrunchySynthPan = 0
    endif

    aBigCrunchySynthL = (aBigCrunchySynthL * ((100 - kBigCrunchySynthPan) * 2 / 100)) * kBigCrunchySynthFader
    aBigCrunchySynthR = (aBigCrunchySynthR * (kBigCrunchySynthPan * 2 / 100)) * kBigCrunchySynthFader

    outleta "BigCrunchySynthOutL", aBigCrunchySynthL
    outleta "BigCrunchySynthOutR", aBigCrunchySynthR
endin
