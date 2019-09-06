/* trrSample1 */

connect "trrSample1Diskin", "trrSample1OutL", "trrSample1MixerChannel", "trrSample1InL"
connect "trrSample1Diskin", "trrSample1OutR", "trrSample1MixerChannel", "trrSample1InR"

connect "trrSample1Diskgrain", "trrSample1OutL", "trrSample1MixerChannel", "trrSample1InL"
connect "trrSample1Diskgrain", "trrSample1OutR", "trrSample1MixerChannel", "trrSample1InR"

connect "trrSample1Sndwarp", "trrSample1OutL", "trrSample1MixerChannel", "trrSample1InL"
connect "trrSample1Sndwarp", "trrSample1OutR", "trrSample1MixerChannel", "trrSample1InR"

connect "trrSample1MixerChannel", "trrSample1OutL", "Mixer", "MixerInL"
connect "trrSample1MixerChannel", "trrSample1OutR", "Mixer", "MixerInR"

alwayson "trrSample1MixerChannel"

gktrrSample1EqBass init 1
gktrrSample1EqMid init 1
gktrrSample1EqHigh init 1
gktrrSample1Fader init 1
gktrrSample1Pan init 50

instr trrSample1Sndwarp
    kamplitude = p4
    ktimewarp = 120 / 149.5 * .38
    kresample = 30
    ibeginningTime =  0
    ioverlap = 20
    iwindowSize = 10

    SsampleFilePath = "samples/tablasitarloop1.wav"
    iFileNumChannels filenchnls SsampleFilePath
    itrrSample1FileSampleRate filesr SsampleFilePath
    itrrSample1TableLength getTableSizeFromSample SsampleFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

    itrrSample1Table ftgenonce 0, 0, itrrSample1TableLength, 1, SsampleFilePath, 0, 0, 0
    isampleTable = itrrSample1Table

    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    if iFileNumChannels == 2 then
        atrrSample1L, atrrSample1R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iFileNumChannels == 1 then
        atrrSample1L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
        atrrSample1R = atrrSample1L
    endif

    outleta "trrSample1OutL", atrrSample1L
    outleta "trrSample1OutR", atrrSample1R

endin

instr trrSample1BassKnob
    gktrrSample1EqBass linseg p4, p3, p5
endin

instr trrSample1MidKnob
    gktrrSample1EqMid linseg p4, p3, p5
endin

instr trrSample1HighKnob
    gktrrSample1EqHigh linseg p4, p3, p5
endin

instr trrSample1Fader
    gktrrSample1Fader linseg p4, p3, p5
endin

instr trrSample1Pan
    gktrrSample1Pan linseg p4, p3, p5
endin

instr trrSample1MixerChannel
    atrrSample1L inleta "trrSample1InL"
    atrrSample1R inleta "trrSample1InR"

    ktrrSample1Fader = gktrrSample1Fader
    ktrrSample1Pan = gktrrSample1Pan
    ktrrSample1EqBass = gktrrSample1EqBass
    ktrrSample1EqMid = gktrrSample1EqMid
    ktrrSample1EqHigh = gktrrSample1EqHigh

    atrrSample1L, atrrSample1R threeBandEqStereo atrrSample1L, atrrSample1R, ktrrSample1EqBass, ktrrSample1EqMid, ktrrSample1EqHigh

    if ktrrSample1Pan > 100 then
        ktrrSample1Pan = 100
    elseif ktrrSample1Pan < 0 then
        ktrrSample1Pan = 0
    endif

    atrrSample1L = (atrrSample1L * ((100 - ktrrSample1Pan) * 2 / 100)) * ktrrSample1Fader
    atrrSample1R = (atrrSample1R * (ktrrSample1Pan * 2 / 100)) * ktrrSample1Fader


    outleta "trrSample1OutL", atrrSample1L
    outleta "trrSample1OutR", atrrSample1R
endin

