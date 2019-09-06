/* gettinHappyBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Getting Happy by Dolly Parton. This file differs from the other break instruments in that each primary instrument requries you to select a segment. There are five different drum breaks included.

    Sample Source: Gettin' Happy - Dolly Parton
    BPM: ~112
    Length: 4 or 8 beats
*/

connect "gettinHappyBreakDiskin", "gettinHappyBreakOutL", "gettinHappyBreakMixerChannel", "gettinHappyBreakInL"
connect "gettinHappyBreakDiskin", "gettinHappyBreakOutR", "gettinHappyBreakMixerChannel", "gettinHappyBreakInR"

connect "gettinHappyBreakDiskgrain", "gettinHappyBreakOutL", "gettinHappyBreakMixerChannel", "gettinHappyBreakInL"
connect "gettinHappyBreakDiskgrain", "gettinHappyBreakOutR", "gettinHappyBreakMixerChannel", "gettinHappyBreakInR"

connect "gettinHappyBreakSndwarp", "gettinHappyBreakOutL", "gettinHappyBreakMixerChannel", "gettinHappyBreakInL"
connect "gettinHappyBreakSndwarp", "gettinHappyBreakOutR", "gettinHappyBreakMixerChannel", "gettinHappyBreakInR"

connect "gettinHappyBreakMixerChannel", "gettinHappyBreakOutL", "Mixer", "MixerInL"
connect "gettinHappyBreakMixerChannel", "gettinHappyBreakOutR", "Mixer", "MixerInR"

alwayson "gettinHappyBreakMixerChannel"

gkgettinHappyBreakEqBass init 1
gkgettinHappyBreakEqMid init 1
gkgettinHappyBreakEqHigh init 1
gkgettinHappyBreakFader init 1
gkgettinHappyBreakPan init 50

gigettinHappyBreakSegmentBPMs[] fillarray 126.5, 123.25
gigettinHappyBreakSegmentLengths[] fillarray 16, 8

instr gettinHappyBreakDiskin
    iSkipTimeInBeats = p4
    iBreakSegment = p5
    kpitchFactor = p6
    SgettinHappyFilePath sprintfk "instruments/breakBeatInstruments/gettinHappyBreak/gettinHappyBreak%i.wav", iBreakSegment

    agettinHappyL, agettinHappyR breakSamplerDiskin SgettinHappyFilePath, gigettinHappyBreakSegmentLengths[iBreakSegment], iSkipTimeInBeats, kpitchFactor

    outleta "gettinHappyBreakOutL", agettinHappyL
    outleta "gettinHappyBreakOutR", agettinHappyR

endin

instr gettinHappyBreakDiskgrain
    iBreakSegment = p8

    SgettinHappyFilePath sprintfk "instruments/breakBeatInstruments/gettinHappyBreak/gettinHappyBreak%i.wav", iBreakSegment
    iFileLength filelen SgettinHappyFilePath
    igettinHappyBreakBPM = gigettinHappyBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gigettinHappyBreakSegmentLengths[iBreakSegment]
    igettinHappyFactor = giBPM / igettinHappyBreakBPM

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * igettinHappyFactor
    kpitch = p6
    iskipTimeInBeats = p7

    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iFileLength / iBreakLength * iskipTimeInBeats

    agettinHappyL, agettinHappyR diskgrain SgettinHappyFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "gettinHappyBreakOutL", agettinHappyL
    outleta "gettinHappyBreakOutR", agettinHappyR

endin

instr gettinHappyBreakSndwarp
    iBreakSegment = p9

    SgettinHappyFilePath sprintfk "instruments/breakBeatInstruments/gettinHappyBreak/gettinHappyBreak%i.wav", iBreakSegment
    iFileLength filelen SgettinHappyFilePath
    igettinHappyBreakBPM = gigettinHappyBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gigettinHappyBreakSegmentLengths[iBreakSegment]
    igettinHappyFactor = giBPM / igettinHappyBreakBPM

    kamplitude = p4
    ktimewarp = p5 * (1/igettinHappyFactor)
    kresample = p6
    iskipTimeInBeats = p7
    ioverlap = p8

    igettinHappyFileSampleRate filesr SgettinHappyFilePath
    igettinHappyTableLength getTableSizeFromSample SgettinHappyFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    igettinHappyTable ftgenonce 0, 0, igettinHappyTableLength, 1, SgettinHappyFilePath, 0, 0, 0

    isampleTable = igettinHappyTable
    ibeginningTime =  iFileLength / iBreakLength * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    agettinHappyL, agettinHappyR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "gettinHappyBreakOutL", agettinHappyL
    outleta "gettinHappyBreakOutR", agettinHappyR

endin

instr gettinHappyBreakBassKnob
    gkgettinHappyBreakEqBass linseg p4, p3, p5
endin

instr gettinHappyBreakMidKnob
    gkgettinHappyBreakEqMid linseg p4, p3, p5
endin

instr gettinHappyBreakHighKnob
    gkgettinHappyBreakEqHigh linseg p4, p3, p5
endin

instr gettinHappyBreakFader
    gkgettinHappyBreakFader linseg p4, p3, p5
endin

instr gettinHappyBreakPan
    gkgettinHappyBreakPan linseg p4, p3, p5
endin

instr gettinHappyBreakMixerChannel
    agettinHappyBreakL inleta "gettinHappyBreakInL"
    agettinHappyBreakR inleta "gettinHappyBreakInR"

    kgettinHappyBreakFader = gkgettinHappyBreakFader
    kgettinHappyBreakPan = gkgettinHappyBreakPan
    kgettinHappyBreakEqBass = gkgettinHappyBreakEqBass
    kgettinHappyBreakEqMid = gkgettinHappyBreakEqMid
    kgettinHappyBreakEqHigh = gkgettinHappyBreakEqHigh

    agettinHappyBreakL, agettinHappyBreakR threeBandEqStereo agettinHappyBreakL, agettinHappyBreakR, kgettinHappyBreakEqBass, kgettinHappyBreakEqMid, kgettinHappyBreakEqHigh

    if kgettinHappyBreakPan > 100 then
        kgettinHappyBreakPan = 100
    elseif kgettinHappyBreakPan < 0 then
        kgettinHappyBreakPan = 0
    endif

    agettinHappyBreakL = (agettinHappyBreakL * ((100 - kgettinHappyBreakPan) * 2 / 100)) * kgettinHappyBreakFader
    agettinHappyBreakR = (agettinHappyBreakR * (kgettinHappyBreakPan * 2 / 100)) * kgettinHappyBreakFader

    outleta "gettinHappyBreakOutL", agettinHappyBreakL
    outleta "gettinHappyBreakOutR", agettinHappyBreakR
endin

