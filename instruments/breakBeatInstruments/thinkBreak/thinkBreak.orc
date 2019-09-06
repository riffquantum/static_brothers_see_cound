/* thinkBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Think (About It) by Lyn Collins. This file differs from the other break instruments in that each primary instrument requries you to select a segment. There are five different drum breaks included.

    Sample Source: Think (About It) - Lyn Collins
    BPM: ~112
    Length: 4 or 8 beats
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

gkthinkBreakEqBass init 1
gkthinkBreakEqMid init 1
gkthinkBreakEqHigh init 1
gkthinkBreakFader init 1
gkthinkBreakPan init 50

githinkBreakSegmentBPMs[] fillarray 114, 114.5, 114, 116, 118
githinkBreakSegmentLengths[] fillarray 4, 4, 4, 4, 8

instr thinkBreakDiskin
    iSkipTimeInBeats = p4
    iBreakSegment = p5
    kpitchFactor = p6
    SthinkFilePath sprintfk "instruments/breakBeatInstruments/thinkBreak/thinkBreak%i.wav", iBreakSegment

    athinkL, athinkR breakSamplerDiskin SthinkFilePath, githinkBreakSegmentLengths[iBreakSegment], iSkipTimeInBeats, kpitchFactor

    outleta "thinkBreakOutL", athinkL
    outleta "thinkBreakOutR", athinkR

endin

instr thinkBreakDiskgrain
    iBreakSegment = p8

    SthinkFilePath sprintfk "instruments/breakBeatInstruments/thinkBreak/thinkBreak%i.wav", iBreakSegment
    iFileLength filelen SthinkFilePath
    ithinkBreakBPM = githinkBreakSegmentBPMs[iBreakSegment]
    iBreakLength = githinkBreakSegmentLengths[iBreakSegment]
    ithinkFactor = giBPM / ithinkBreakBPM

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * ithinkFactor
    kpitch = p6
    iskipTimeInBeats = p7

    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iFileLength / iBreakLength * iskipTimeInBeats

    athinkL, athinkR diskgrain SthinkFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "thinkBreakOutL", athinkL
    outleta "thinkBreakOutR", athinkR

endin

instr thinkBreakSndwarp
    iBreakSegment = p9

    SthinkFilePath sprintfk "instruments/breakBeatInstruments/thinkBreak/thinkBreak%i.wav", iBreakSegment
    iFileLength filelen SthinkFilePath
    ithinkBreakBPM = githinkBreakSegmentBPMs[iBreakSegment]
    iBreakLength = githinkBreakSegmentLengths[iBreakSegment]
    ithinkFactor = giBPM / ithinkBreakBPM

    kamplitude = p4
    ktimewarp = p5 * (1/ithinkFactor)
    kresample = p6
    iskipTimeInBeats = p7
    ioverlap = p8

    ithinkFileSampleRate filesr SthinkFilePath
    ithinkTableLength getTableSizeFromSample SthinkFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    ithinkTable ftgenonce 0, 0, ithinkTableLength, 1, SthinkFilePath, 0, 0, 0

    isampleTable = ithinkTable
    ibeginningTime =  iFileLength / iBreakLength * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    athinkL, athinkR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "thinkBreakOutL", athinkL
    outleta "thinkBreakOutR", athinkR

endin

instr thinkBreakBassKnob
    gkthinkBreakEqBass linseg p4, p3, p5
endin

instr thinkBreakMidKnob
    gkthinkBreakEqMid linseg p4, p3, p5
endin

instr thinkBreakHighKnob
    gkthinkBreakEqHigh linseg p4, p3, p5
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
    kthinkBreakEqBass = gkthinkBreakEqBass
    kthinkBreakEqMid = gkthinkBreakEqMid
    kthinkBreakEqHigh = gkthinkBreakEqHigh

    athinkBreakL, athinkBreakR threeBandEqStereo athinkBreakL, athinkBreakR, kthinkBreakEqBass, kthinkBreakEqMid, kthinkBreakEqHigh

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

