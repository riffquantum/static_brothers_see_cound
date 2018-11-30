/* thinkBreak
    A set of think Break Instruments each using different opcodes for playing and manipulating the sample. This file is meant to serve as an area for experimentation with different opcodes for manipulating drum breaks
    BPM: ~112
*/

connect "thinkBreakDiskin", "thinkBreakOutL", "thinkBreakMixerChannel", "thinkBreakInL"
connect "thinkBreakDiskin", "thinkBreakOutR", "thinkBreakMixerChannel", "thinkBreakInR"

connect "thinkBreakDiskgrain", "thinkBreakOutL", "thinkBreakMixerChannel", "thinkBreakInL"
connect "thinkBreakDiskgrain", "thinkBreakOutR", "thinkBreakMixerChannel", "thinkBreakInR"

connect "thinkBreakSndwarp", "thinkBreakOutL", "thinkBreakMixerChannel", "thinkBreakInL"
connect "thinkBreakSndwarp", "thinkBreakOutR", "thinkBreakMixerChannel", "thinkBreakInR"

connect "thinkBreakMixerChannel", "thinkBreakOutL", "Mixer", "MixerInL"
connect "thinkBreakMixerChannel", "thinkBreakOutR", "Mixer", "MixerInR"
alwayson "thinkBreakMixerChannel"

gkthinkBreakFader init 1
gkthinkBreakPan init 50
gSthinkFilePath init "instruments/thinkBreak/thinkBreak1.wav"


instr thinkBreakDiskin
    iSkipTimeInBeats = p4
    SBreakSegment = p5
    SthinkFilePath sprintfk "instruments/thinkBreak/thinkBreak%s.wav", SBreakSegment
    iFileLength filelen gSthinkFilePath
    iBreakLength = 4

    if (strcmp(SBreakSegment, "1") == 0) then
        ithinkBreakBPM = 114
    elseif (strcmp(SBreakSegment, "2") == 0) then
        ithinkBreakBPM = 114.5
    elseif (strcmp(SBreakSegment, "3") == 0) then
        ithinkBreakBPM = 114
    elseif (strcmp(SBreakSegment, "4") == 0) then
        ithinkBreakBPM = 116
    elseif (strcmp(SBreakSegment, "5") == 0) then
        iBreakLength = 8
        ithinkBreakBPM = 118
    endif

    githinkFactor = giBPM / ithinkBreakBPM
    kpitch = githinkFactor

    iSkipTime = iFileLength / iBreakLength * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    athinkL, athinkR diskin SthinkFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "thinkBreakOutL", athinkL
    outleta "thinkBreakOutR", athinkR

endin

instr thinkBreakDiskgrain

    iTable ftgenonce 0, 0, 8192, 20, 2, 1

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    athinkL, athinkR diskgrain "instruments/thinkBreak/thinkbreak.wav", 1,    10000,     1,  0.0001,     p4, iTable,  1000

    outleta "thinkBreakOutL", athinkL
    outleta "thinkBreakOutR", athinkR

endin

instr thinkBreakSndwarp
    ithinkFileSampleRate filesr gSthinkFilePath
    
    ithinkTableLength getTableSizeFromSample gSthinkFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    ithinkTable ftgenonce 0, 0, ithinkTableLength, 1, "instruments/thinkBreak/thinkbreak.wav", 0, 0, 0

    kxpitch = ithinkFileSampleRate / ithinkFileSampleRate
    ;athink grain 0.1,   kxpitch,     10,     10,       10,         .010, ithinkTable, iTable,    0.01,      1
    
    ;sndwarp arguments
    kamplitude = 1
    ktimewarp = 0.9
    kresample linseg 1, p4, 1000
    isampleTable = ithinkTable
    ibeginningTime = 0
    iwindowSize = 5
    irandw = 0
    ioverlap = 1
    ienvelopeTable = iTable
    itimemode = 0
    athinkL, athinkR sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "thinkBreakOutL", athinkL
    outleta "thinkBreakOutR", athinkR

endin

instr thinkBreakFader
    gkthinkBreakFader linseg p4, p3, p5
endin

instr thinkBreakPan
    gkthinkBreakPan linseg p4, p3, p5
endin

instr thinkBreakMixerChannel
    athinkBreakL inleta "thinkBreakInL"
    athinkBreakR inleta "thinkBreakInR"

    kthinkBreakFader = gkthinkBreakFader
    kthinkBreakPan = gkthinkBreakPan

    if kthinkBreakPan > 100 then
        kthinkBreakPan = 100
    elseif kthinkBreakPan < 0 then
        kthinkBreakPan = 0
    endif

    athinkBreakL = (athinkBreakL * ((100 - kthinkBreakPan) * 2 / 100)) * kthinkBreakFader
    athinkBreakR = (athinkBreakR * (kthinkBreakPan * 2 / 100)) * kthinkBreakFader

    outleta "thinkBreakOutL", athinkBreakL
    outleta "thinkBreakOutR", athinkBreakR
endin

