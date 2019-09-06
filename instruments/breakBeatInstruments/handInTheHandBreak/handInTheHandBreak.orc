/* handInTheHandBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum breaks from Put The Hand In The Hand. IOt includes the version by Elvis Presley as well as Anne Murray's. This file differs from the other break instruments in that each primary instrument requries you to select a segment. There are two different drum breaks included.

    Sample Source: Put The Hand In The Hand - Elvis Presley / Anne Murray
    BPM: ~112
    Length: 4 or 8 beats
*/

connect "handInTheHandBreakDiskin", "handInTheHandBreakOutL", "handInTheHandBreakMixerChannel", "handInTheHandBreakInL"
connect "handInTheHandBreakDiskin", "handInTheHandBreakOutR", "handInTheHandBreakMixerChannel", "handInTheHandBreakInR"

connect "handInTheHandBreakDiskgrain", "handInTheHandBreakOutL", "handInTheHandBreakMixerChannel", "handInTheHandBreakInL"
connect "handInTheHandBreakDiskgrain", "handInTheHandBreakOutR", "handInTheHandBreakMixerChannel", "handInTheHandBreakInR"

connect "handInTheHandBreakSndwarp", "handInTheHandBreakOutL", "handInTheHandBreakMixerChannel", "handInTheHandBreakInL"
connect "handInTheHandBreakSndwarp", "handInTheHandBreakOutR", "handInTheHandBreakMixerChannel", "handInTheHandBreakInR"

connect "handInTheHandBreakMixerChannel", "handInTheHandBreakOutL", "Mixer", "MixerInL"
connect "handInTheHandBreakMixerChannel", "handInTheHandBreakOutR", "Mixer", "MixerInR"

alwayson "handInTheHandBreakMixerChannel"

gkhandInTheHandBreakEqBass init 1
gkhandInTheHandBreakEqMid init 1
gkhandInTheHandBreakEqHigh init 1
gkhandInTheHandBreakFader init 1
gkhandInTheHandBreakPan init 50

gihandInTheHandBreakSegmentBPMs[] fillarray 78, 80, 80
gihandInTheHandBreakSegmentLengths[] fillarray 4, 8, 8

instr handInTheHandBreakDiskin
    iSkipTimeInBeats = p4
    iBreakSegment = p5
    kpitchFactor = p6
    ShandInTheHandFilePath sprintfk "instruments/breakBeatInstruments/handInTheHandBreak/handInTheHandBreak%i.wav", iBreakSegment

    ahandInTheHandL, ahandInTheHandR breakSamplerDiskin ShandInTheHandFilePath, gihandInTheHandBreakSegmentLengths[iBreakSegment], iSkipTimeInBeats, kpitchFactor

    outleta "handInTheHandBreakOutL", ahandInTheHandL
    outleta "handInTheHandBreakOutR", ahandInTheHandR
endin

instr handInTheHandBreakDiskgrain
    iBreakSegment = p8

    ShandInTheHandFilePath sprintfk "instruments/breakBeatInstruments/handInTheHandBreak/handInTheHandBreak%i.wav", iBreakSegment
    iFileLength filelen ShandInTheHandFilePath
    ihandInTheHandBreakBPM = gihandInTheHandBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gihandInTheHandBreakSegmentLengths[iBreakSegment]
    ihandInTheHandFactor = giBPM / ihandInTheHandBreakBPM

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * ihandInTheHandFactor
    kpitch = p6
    iskipTimeInBeats = p7

    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iFileLength / iBreakLength * iskipTimeInBeats

    ahandInTheHandL, ahandInTheHandR diskgrain ShandInTheHandFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "handInTheHandBreakOutL", ahandInTheHandL
    outleta "handInTheHandBreakOutR", ahandInTheHandR

endin

instr handInTheHandBreakSndwarp
    iBreakSegment = p9

    ShandInTheHandFilePath sprintfk "instruments/breakBeatInstruments/handInTheHandBreak/handInTheHandBreak%i.wav", iBreakSegment
    iFileLength filelen ShandInTheHandFilePath
    ihandInTheHandBreakBPM = gihandInTheHandBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gihandInTheHandBreakSegmentLengths[iBreakSegment]
    ihandInTheHandFactor = giBPM / ihandInTheHandBreakBPM

    kamplitude = p4
    ktimewarp = p5 * (1/ihandInTheHandFactor)
    kresample = p6
    iskipTimeInBeats = p7
    ioverlap = p8

    ihandInTheHandFileSampleRate filesr ShandInTheHandFilePath
    ihandInTheHandTableLength getTableSizeFromSample ShandInTheHandFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    ihandInTheHandTable ftgenonce 0, 0, ihandInTheHandTableLength, 1, ShandInTheHandFilePath, 0, 0, 0

    isampleTable = ihandInTheHandTable
    ibeginningTime =  iFileLength / iBreakLength * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    ahandInTheHandL, ahandInTheHandR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "handInTheHandBreakOutL", ahandInTheHandL
    outleta "handInTheHandBreakOutR", ahandInTheHandR

endin

instr handInTheHandBreakBassKnob
    gkhandInTheHandBreakEqBass linseg p4, p3, p5
endin

instr handInTheHandBreakMidKnob
    gkhandInTheHandBreakEqMid linseg p4, p3, p5
endin

instr handInTheHandBreakHighKnob
    gkhandInTheHandBreakEqHigh linseg p4, p3, p5
endin

instr handInTheHandBreakFader
    gkhandInTheHandBreakFader linseg p4, p3, p5
endin

instr handInTheHandBreakPan
    gkhandInTheHandBreakPan linseg p4, p3, p5
endin

instr handInTheHandBreakMixerChannel
    ahandInTheHandBreakL inleta "handInTheHandBreakInL"
    ahandInTheHandBreakR inleta "handInTheHandBreakInR"

    khandInTheHandBreakFader = gkhandInTheHandBreakFader
    khandInTheHandBreakPan = gkhandInTheHandBreakPan
    khandInTheHandBreakEqBass = gkhandInTheHandBreakEqBass
    khandInTheHandBreakEqMid = gkhandInTheHandBreakEqMid
    khandInTheHandBreakEqHigh = gkhandInTheHandBreakEqHigh

    ahandInTheHandBreakL, ahandInTheHandBreakR threeBandEqStereo ahandInTheHandBreakL, ahandInTheHandBreakR, khandInTheHandBreakEqBass, khandInTheHandBreakEqMid, khandInTheHandBreakEqHigh

    if khandInTheHandBreakPan > 100 then
        khandInTheHandBreakPan = 100
    elseif khandInTheHandBreakPan < 0 then
        khandInTheHandBreakPan = 0
    endif

    ahandInTheHandBreakL = (ahandInTheHandBreakL * ((100 - khandInTheHandBreakPan) * 2 / 100)) * khandInTheHandBreakFader
    ahandInTheHandBreakR = (ahandInTheHandBreakR * (khandInTheHandBreakPan * 2 / 100)) * khandInTheHandBreakFader

    outleta "handInTheHandBreakOutL", ahandInTheHandBreakL
    outleta "handInTheHandBreakOutR", ahandInTheHandBreakR
endin

