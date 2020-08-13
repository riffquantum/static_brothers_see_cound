instrumentRoute "BigSynth", "Mixer"
alwayson "BigSynthMixerChannel"

gkBigSynthEqBass init 1
gkBigSynthEqMid init 1
gkBigSynthEqHigh init 1
gkBigSynthFader init .001
gkBigSynthPan init 50

instr BigSynth
    if p4 != 0 then
      iAmplitude = p4
    else
      iNoteVelocity veloc
      iAmplitude = iNoteVelocity/127 * 0dbfs/10
    endif

    kAmplitudeEnvelope = madsr(.005, .01, 1, .05, 0) * iAmplitude

    if p5 != 0 then
      ifreq = p5
      ifreq = (p5 < 15 ? cpspch(p5) : p5)
    else
      ifreq   cpsmidi
    endif

    kfreq   linseg    ifreq*1.02, 0.3, ifreq

    ;sine waves
    iSineTable sineWave

    ;sawtooth
    iSawTable sawtoothWaveUpAndDown

    ; triangle
    iTriangleTable triangleWave

    ;square
    iSquareTable squareWave


    aChorusedSynthMidiIn1      oscil   kAmplitudeEnvelope,    kfreq,          iSineTable ; main oscillator

    aChorusedSynthMidiIn2      oscil   kAmplitudeEnvelope/2,   (kfreq * 18),  iSawTable ; chorus oscillator

    aChorusedSynthMidiIn3      oscil   kAmplitudeEnvelope/3,   (kfreq * 3),  iTriangleTable
    aChorusedSynthMidiIn4      oscil   kAmplitudeEnvelope/4,   (kfreq * 4),  iSawTable
    aChorusedSynthMidiIn5      oscil   kAmplitudeEnvelope/5,   (kfreq * 5),  iSineTable
    aChorusedSynthMidiIn6      oscil   kAmplitudeEnvelope/6,   (kfreq * 6),  iSquareTable
    aChorusedSynthMidiIn7      oscil   kAmplitudeEnvelope/7,   (kfreq * .3),  iSquareTable
    aChorusedSynthMidiIn8      oscil   kAmplitudeEnvelope/8,   (kfreq * .9),  iTriangleTable

    aOut = aChorusedSynthMidiIn1 + aChorusedSynthMidiIn2 + aChorusedSynthMidiIn3 + aChorusedSynthMidiIn4 + aChorusedSynthMidiIn5 + aChorusedSynthMidiIn6 + aChorusedSynthMidiIn7 + aChorusedSynthMidiIn8

    kcf line 1000, 1, 0
    aOut reson aOut, kcf, 1/kcf

    outleta "OutL", aOut
    outleta "OutR", aOut
endin

instr BigSynthBassKnob
    gkBigSynthEqBass linseg p4, p3, p5
endin

instr BigSynthMidKnob
    gkBigSynthEqMid linseg p4, p3, p5
endin

instr BigSynthHighKnob
    gkBigSynthEqHigh linseg p4, p3, p5
endin

instr BigSynthFader
    gkBigSynthFader linseg p4, p3, p5
endin

instr BigSynthPan
    gkBigSynthPan linseg p4, p3, p5
endin

instr BigSynthMixerChannel
    aBigSynthL inleta "InL"
    aBigSynthR inleta "InR"

    kBigSynthFader = gkBigSynthFader
    kBigSynthPan = gkBigSynthPan
    kBigSynthEqBass = gkBigSynthEqBass
    kBigSynthEqMid = gkBigSynthEqMid
    kBigSynthEqHigh = gkBigSynthEqHigh

    aBigSynthL, aBigSynthR threeBandEqStereo aBigSynthL, aBigSynthR, kBigSynthEqBass, kBigSynthEqMid, kBigSynthEqHigh

    if kBigSynthPan > 100 then
        kBigSynthPan = 100
    elseif kBigSynthPan < 0 then
        kBigSynthPan = 0
    endif

    aBigSynthL = (aBigSynthL * ((100 - kBigSynthPan) * 2 / 100)) * kBigSynthFader
    aBigSynthR = (aBigSynthR * (kBigSynthPan * 2 / 100)) * kBigSynthFader

    outleta "OutL", aBigSynthL
    outleta "OutR", aBigSynthR
endin

