/* itsExpectedBreak
    A set of sampling instruments each using different opcodes for playing and manipulating a drum break from It's Expected, I'm Gone by The Minutemen.

    Sample Source: It's Expected, I'm Gone - The Minutemen
    BPM: ~60
    Length: 16 beats
*/

connect "itsExpectedBreakDiskin", "itsExpectedBreakOutL", "itsExpectedBreakMixerChannel", "itsExpectedBreakInL"
connect "itsExpectedBreakDiskin", "itsExpectedBreakOutR", "itsExpectedBreakMixerChannel", "itsExpectedBreakInR"

connect "itsExpectedBreakDiskgrain", "itsExpectedBreakOutL", "itsExpectedBreakMixerChannel", "itsExpectedBreakInL"
connect "itsExpectedBreakDiskgrain", "itsExpectedBreakOutR", "itsExpectedBreakMixerChannel", "itsExpectedBreakInR"

connect "itsExpectedBreakSndwarp", "itsExpectedBreakOutL", "itsExpectedBreakMixerChannel", "itsExpectedBreakInL"
connect "itsExpectedBreakSndwarp", "itsExpectedBreakOutR", "itsExpectedBreakMixerChannel", "itsExpectedBreakInR"

connect "itsExpectedBreakMixerChannel", "itsExpectedBreakOutL", "Mixer", "MixerInL"
connect "itsExpectedBreakMixerChannel", "itsExpectedBreakOutR", "Mixer", "MixerInR"
alwayson "itsExpectedBreakMixerChannel"

gkitsExpectedBreakEqBass init 1
gkitsExpectedBreakEqMid init 1
gkitsExpectedBreakEqHigh init 1
gkitsExpectedBreakFader init 1
gkitsExpectedBreakPan init 50
gSitsExpectedFilePath init "instruments/itsExpectedBreak/itsExpectedbreak.wav"

giitsExpectedBreakBPM init 87.25

giitsExpectedFactor = giBPM / giitsExpectedBreakBPM

giitsExpectedFileLength filelen gSitsExpectedFilePath
giitsExpectedLengthOfBeat = giitsExpectedFileLength / 16


instr itsExpectedBreakDiskin
    kpitch = giitsExpectedFactor
    
    iSkipTimeInBeats = p4
    iSkipTime = giitsExpectedLengthOfBeat * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    aitsExpectedL, aitsExpectedR diskin gSitsExpectedFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "itsExpectedBreakOutL", aitsExpectedL
    outleta "itsExpectedBreakOutR", aitsExpectedR

endin

instr itsExpectedBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * giitsExpectedFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = giitsExpectedLengthOfBeat * iskipTimeInBeats

    aitsExpectedL, aitsExpectedR diskgrain gSitsExpectedFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "itsExpectedBreakOutL", aitsExpectedL
    outleta "itsExpectedBreakOutR", aitsExpectedR

endin

instr itsExpectedBreakSndwarp
    iitsExpectedFileSampleRate filesr gSitsExpectedFilePath
    iitsExpectedTableLength getTableSizeFromSample gSitsExpectedFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iitsExpectedTable ftgenonce 0, 0, iitsExpectedTableLength, 1, gSitsExpectedFilePath, 0, 0, 0
    
    ;sndwarp arguments
    kamplitude = p4
    ktimewarp = p5 * (1/giitsExpectedFactor)
    kresample = p6
    isampleTable = iitsExpectedTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  giitsExpectedLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    aitsExpectedL, aitsExpectedR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "itsExpectedBreakOutL", aitsExpectedL
    outleta "itsExpectedBreakOutR", aitsExpectedR

endin

instr itsExpectedBreakBassKnob
    gkitsExpectedBreakEqBass linseg p4, p3, p5
endin

instr itsExpectedBreakMidKnob
    gkitsExpectedBreakEqMid linseg p4, p3, p5
endin

instr itsExpectedBreakHighKnob
    gkitsExpectedBreakEqHigh linseg p4, p3, p5  
endin

instr itsExpectedBreakFader
    gkitsExpectedBreakFader linseg p4, p3, p5
endin

instr itsExpectedBreakPan
    gkitsExpectedBreakPan linseg p4, p3, p5
endin

instr itsExpectedBreakMixerChannel
    aitsExpectedBreakL inleta "itsExpectedBreakInL"
    aitsExpectedBreakR inleta "itsExpectedBreakInR"

    kitsExpectedBreakFader = gkitsExpectedBreakFader
    kitsExpectedBreakPan = gkitsExpectedBreakPan
    kitsExpectedBreakEqBass = gkitsExpectedBreakEqBass
    kitsExpectedBreakEqMid = gkitsExpectedBreakEqMid
    kitsExpectedBreakEqHigh = gkitsExpectedBreakEqHigh

    aitsExpectedBreakL, aitsExpectedBreakR threeBandEqStereo aitsExpectedBreakL, aitsExpectedBreakR, kitsExpectedBreakEqBass, kitsExpectedBreakEqMid, kitsExpectedBreakEqHigh

    if kitsExpectedBreakPan > 100 then
        kitsExpectedBreakPan = 100
    elseif kitsExpectedBreakPan < 0 then
        kitsExpectedBreakPan = 0
    endif

    aitsExpectedBreakL = (aitsExpectedBreakL * ((100 - kitsExpectedBreakPan) * 2 / 100)) * kitsExpectedBreakFader
    aitsExpectedBreakR = (aitsExpectedBreakR * (kitsExpectedBreakPan * 2 / 100)) * kitsExpectedBreakFader

    outleta "itsExpectedBreakOutL", aitsExpectedBreakL
    outleta "itsExpectedBreakOutR", aitsExpectedBreakR
endin

