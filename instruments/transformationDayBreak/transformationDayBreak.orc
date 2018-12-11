/* transformationDayBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Transformation Day by Carlos Devadip Santana. This file differs from the other break instruments in that each primary instrument requries you to select a segment. There are five different drum breaks included.
    
    Sample Source: Transformation Day - Carlos Devadip Santana
    BPM: ~112
    Length: 4 or 8 beats
*/

connect "transformationDayBreakDiskin", "transformationDayBreakOutL", "transformationDayBreakMixerChannel", "transformationDayBreakInL"
connect "transformationDayBreakDiskin", "transformationDayBreakOutR", "transformationDayBreakMixerChannel", "transformationDayBreakInR"

connect "transformationDayBreakDiskgrain", "transformationDayBreakOutL", "transformationDayBreakMixerChannel", "transformationDayBreakInL"
connect "transformationDayBreakDiskgrain", "transformationDayBreakOutR", "transformationDayBreakMixerChannel", "transformationDayBreakInR"

connect "transformationDayBreakSndwarp", "transformationDayBreakOutL", "transformationDayBreakMixerChannel", "transformationDayBreakInL"
connect "transformationDayBreakSndwarp", "transformationDayBreakOutR", "transformationDayBreakMixerChannel", "transformationDayBreakInR"

alwayson "transformationDayBreakMixerChannel"

gktransformationDayBreakEqBass init 1
gktransformationDayBreakEqMid init 1
gktransformationDayBreakEqHigh init 1
gktransformationDayBreakFader init 1
gktransformationDayBreakPan init 50

gitransformationDayBreakSegmentBPMs[] fillarray 88.5, 87.5, 85
gitransformationDayBreakSegmentLengths[] fillarray 16, 8, 8

instr transformationDayBreakDiskin
    iSkipTimeInBeats = p4
    iBreakSegment = p5
    StransformationDayFilePath sprintfk "instruments/transformationDayBreak/transformationDayBreak%i.wav", iBreakSegment
    
    iFileLength filelen StransformationDayFilePath
    itransformationDayBreakBPM = gitransformationDayBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gitransformationDayBreakSegmentLengths[iBreakSegment]


    itransformationDayFactor = giBPM / itransformationDayBreakBPM
    kpitch = itransformationDayFactor

    iSkipTime = iFileLength / iBreakLength * iSkipTimeInBeats
    
    iwraparound= 0
    iformat = 0
    iskipinit = 0

    atransformationDayL, atransformationDayR diskin StransformationDayFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "transformationDayBreakOutL", atransformationDayL
    outleta "transformationDayBreakOutR", atransformationDayR

endin

instr transformationDayBreakDiskgrain
    iBreakSegment = p8
    
    StransformationDayFilePath sprintfk "instruments/transformationDayBreak/transformationDayBreak%i.wav", iBreakSegment
    iFileLength filelen StransformationDayFilePath
    itransformationDayBreakBPM = gitransformationDayBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gitransformationDayBreakSegmentLengths[iBreakSegment]
    itransformationDayFactor = giBPM / itransformationDayBreakBPM

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * itransformationDayFactor
    kpitch = p6
    iskipTimeInBeats = p7

    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iFileLength / iBreakLength * iskipTimeInBeats

    atransformationDayL, atransformationDayR diskgrain StransformationDayFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "transformationDayBreakOutL", atransformationDayL
    outleta "transformationDayBreakOutR", atransformationDayR

endin

instr transformationDayBreakSndwarp
    iBreakSegment = p9

    StransformationDayFilePath sprintfk "instruments/transformationDayBreak/transformationDayBreak%i.wav", iBreakSegment
    iFileLength filelen StransformationDayFilePath
    itransformationDayBreakBPM = gitransformationDayBreakSegmentBPMs[iBreakSegment]
    iBreakLength = gitransformationDayBreakSegmentLengths[iBreakSegment]
    itransformationDayFactor = giBPM / itransformationDayBreakBPM

    kamplitude = p4
    ktimewarp = p5 * (1/itransformationDayFactor)
    kresample = p6
    iskipTimeInBeats = p7
    ioverlap = p8
    
    itransformationDayFileSampleRate filesr StransformationDayFilePath
    itransformationDayTableLength getTableSizeFromSample StransformationDayFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    itransformationDayTable ftgenonce 0, 0, itransformationDayTableLength, 1, StransformationDayFilePath, 0, 0, 0

    isampleTable = itransformationDayTable
    ibeginningTime =  iFileLength / iBreakLength * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    atransformationDayL, atransformationDayR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "transformationDayBreakOutL", atransformationDayL
    outleta "transformationDayBreakOutR", atransformationDayR

endin

instr transformationDayBreakBassKnob
    gktransformationDayBreakEqBass linseg p4, p3, p5
endin

instr transformationDayBreakMidKnob
    gktransformationDayBreakEqMid linseg p4, p3, p5
endin

instr transformationDayBreakHighKnob
    gktransformationDayBreakEqHigh linseg p4, p3, p5  
endin

instr transformationDayBreakFader
    gktransformationDayBreakFader linseg p4, p3, p5
endin

instr transformationDayBreakPan
    gktransformationDayBreakPan linseg p4, p3, p5
endin

instr transformationDayBreakMixerChannel
    atransformationDayBreakL inleta "transformationDayBreakInL"
    atransformationDayBreakR inleta "transformationDayBreakInR"

    ktransformationDayBreakFader = gktransformationDayBreakFader
    ktransformationDayBreakPan = gktransformationDayBreakPan
    ktransformationDayBreakEqBass = gktransformationDayBreakEqBass
    ktransformationDayBreakEqMid = gktransformationDayBreakEqMid
    ktransformationDayBreakEqHigh = gktransformationDayBreakEqHigh

    atransformationDayBreakL, atransformationDayBreakR threeBandEqStereo atransformationDayBreakL, atransformationDayBreakR, ktransformationDayBreakEqBass, ktransformationDayBreakEqMid, ktransformationDayBreakEqHigh

    if ktransformationDayBreakPan > 100 then
        ktransformationDayBreakPan = 100
    elseif ktransformationDayBreakPan < 0 then
        ktransformationDayBreakPan = 0
    endif

    atransformationDayBreakL = (atransformationDayBreakL * ((100 - ktransformationDayBreakPan) * 2 / 100)) * ktransformationDayBreakFader
    atransformationDayBreakR = (atransformationDayBreakR * (ktransformationDayBreakPan * 2 / 100)) * ktransformationDayBreakFader

    outleta "transformationDayBreakOutL", atransformationDayBreakL
    outleta "transformationDayBreakOutR", atransformationDayBreakR
endin

