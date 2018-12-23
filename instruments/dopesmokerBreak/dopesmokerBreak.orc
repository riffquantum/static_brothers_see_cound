/* dopesmokerBreak
    A set of sampling instruments each using different opcodes for playing and manipulating a section of drums break from Dopesmoker by Sleep.

    Sample Source: Dopesmoker - Sleep
    BPM: ~101
    Length: 36 beats
*/

connect "dopesmokerBreakDiskin", "dopesmokerBreakOutL", "dopesmokerBreakMixerChannel", "dopesmokerBreakInL"
connect "dopesmokerBreakDiskin", "dopesmokerBreakOutR", "dopesmokerBreakMixerChannel", "dopesmokerBreakInR"

connect "dopesmokerBreakDiskgrain", "dopesmokerBreakOutL", "dopesmokerBreakMixerChannel", "dopesmokerBreakInL"
connect "dopesmokerBreakDiskgrain", "dopesmokerBreakOutR", "dopesmokerBreakMixerChannel", "dopesmokerBreakInR"

connect "dopesmokerBreakSndwarp", "dopesmokerBreakOutL", "dopesmokerBreakMixerChannel", "dopesmokerBreakInL"
connect "dopesmokerBreakSndwarp", "dopesmokerBreakOutR", "dopesmokerBreakMixerChannel", "dopesmokerBreakInR"

alwayson "dopesmokerBreakMixerChannel"

gkdopesmokerBreakEqBass init 1
gkdopesmokerBreakEqMid init 1
gkdopesmokerBreakEqHigh init 1
gkdopesmokerBreakFader init 1
gkdopesmokerBreakPan init 50
gSdopesmokerFilePath init "instruments/dopesmokerBreak/dopesmokerBreak.wav"

gidopesmokerBreakBPM init 101

gidopesmokerFileLength filelen gSdopesmokerFilePath
gidopesmokerLengthOfBeat = gidopesmokerFileLength / 36


instr dopesmokerBreakDiskin
    idopesmokerFactor = giBPM / gidopesmokerBreakBPM
    kpitch = idopesmokerFactor

    iSkipTimeInBeats = p4
    iSkipTime = gidopesmokerLengthOfBeat * iSkipTimeInBeats

    iwraparound= 1
    iformat = 0
    iskipinit = 0

    adopesmokerL, adopesmokerR diskin gSdopesmokerFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "dopesmokerBreakOutL", adopesmokerL
    outleta "dopesmokerBreakOutR", adopesmokerR

endin

instr dopesmokerBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    idopesmokerFactor = giBPM / gidopesmokerBreakBPM
    iTimeFactor = p5 * idopesmokerFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gidopesmokerLengthOfBeat * iskipTimeInBeats

    adopesmokerL, adopesmokerR diskgrain gSdopesmokerFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "dopesmokerBreakOutL", adopesmokerL
    outleta "dopesmokerBreakOutR", adopesmokerR

endin

instr dopesmokerBreakSndwarp
    idopesmokerFileSampleRate filesr gSdopesmokerFilePath
    idopesmokerTableLength getTableSizeFromSample gSdopesmokerFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    idopesmokerTable ftgenonce 0, 0, idopesmokerTableLength, 1, gSdopesmokerFilePath, 0, 0, 0

    kamplitude = p4
    idopesmokerFactor = giBPM / gidopesmokerBreakBPM
    ktimewarp = p5 * (1/idopesmokerFactor)
    kresample = p6
    isampleTable = idopesmokerTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gidopesmokerLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    adopesmokerL, adopesmokerR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "dopesmokerBreakOutL", adopesmokerL
    outleta "dopesmokerBreakOutR", adopesmokerR

endin

instr dopesmokerBreakBassKnob
    gkdopesmokerBreakEqBass linseg p4, p3, p5
endin

instr dopesmokerBreakMidKnob
    gkdopesmokerBreakEqMid linseg p4, p3, p5
endin

instr dopesmokerBreakHighKnob
    gkdopesmokerBreakEqHigh linseg p4, p3, p5
endin

instr dopesmokerBreakFader
    gkdopesmokerBreakFader linseg p4, p3, p5
endin

instr dopesmokerBreakPan
    gkdopesmokerBreakPan linseg p4, p3, p5
endin

instr dopesmokerBreakMixerChannel
    adopesmokerBreakL inleta "dopesmokerBreakInL"
    adopesmokerBreakR inleta "dopesmokerBreakInR"

    kdopesmokerBreakFader = gkdopesmokerBreakFader
    kdopesmokerBreakPan = gkdopesmokerBreakPan
    kdopesmokerBreakEqBass = gkdopesmokerBreakEqBass
    kdopesmokerBreakEqMid = gkdopesmokerBreakEqMid
    kdopesmokerBreakEqHigh = gkdopesmokerBreakEqHigh

    adopesmokerBreakL, adopesmokerBreakR threeBandEqStereo adopesmokerBreakL, adopesmokerBreakR, kdopesmokerBreakEqBass, kdopesmokerBreakEqMid, kdopesmokerBreakEqHigh

    if kdopesmokerBreakPan > 100 then
        kdopesmokerBreakPan = 100
    elseif kdopesmokerBreakPan < 0 then
        kdopesmokerBreakPan = 0
    endif

    adopesmokerBreakL = (adopesmokerBreakL * ((100 - kdopesmokerBreakPan) * 2 / 100)) * kdopesmokerBreakFader
    adopesmokerBreakR = (adopesmokerBreakR * (kdopesmokerBreakPan * 2 / 100)) * kdopesmokerBreakFader

    outleta "dopesmokerBreakOutL", adopesmokerBreakL
    outleta "dopesmokerBreakOutR", adopesmokerBreakR
endin

