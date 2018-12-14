/* santanaSample2 */


connect "santanaSample2Sndwarp", "santanaSample2OutL", "santanaSample2MixerChannel", "santanaSample2InL"
connect "santanaSample2Sndwarp", "santanaSample2OutR", "santanaSample2MixerChannel", "santanaSample2InR"

alwayson "santanaSample2MixerChannel"

gksantanaSample2EqBass init 1
gksantanaSample2EqMid init 1
gksantanaSample2EqHigh init 1
gksantanaSample2Fader init 1
gksantanaSample2Pan init 50

instr santanaSample2Sndwarp
    kamplitude = p4
    ktimewarp = (giBPM)/112 * 2
    kresample = 1
    ibeginningTime =  .41
    ioverlap = 20
    iwindowSize = 10


    SsampleFilePath = "samples/santanaGuitarLick2.wav"
    iFileNumChannels filenchnls SsampleFilePath
    isantanaSample2FileSampleRate filesr SsampleFilePath
    isantanaSample2TableLength getTableSizeFromSample SsampleFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

    isantanaSample2Table ftgenonce 0, 0, isantanaSample2TableLength, 1, SsampleFilePath, 0, 0, 0
    isampleTable = isantanaSample2Table

    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    if iFileNumChannels == 2 then
        asantanaSample2L, asantanaSample2R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iFileNumChannels == 1 then
        asantanaSample2L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
        asantanaSample2R = asantanaSample2L
    endif

    outleta "santanaSample2OutL", asantanaSample2L
    outleta "santanaSample2OutR", asantanaSample2R

endin

instr santanaSample2BassKnob
    gksantanaSample2EqBass linseg p4, p3, p5
endin

instr santanaSample2MidKnob
    gksantanaSample2EqMid linseg p4, p3, p5
endin

instr santanaSample2HighKnob
    gksantanaSample2EqHigh linseg p4, p3, p5
endin

instr santanaSample2Fader
    gksantanaSample2Fader linseg p4, p3, p5
endin

instr santanaSample2Pan
    gksantanaSample2Pan linseg p4, p3, p5
endin

instr santanaSample2MixerChannel
    asantanaSample2L inleta "santanaSample2InL"
    asantanaSample2R inleta "santanaSample2InR"

    ksantanaSample2Fader = gksantanaSample2Fader
    ksantanaSample2Pan = gksantanaSample2Pan
    ksantanaSample2EqBass = gksantanaSample2EqBass
    ksantanaSample2EqMid = gksantanaSample2EqMid
    ksantanaSample2EqHigh = gksantanaSample2EqHigh

    asantanaSample2L, asantanaSample2R threeBandEqStereo asantanaSample2L, asantanaSample2R, ksantanaSample2EqBass, ksantanaSample2EqMid, ksantanaSample2EqHigh

    if ksantanaSample2Pan > 100 then
        ksantanaSample2Pan = 100
    elseif ksantanaSample2Pan < 0 then
        ksantanaSample2Pan = 0
    endif

    asantanaSample2L = (asantanaSample2L * ((100 - ksantanaSample2Pan) * 2 / 100)) * ksantanaSample2Fader
    asantanaSample2R = (asantanaSample2R * (ksantanaSample2Pan * 2 / 100)) * ksantanaSample2Fader


    outleta "santanaSample2OutL", asantanaSample2L
    outleta "santanaSample2OutR", asantanaSample2R
endin

