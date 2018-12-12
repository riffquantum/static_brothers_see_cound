/* trrSample4
    A general purpose wrapper for sampling via diskin opcode.
*/

connect "trrSample4Diskin", "trrSample4OutL", "trrSample4MixerChannel", "trrSample4InL"
connect "trrSample4Diskin", "trrSample4OutR", "trrSample4MixerChannel", "trrSample4InR"

connect "trrSample4Diskgrain", "trrSample4OutL", "trrSample4MixerChannel", "trrSample4InL"
connect "trrSample4Diskgrain", "trrSample4OutR", "trrSample4MixerChannel", "trrSample4InR"

connect "trrSample4Sndwarp", "trrSample4OutL", "trrSample4MixerChannel", "trrSample4InL"
connect "trrSample4Sndwarp", "trrSample4OutR", "trrSample4MixerChannel", "trrSample4InR"

alwayson "trrSample4MixerChannel"

gktrrSample4EqBass init 1
gktrrSample4EqMid init 1
gktrrSample4EqHigh init 1
gktrrSample4Fader init 1
gktrrSample4Pan init 50

instr trrSample4Sndwarp
    kamplitude = p4
    ktimewarp = .02
    kresample = 1
    ibeginningTime =  2
    ioverlap = 20
    iwindowSize = 10

    SsampleFilePath = "samples/tablarasaranga1.wav"
    iFileNumChannels filenchnls SsampleFilePath
    itrrSample4FileSampleRate filesr SsampleFilePath
    itrrSample4TableLength getTableSizeFromSample SsampleFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

    itrrSample4Table ftgenonce 0, 0, itrrSample4TableLength, 1, SsampleFilePath, 0, 0, 0
    isampleTable = itrrSample4Table

    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    if iFileNumChannels == 2 then
        atrrSample4L, atrrSample4R sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iFileNumChannels == 1 then
        atrrSample4L sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
        atrrSample4R = atrrSample4L
    endif

    outleta "trrSample4OutL", atrrSample4L
    outleta "trrSample4OutR", atrrSample4R

endin

instr trrSample4BassKnob
    gktrrSample4EqBass linseg p4, p3, p5
endin

instr trrSample4MidKnob
    gktrrSample4EqMid linseg p4, p3, p5
endin

instr trrSample4HighKnob
    gktrrSample4EqHigh linseg p4, p3, p5
endin

instr trrSample4Fader
    gktrrSample4Fader linseg p4, p3, p5
endin

instr trrSample4Pan
    gktrrSample4Pan linseg p4, p3, p5
endin

instr trrSample4MixerChannel
    atrrSample4L inleta "trrSample4InL"
    atrrSample4R inleta "trrSample4InR"

    ktrrSample4Fader = gktrrSample4Fader
    ktrrSample4Pan = gktrrSample4Pan
    ktrrSample4EqBass = gktrrSample4EqBass
    ktrrSample4EqMid = gktrrSample4EqMid
    ktrrSample4EqHigh = gktrrSample4EqHigh

    atrrSample4L, atrrSample4R threeBandEqStereo atrrSample4L, atrrSample4R, ktrrSample4EqBass, ktrrSample4EqMid, ktrrSample4EqHigh

    if ktrrSample4Pan > 100 then
        ktrrSample4Pan = 100
    elseif ktrrSample4Pan < 0 then
        ktrrSample4Pan = 0
    endif

    atrrSample4L = (atrrSample4L * ((100 - ktrrSample4Pan) * 2 / 100)) * ktrrSample4Fader
    atrrSample4R = (atrrSample4R * (ktrrSample4Pan * 2 / 100)) * ktrrSample4Fader


    outleta "trrSample4OutL", atrrSample4L
    outleta "trrSample4OutR", atrrSample4R
endin

