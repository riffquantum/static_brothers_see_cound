/* gumboBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the long drum and bass break from The Gumbo Variations by Frank Zappa.
    
    Sample Source: The Gumbo Variations - Frank Zappa
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
gSgumboFilePath init "instruments/gumboBreak/gumboBreak.wav"

gigumboBreakBPM init 122.75
gigumboFactor = giBPM / gigumboBreakBPM

gigumboFileLength filelen gSgumboFilePath
gigumboLengthOfBeat = gigumboFileLength / 48


instr gumboBreakDiskin
    kpitch = gigumboFactor
    
    iSkipTimeInBeats = p4
    iSkipTime = gigumboLengthOfBeat * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    agumboL, agumboR diskin gSgumboFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "gumboBreakOutL", agumboL
    outleta "gumboBreakOutR", agumboR

endin

instr gumboBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * gigumboFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gigumboLengthOfBeat * iskipTimeInBeats

    agumboL, agumboR diskgrain gSgumboFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "gumboBreakOutL", agumboL
    outleta "gumboBreakOutR", agumboR

endin

instr gumboBreakSndwarp
    igumboFileSampleRate filesr gSgumboFilePath
    igumboTableLength getTableSizeFromSample gSgumboFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    igumboTable ftgenonce 0, 0, igumboTableLength, 1, gSgumboFilePath, 0, 0, 0

    kamplitude = p4
    ktimewarp = p5 * (1/gigumboFactor)
    kresample = p6
    isampleTable = igumboTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gigumboLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    agumboL, agumboR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "gumboBreakOutL", agumboL
    outleta "gumboBreakOutR", agumboR

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

