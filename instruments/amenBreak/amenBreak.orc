/* amenBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Amen, Brother by The Winstons.

    Sample Source: Amen, Brother - The Winstons
    BPM: ~137
    Length: 16 beats
*/

connect "AmenBreakDiskin", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"
connect "AmenBreakDiskgrain", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"
connect "AmenBreakSndwarp", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"
alwayson "AmenBreakMixerChannel"

gkAmenBreakEqBass init 1
gkAmenBreakEqMid init 1
gkAmenBreakEqHigh init 1
gkAmenBreakFader init 1
gkAmenBreakPan init 50
gSAmenFilePath init "instruments/amenBreak/amen-break.wav"

giAmenBreakBPM init 137

giAmenFileLength filelen gSAmenFilePath
giAmenLengthOfBeat = giAmenFileLength / 16

instr AmenBreakDiskin
    iAmenFactor = giBPM / giAmenBreakBPM
    kpitch = iAmenFactor

    iSkipTimeInBeats = p4
    iSkipTime = giAmenLengthOfBeat * iSkipTimeInBeats

    iwraparound= 1
    iformat = 0
    iskipinit = 0

    aAmen diskin gSAmenFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "AmenBreakOut", aAmen

endin

instr AmenBreakDiskgrain
    iAmenFactor = giBPM / giAmenBreakBPM
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * iAmenFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = giAmenLengthOfBeat * iskipTimeInBeats

    aAmen diskgrain gSAmenFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "AmenBreakOut", aAmen

endin

instr AmenBreakSndwarp
    iAmenFactor = giBPM / giAmenBreakBPM
    iAmenFileSampleRate filesr gSAmenFilePath
    iAmenTableLength getTableSizeFromSample gSAmenFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iAmenTable ftgenonce 0, 0, iAmenTableLength, 1, gSAmenFilePath, 0, 0, 0

    kamplitude = p4
    ktimewarp = p5 * (1/iAmenFactor)
    kresample = p6
    isampleTable = iAmenTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  giAmenLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    aAmen sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "AmenBreakOut", aAmen

endin

instr AmenBreakBassKnob
    gkAmenBreakEqBass linseg p4, p3, p5
endin

instr AmenBreakMidKnob
    gkAmenBreakEqMid linseg p4, p3, p5
endin

instr AmenBreakHighKnob
    gkAmenBreakEqHigh linseg p4, p3, p5
endin

instr AmenBreakFader
    gkAmenBreakFader linseg p4, p3, p5
endin

instr AmenBreakPan
    gkAmenBreakPan linseg p4, p3, p5
endin

instr AmenBreakMixerChannel
    aAmenBreakL inleta "AmenBreakIn"
    aAmenBreakR inleta "AmenBreakIn"

    kAmenBreakFader = gkAmenBreakFader
    kAmenBreakPan = gkAmenBreakPan
    kAmenBreakEqBass = gkAmenBreakEqBass
    kAmenBreakEqMid = gkAmenBreakEqMid
    kAmenBreakEqHigh = gkAmenBreakEqHigh

    aAmenBreakL, aAmenBreakR threeBandEqStereo aAmenBreakL, aAmenBreakR, kAmenBreakEqBass, kAmenBreakEqMid, kAmenBreakEqHigh

    if kAmenBreakPan > 100 then
        kAmenBreakPan = 100
    elseif kAmenBreakPan < 0 then
        kAmenBreakPan = 0
    endif

    aAmenBreakL = (aAmenBreakL * ((100 - kAmenBreakPan) * 2 / 100)) * kAmenBreakFader
    aAmenBreakR = (aAmenBreakR * (kAmenBreakPan * 2 / 100)) * kAmenBreakFader

    outleta "AmenBreakOutL", aAmenBreakL
    outleta "AmenBreakOutR", aAmenBreakR
endin

