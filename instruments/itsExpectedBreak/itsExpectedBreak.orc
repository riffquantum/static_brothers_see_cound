/* itsExpectedBreak
    A set of itsExpected Break Instruments each using different opcodes for playing and manipulating the sample. This file is meant to serve as an area for experimentation with different opcodes for manipulating drum breaks
*/

connect "itsExpectedBreakDiskin", "itsExpectedBreakOutL", "itsExpectedBreakMixerChannel", "itsExpectedBreakInL"
connect "itsExpectedBreakDiskin", "itsExpectedBreakOutR", "itsExpectedBreakMixerChannel", "itsExpectedBreakInR"

connect "itsExpectedBreakDiskgrain", "itsExpectedBreakOutL", "itsExpectedBreakMixerChannel", "itsExpectedBreakInL"
connect "itsExpectedBreakDiskgrain", "itsExpectedBreakOutR", "itsExpectedBreakMixerChannel", "itsExpectedBreakInR"

connect "itsExpectedBreakSndwarp", "itsExpectedBreakOutL", "itsExpectedBreakMixerChannel", "itsExpectedBreakInL"
connect "itsExpectedBreakSndwarp", "itsExpectedBreakOutR", "itsExpectedBreakMixerChannel", "itsExpectedBreakInR"

connect "itsExpectedBreakMixerChannel", "itsExpectedBreakOutL", "Mixer", "MixerInL"
connect "itsExpectedBreakMixerChannel", "itsExpectedBreakOutR", "Mixer", "MixerInR"
alwayson "itsExpectedBreakMixerChannel"

gkitsExpectedBreakFader init 1
gkitsExpectedBreakPan init 50
gSitsExpectedFilePath init "instruments/itsExpectedBreak/itsExpectedbreak.wav"

giitsExpectedBreakBPM init 87.25

instr itsExpectedBPMsetter
    ;this does not work. Why?
    iMultiplier = p4
    iitsExpectedLength filelen gSitsExpectedFilePath
    iitsExpectedBPM = (60 / (iitsExpectedLength / 16)) * iMultiplier
    SScoreStatement sprintf {{t 0 %i}}, iitsExpectedBPM
    kTrigger metro 1

    scoreline SScoreStatement, kTrigger
endin

instr itsExpectedBreakDiskin
    kpitch = p4
    
    iSkipTimeInBeats = p5
    iFileLength filelen gSitsExpectedFilePath
    iSkipTime = iFileLength / 16 * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aitsExpectedL, aitsExpectedR diskin "instruments/itsExpectedBreak/itsExpectedbreak.wav", kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "itsExpectedBreakOutL", aitsExpectedL
    outleta "itsExpectedBreakOutR", aitsExpectedR

endin

instr itsExpectedBreakDiskgrain

    iTable ftgenonce 0, 0, 8192, 20, 2, 1

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aitsExpectedL, aitsExpectedR diskgrain "instruments/itsExpectedBreak/itsExpectedbreak.wav", 1,    10000,     1,  0.0001,     p4, iTable,  1000

    outleta "itsExpectedBreakOutL", aitsExpectedL
    outleta "itsExpectedBreakOutR", aitsExpectedR

endin

instr itsExpectedBreakSndwarp
    iitsExpectedFileSampleRate filesr gSitsExpectedFilePath
    
    iitsExpectedTableLength getTableSizeFromSample gSitsExpectedFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iitsExpectedTable ftgenonce 0, 0, iitsExpectedTableLength, 1, "instruments/itsExpectedBreak/itsExpectedbreak.wav", 0, 0, 0

    kxpitch = iitsExpectedFileSampleRate / iitsExpectedFileSampleRate
    ;aitsExpected grain 0.1,   kxpitch,     10,     10,       10,         .010, iitsExpectedTable, iTable,    0.01,      1
    
    ;sndwarp arguments
    kamplitude = 1
    ktimewarp = 0.9
    kresample linseg 1, p4, 1000
    isampleTable = iitsExpectedTable
    ibeginningTime = 0
    iwindowSize = 5
    irandw = 0
    ioverlap = 1
    ienvelopeTable = iTable
    itimemode = 0
    aitsExpectedL, aitsExpectedR sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "itsExpectedBreakOutL", aitsExpectedL
    outleta "itsExpectedBreakOutR", aitsExpectedR

endin

instr itsExpectedBreakFader
    gkitsExpectedBreakFader linseg p4, p3, p5
endin

instr itsExpectedBreakPan
    gkitsExpectedBreakPan linseg p4, p3, p5
endin

instr itsExpectedBreakMixerChannel
    aitsExpectedBreakL inleta "itsExpectedBreakInL"
    aitsExpectedBreakR inleta "itsExpectedBreakInR"

    kitsExpectedBreakFader = gkitsExpectedBreakFader
    kitsExpectedBreakPan = gkitsExpectedBreakPan

    if kitsExpectedBreakPan > 100 then
        kitsExpectedBreakPan = 100
    elseif kitsExpectedBreakPan < 0 then
        kitsExpectedBreakPan = 0
    endif

    aitsExpectedBreakL = (aitsExpectedBreakL * ((100 - kitsExpectedBreakPan) * 2 / 100)) * kitsExpectedBreakFader
    aitsExpectedBreakR = (aitsExpectedBreakR * (kitsExpectedBreakPan * 2 / 100)) * kitsExpectedBreakFader

    outleta "itsExpectedBreakOutL", aitsExpectedBreakL
    outleta "itsExpectedBreakOutR", aitsExpectedBreakR
endin

