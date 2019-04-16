connect "BigSynth", "BigSynthOutL", "BigSynthMixerChannel", "BigSynthInL"
connect "BigSynth", "BigSynthOutR", "BigSynthMixerChannel", "BigSynthInR"

alwayson "BigSynthMixerChannel"

gkBigSynthEqBass init 1
gkBigSynthEqMid init 1
gkBigSynthEqHigh init 1
gkBigSynthFader init 1
gkBigSynthPan init 50


massign 2, "BigSynth"
instr BigSynth
    if p4 != 0 then
      iNoteVelocity = p4
    else
      iNoteVelocity veloc
    endif



    iAmplitude = iNoteVelocity/127 * 0dbfs/10

    print iAmplitude

    kAmplitudeEnvelope madsr .05, .01, iAmplitude, .5, 0

    if p5 != 0 then
      ifreq = p4
    else
      ifreq   cpsmidi
    endif
    print ifreq

    kfreq   linseg    ifreq*1.2, 0.1, ifreq

    iTable ftgenonce 0, 0, 16384, 20, 1


    aChorusedSynthMidiIn1      oscil   kAmplitudeEnvelope,    ifreq,          iTable ; main oscillator

    aChorusedSynthMidiIn2      oscil   kAmplitudeEnvelope/2,   (ifreq * 2),  iTable ; chorus oscillator

    aChorusedSynthMidiIn3      oscil   kAmplitudeEnvelope/3,   (ifreq * 3),  iTable
    aChorusedSynthMidiIn4      oscil   kAmplitudeEnvelope/4,   (ifreq * 4),  iTable
    aChorusedSynthMidiIn5      oscil   kAmplitudeEnvelope/5,   (ifreq * 5),  iTable
    aChorusedSynthMidiIn6      oscil   kAmplitudeEnvelope/6,   (ifreq * 6),  iTable
    aChorusedSynthMidiIn7      oscil   kAmplitudeEnvelope/7,   (ifreq * 7),  iTable
    aChorusedSynthMidiIn8      oscil   kAmplitudeEnvelope/8,   (ifreq * 8),  iTable

    aOut = aChorusedSynthMidiIn1 + aChorusedSynthMidiIn2 + aChorusedSynthMidiIn3 + aChorusedSynthMidiIn4 + aChorusedSynthMidiIn5 + aChorusedSynthMidiIn6 + aChorusedSynthMidiIn7 + aChorusedSynthMidiIn8

    outleta "BigSynthOutL", aOut
    outleta "BigSynthOutR", aOut
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
    aBigSynthL inleta "BigSynthInL"
    aBigSynthR inleta "BigSynthInR"

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

    outleta "BigSynthOutL", aBigSynthL
    outleta "BigSynthOutR", aBigSynthR
endin

