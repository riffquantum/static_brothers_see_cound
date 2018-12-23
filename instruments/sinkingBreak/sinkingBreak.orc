/* sinkingBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the intro break from Sinking by The cure. This file differs from the other break instruments in that each primary instrument requries you to select a segment. There are two variations of the sample included.

    Sample Source: Put The Hand In The Hand - Elvis Presley
    BPM: ~112
    Length: 4 or 8 beats
*/

connect "sinkingBreakDiskin", "sinkingBreakOutL", "sinkingBreakMixerChannel", "sinkingBreakInL"
connect "sinkingBreakDiskin", "sinkingBreakOutR", "sinkingBreakMixerChannel", "sinkingBreakInR"

connect "sinkingBreakDiskgrain", "sinkingBreakOutL", "sinkingBreakMixerChannel", "sinkingBreakInL"
connect "sinkingBreakDiskgrain", "sinkingBreakOutR", "sinkingBreakMixerChannel", "sinkingBreakInR"

connect "sinkingBreakSndwarp", "sinkingBreakOutL", "sinkingBreakMixerChannel", "sinkingBreakInL"
connect "sinkingBreakSndwarp", "sinkingBreakOutR", "sinkingBreakMixerChannel", "sinkingBreakInR"

alwayson "sinkingBreakMixerChannel"

gksinkingBreakEqBass init 1
gksinkingBreakEqMid init 1
gksinkingBreakEqHigh init 1
gksinkingBreakFader init 1
gksinkingBreakPan init 50

gisinkingBreakSegmentBPMs[] fillarray 72, 72
gisinkingBreakSegmentLengths[] fillarray 8, 4

instr sinkingBreakDiskin
    iSkipTimeInBeats = p4
    iBreakSegment = p5
    SsinkingFilePath sprintfk "instruments/sinkingBreak/sinkingBreak%i.wav", iBreakSegment

    iFileLength filelen SsinkingFilePath
    isinkingBreakBPM = gisinkingBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gisinkingBreakSegmentLengths[iBreakSegment]


    isinkingFactor = giBPM / isinkingBreakBPM
    kpitch = isinkingFactor

    iSkipTime = iFileLength / iBreakLength * iSkipTimeInBeats

    iwraparound= 1
    iformat = 0
    iskipinit = 0

    asinkingL, asinkingR diskin SsinkingFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "sinkingBreakOutL", asinkingL
    outleta "sinkingBreakOutR", asinkingR

endin

instr sinkingBreakDiskgrain
    iBreakSegment = p8

    SsinkingFilePath sprintfk "instruments/sinkingBreak/sinkingBreak%i.wav", iBreakSegment
    iFileLength filelen SsinkingFilePath
    isinkingBreakBPM = gisinkingBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gisinkingBreakSegmentLengths[iBreakSegment]
    isinkingFactor = giBPM / isinkingBreakBPM

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * isinkingFactor
    kpitch = p6
    iskipTimeInBeats = p7

    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iFileLength / iBreakLength * iskipTimeInBeats

    asinkingL, asinkingR diskgrain SsinkingFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "sinkingBreakOutL", asinkingL
    outleta "sinkingBreakOutR", asinkingR

endin

instr sinkingBreakSndwarp
    iBreakSegment = p9

    SsinkingFilePath sprintfk "instruments/sinkingBreak/sinkingBreak%i.wav", iBreakSegment
    iFileLength filelen SsinkingFilePath
    isinkingBreakBPM = gisinkingBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gisinkingBreakSegmentLengths[iBreakSegment]
    isinkingFactor = giBPM / isinkingBreakBPM

    kamplitude = p4
    ktimewarp = p5 * (1/isinkingFactor)
    kresample = p6
    iskipTimeInBeats = p7
    ioverlap = p8

    isinkingFileSampleRate filesr SsinkingFilePath
    isinkingTableLength getTableSizeFromSample SsinkingFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    isinkingTable ftgenonce 0, 0, isinkingTableLength, 1, SsinkingFilePath, 0, 0, 0

    isampleTable = isinkingTable
    ibeginningTime =  iFileLength / iBreakLength * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    asinkingL, asinkingR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "sinkingBreakOutL", asinkingL
    outleta "sinkingBreakOutR", asinkingR

endin

instr sinkingBreakBassKnob
    gksinkingBreakEqBass linseg p4, p3, p5
endin

instr sinkingBreakMidKnob
    gksinkingBreakEqMid linseg p4, p3, p5
endin

instr sinkingBreakHighKnob
    gksinkingBreakEqHigh linseg p4, p3, p5
endin

instr sinkingBreakFader
    gksinkingBreakFader linseg p4, p3, p5
endin

instr sinkingBreakPan
    gksinkingBreakPan linseg p4, p3, p5
endin

instr sinkingBreakMixerChannel
    asinkingBreakL inleta "sinkingBreakInL"
    asinkingBreakR inleta "sinkingBreakInR"

    ksinkingBreakFader = gksinkingBreakFader
    ksinkingBreakPan = gksinkingBreakPan
    ksinkingBreakEqBass = gksinkingBreakEqBass
    ksinkingBreakEqMid = gksinkingBreakEqMid
    ksinkingBreakEqHigh = gksinkingBreakEqHigh

    asinkingBreakL, asinkingBreakR threeBandEqStereo asinkingBreakL, asinkingBreakR, ksinkingBreakEqBass, ksinkingBreakEqMid, ksinkingBreakEqHigh

    if ksinkingBreakPan > 100 then
        ksinkingBreakPan = 100
    elseif ksinkingBreakPan < 0 then
        ksinkingBreakPan = 0
    endif

    asinkingBreakL = (asinkingBreakL * ((100 - ksinkingBreakPan) * 2 / 100)) * ksinkingBreakFader
    asinkingBreakR = (asinkingBreakR * (ksinkingBreakPan * 2 / 100)) * ksinkingBreakFader

    outleta "sinkingBreakOutL", asinkingBreakL
    outleta "sinkingBreakOutR", asinkingBreakR
endin

