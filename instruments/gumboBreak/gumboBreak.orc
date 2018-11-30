/* gumboBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the long drum and bass break from The Gumbo Variations by Frank Zappa. This file is meant to serve as an area for experimentation with different opcodes for manipulating drum breaks
    BPM: ~122.75
    Length: 48 beats
*/

connect "gumboBreakDiskin", "gumboBreakOutL", "gumboBreakMixerChannel", "gumboBreakInL"
connect "gumboBreakDiskin", "gumboBreakOutR", "gumboBreakMixerChannel", "gumboBreakInR"

connect "gumboBreakDiskgrain", "gumboBreakOutL", "gumboBreakMixerChannel", "gumboBreakInL"
connect "gumboBreakDiskgrain", "gumboBreakOutR", "gumboBreakMixerChannel", "gumboBreakInR"

connect "gumboBreakSndwarp", "gumboBreakOutL", "gumboBreakMixerChannel", "gumboBreakInL"
connect "gumboBreakSndwarp", "gumboBreakOutR", "gumboBreakMixerChannel", "gumboBreakInR"

connect "gumboBreakMixerChannel", "gumboBreakOutL", "Mixer", "MixerInL"
connect "gumboBreakMixerChannel", "gumboBreakOutR", "Mixer", "MixerInR"
alwayson "gumboBreakMixerChannel"

gkgumboBreakFader init 1
gkgumboBreakPan init 50
gSitsExpectedFilePath init "instruments/gumboBreak/gumboBreak.wav"

gigumboBreakBPM init 122.75
giGumboFactor = giBPM / gigumboBreakBPM

instr itsExpectedBPMsetter
    ;this does not work. Why?
    iMultiplier = p4
    iitsExpectedLength filelen gSitsExpectedFilePath
    iitsExpectedBPM = (123 / (iitsExpectedLength / 16)) * iMultiplier
    SScoreStatement sprintf {{t 0 %i}}, iitsExpectedBPM
    kTrigger metro 1

    scoreline SScoreStatement, kTrigger
endin

instr gumboBreakDiskin
    kpitch = giGumboFactor
    
    iSkipTimeInBeats = p4
    iFileLength filelen gSitsExpectedFilePath
    iSkipTime = iFileLength / 48 * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aitsExpectedL, aitsExpectedR diskin "instruments/gumboBreak/gumboBreak.wav", kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "gumboBreakOutL", aitsExpectedL
    outleta "gumboBreakOutR", aitsExpectedR

endin

instr gumboBreakDiskgrain

    iTable ftgenonce 0, 0, 8192, 20, 2, 1

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aitsExpectedL, aitsExpectedR diskgrain "instruments/gumboBreak/gumboBreak.wav", 1,    10000,     1,  0.0001,     p4, iTable,  1000

    outleta "gumboBreakOutL", aitsExpectedL
    outleta "gumboBreakOutR", aitsExpectedR

endin

instr gumboBreakSndwarp
    iitsExpectedFileSampleRate filesr gSitsExpectedFilePath
    
    iitsExpectedTableLength getTableSizeFromSample gSitsExpectedFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iitsExpectedTable ftgenonce 0, 0, iitsExpectedTableLength, 1, "instruments/gumboBreak/gumboBreak.wav", 0, 0, 0

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

    outleta "gumboBreakOutL", aitsExpectedL
    outleta "gumboBreakOutR", aitsExpectedR

endin

instr gumboBreakFader
    gkgumboBreakFader linseg p4, p3, p5
endin

instr gumboBreakPan
    gkgumboBreakPan linseg p4, p3, p5
endin

instr gumboBreakMixerChannel
    agumboBreakL inleta "gumboBreakInL"
    agumboBreakR inleta "gumboBreakInR"

    kgumboBreakFader = gkgumboBreakFader
    kgumboBreakPan = gkgumboBreakPan

    if kgumboBreakPan > 100 then
        kgumboBreakPan = 100
    elseif kgumboBreakPan < 0 then
        kgumboBreakPan = 0
    endif

    agumboBreakL = (agumboBreakL * ((100 - kgumboBreakPan) * 2 / 100)) * kgumboBreakFader
    agumboBreakR = (agumboBreakR * (kgumboBreakPan * 2 / 100)) * kgumboBreakFader

    outleta "gumboBreakOutL", agumboBreakL
    outleta "gumboBreakOutR", agumboBreakR
endin

