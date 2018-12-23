/* closeToMeBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the intro drum break from Close To Me by The Cure.

    Sample Source: Close To Me - The Cure
    BPM: ~185
    Length: 32 beats
*/

connect "closeToMeBreakDiskin", "closeToMeBreakOutL", "closeToMeBreakMixerChannel", "closeToMeBreakInL"
connect "closeToMeBreakDiskin", "closeToMeBreakOutR", "closeToMeBreakMixerChannel", "closeToMeBreakInR"

connect "closeToMeBreakDiskgrain", "closeToMeBreakOutL", "closeToMeBreakMixerChannel", "closeToMeBreakInL"
connect "closeToMeBreakDiskgrain", "closeToMeBreakOutR", "closeToMeBreakMixerChannel", "closeToMeBreakInR"

connect "closeToMeBreakSndwarp", "closeToMeBreakOutL", "closeToMeBreakMixerChannel", "closeToMeBreakInL"
connect "closeToMeBreakSndwarp", "closeToMeBreakOutR", "closeToMeBreakMixerChannel", "closeToMeBreakInR"

alwayson "closeToMeBreakMixerChannel"

gkcloseToMeBreakEqBass init 1
gkcloseToMeBreakEqMid init 1
gkcloseToMeBreakEqHigh init 1
gkcloseToMeBreakFader init 1
gkcloseToMeBreakPan init 50
gScloseToMeFilePath init "instruments/closeToMeBreak/closeToMeBreak.wav"

gicloseToMeBreakBPM init 185.5

gicloseToMeFileLength filelen gScloseToMeFilePath
gicloseToMeLengthOfBeat = gicloseToMeFileLength / 24


instr closeToMeBreakDiskin
    icloseToMeFactor = giBPM / gicloseToMeBreakBPM
    kpitch = icloseToMeFactor

    iSkipTimeInBeats = p4
    iSkipTime = gicloseToMeLengthOfBeat * iSkipTimeInBeats

    iwraparound= 1
    iformat = 0
    iskipinit = 0

    acloseToMeL, acloseToMeR diskin gScloseToMeFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "closeToMeBreakOutL", acloseToMeL
    outleta "closeToMeBreakOutR", acloseToMeR

endin

instr closeToMeBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    icloseToMeFactor = giBPM / gicloseToMeBreakBPM
    iTimeFactor = p5 * icloseToMeFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gicloseToMeLengthOfBeat * iskipTimeInBeats

    acloseToMeL, acloseToMeR diskgrain gScloseToMeFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "closeToMeBreakOutL", acloseToMeL
    outleta "closeToMeBreakOutR", acloseToMeR

endin

instr closeToMeBreakSndwarp
    icloseToMeFileSampleRate filesr gScloseToMeFilePath
    icloseToMeTableLength getTableSizeFromSample gScloseToMeFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    icloseToMeTable ftgenonce 0, 0, icloseToMeTableLength, 1, gScloseToMeFilePath, 0, 0, 0

    kamplitude = p4
    icloseToMeFactor = giBPM / gicloseToMeBreakBPM
    ktimewarp = p5 * (1/icloseToMeFactor)
    kresample = p6
    isampleTable = icloseToMeTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gicloseToMeLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    acloseToMeL, acloseToMeR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "closeToMeBreakOutL", acloseToMeL
    outleta "closeToMeBreakOutR", acloseToMeR

endin

instr closeToMeBreakBassKnob
    gkcloseToMeBreakEqBass linseg p4, p3, p5
endin

instr closeToMeBreakMidKnob
    gkcloseToMeBreakEqMid linseg p4, p3, p5
endin

instr closeToMeBreakHighKnob
    gkcloseToMeBreakEqHigh linseg p4, p3, p5
endin

instr closeToMeBreakFader
    gkcloseToMeBreakFader linseg p4, p3, p5
endin

instr closeToMeBreakPan
    gkcloseToMeBreakPan linseg p4, p3, p5
endin

instr closeToMeBreakMixerChannel
    acloseToMeBreakL inleta "closeToMeBreakInL"
    acloseToMeBreakR inleta "closeToMeBreakInR"

    kcloseToMeBreakFader = gkcloseToMeBreakFader
    kcloseToMeBreakPan = gkcloseToMeBreakPan
    kcloseToMeBreakEqBass = gkcloseToMeBreakEqBass
    kcloseToMeBreakEqMid = gkcloseToMeBreakEqMid
    kcloseToMeBreakEqHigh = gkcloseToMeBreakEqHigh

    acloseToMeBreakL, acloseToMeBreakR threeBandEqStereo acloseToMeBreakL, acloseToMeBreakR, kcloseToMeBreakEqBass, kcloseToMeBreakEqMid, kcloseToMeBreakEqHigh

    if kcloseToMeBreakPan > 100 then
        kcloseToMeBreakPan = 100
    elseif kcloseToMeBreakPan < 0 then
        kcloseToMeBreakPan = 0
    endif

    acloseToMeBreakL = (acloseToMeBreakL * ((100 - kcloseToMeBreakPan) * 2 / 100)) * kcloseToMeBreakFader
    acloseToMeBreakR = (acloseToMeBreakR * (kcloseToMeBreakPan * 2 / 100)) * kcloseToMeBreakFader

    outleta "closeToMeBreakOutL", acloseToMeBreakL
    outleta "closeToMeBreakOutR", acloseToMeBreakR
endin

