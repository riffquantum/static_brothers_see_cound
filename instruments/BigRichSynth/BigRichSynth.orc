connect "BigRichSynth", "BigRichSynthOutL", "BigRichSynthMixerChannel", "BigRichSynthInL"
connect "BigRichSynth", "BigRichSynthOutR", "BigRichSynthMixerChannel", "BigRichSynthInR"

alwayson "BigRichSynthMixerChannel"

gkBigRichSynthEqBass init 1
gkBigRichSynthEqMid init 1
gkBigRichSynthEqHigh init 1
gkBigRichSynthFader init 1
gkBigRichSynthPan init 50

/* MIDI Config Values */
massign giBigRichSynthMidiChannel, "BigRichSynth"


instr BigRichSynth
    if p4 != 0 then
      iAmplitude = p4
    else
      iNoteVelocity veloc
      iAmplitude = iNoteVelocity/127 * 0dbfs/10
    endif

    kAmplitudeEnvelope madsr .005, .01, iAmplitude, .05, 0

    if p5 != 0 then
      ifreq = p5
      ifreq = (p5 < 15 ? cpspch(p5) : p5)
    else
      ifreq   cpsmidi
    endif

    kPitchBend = 0

    midipitchbend kPitchBend, 0, 15

    kfreq   linseg    ifreq*1.02, 0.3, ifreq
    kfreq = kfreq * (1+kPitchBend)

    iSineTable sineWave
    iSawTable sawtoothWaveUpAndDown
    iTriangleTable triangleWave
    iSquareTable squareWave


    aBigRichSynth1      oscil   kAmplitudeEnvelope,    kfreq,          iSineTable ; main oscillator

    aBigRichSynth2      oscil   kAmplitudeEnvelope/2,   (kfreq * 18),  iSawTable ; chorus oscillator

    aBigRichSynth3      oscil   kAmplitudeEnvelope/3,   (kfreq * 3),  iTriangleTable
    aBigRichSynth4      oscil   kAmplitudeEnvelope/4,   (kfreq * 4),  iSawTable
    aBigRichSynth5      oscil   kAmplitudeEnvelope/5,   (kfreq * 5),  iSineTable
    aBigRichSynth6      oscil   kAmplitudeEnvelope/6,   (kfreq * 6),  iSquareTable
    aBigRichSynth7      oscil   kAmplitudeEnvelope/7,   (kfreq * .3),  iSquareTable
    aBigRichSynth8      oscil   kAmplitudeEnvelope/8,   (kfreq * .9),  iTriangleTable

    aOut = aBigRichSynth1 + aBigRichSynth2 + aBigRichSynth3 + aBigRichSynth4 + aBigRichSynth5 + aBigRichSynth6 + aBigRichSynth7 + aBigRichSynth8

    outleta "BigRichSynthOutL", aOut
    outleta "BigRichSynthOutR", aOut
endin

instr BigRichSynthBassKnob
    gkBigRichSynthEqBass linseg p4, p3, p5
endin

instr BigRichSynthMidKnob
    gkBigRichSynthEqMid linseg p4, p3, p5
endin

instr BigRichSynthHighKnob
    gkBigRichSynthEqHigh linseg p4, p3, p5
endin

instr BigRichSynthFader
    gkBigRichSynthFader linseg p4, p3, p5
endin

instr BigRichSynthPan
    gkBigRichSynthPan linseg p4, p3, p5
endin

instr BigRichSynthMixerChannel
    aBigRichSynthL inleta "BigRichSynthInL"
    aBigRichSynthR inleta "BigRichSynthInR"

    kBigRichSynthFader = gkBigRichSynthFader
    kBigRichSynthPan = gkBigRichSynthPan
    kBigRichSynthEqBass = gkBigRichSynthEqBass
    kBigRichSynthEqMid = gkBigRichSynthEqMid
    kBigRichSynthEqHigh = gkBigRichSynthEqHigh

    aBigRichSynthL, aBigRichSynthR threeBandEqStereo aBigRichSynthL, aBigRichSynthR, kBigRichSynthEqBass, kBigRichSynthEqMid, kBigRichSynthEqHigh

    if kBigRichSynthPan > 100 then
        kBigRichSynthPan = 100
    elseif kBigRichSynthPan < 0 then
        kBigRichSynthPan = 0
    endif

    aBigRichSynthL = (aBigRichSynthL * ((100 - kBigRichSynthPan) * 2 / 100)) * kBigRichSynthFader
    aBigRichSynthR = (aBigRichSynthR * (kBigRichSynthPan * 2 / 100)) * kBigRichSynthFader

    outleta "BigRichSynthOutL", aBigRichSynthL
    outleta "BigRichSynthOutR", aBigRichSynthR
endin
