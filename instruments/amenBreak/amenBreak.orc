/* amenBreak
    A set of Amen Break Instruments each using different opcodes for playing and manipulating the sample. This file is meant to serve as an area for experimentation with different opcodes for manipulating drum breaks
*/

connect "AmenBreakDiskin", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"
connect "AmenBreakDiskgrain", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"
connect "AmenBreakSndwarp", "AmenBreakOut", "AmenBreakMixerChannel", "AmenBreakIn"

connect "AmenBreakMixerChannel", "AmenBreakOutL", "Mixer", "MixerInL"
connect "AmenBreakMixerChannel", "AmenBreakOutR", "Mixer", "MixerInR"
alwayson "AmenBreakMixerChannel"

gkAmenBreakFader init 1
gkAmenBreakPan init 50
gSAmenFilePath init "instruments/amenBreak/amen-break.wav"


instr AmenBPMsetter
    ;this does not work. Why?
    iMultiplier = p4
    iAmenLength filelen gSAmenFilePath
    iAmenBPM = (60 / (iAmenLength / 16)) * iMultiplier
    SScoreStatement sprintf {{t 0 %i}}, iAmenBPM
    kTrigger metro 1

    scoreline SScoreStatement, kTrigger
endin

instr AmenBreakDiskin
    kpitch = p4
    
    iSkipTimeInBeats = p5
    iFileLength filelen gSAmenFilePath
    iSkipTime = iFileLength / 16 * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aAmen diskin "instruments/amenBreak/amen-break.wav", kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "AmenBreakOut", aAmen

endin

instr AmenBreakDiskgrain

    iTable ftgenonce 0, 0, 8192, 20, 2, 1

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    aAmen diskgrain "instruments/amenBreak/amen-break.wav", 1,    10000,     1,  0.0001,     p4, iTable,  1000

    outleta "AmenBreakOut", aAmen

endin

instr AmenBreakSndwarp
    iAmenFileSampleRate filesr gSAmenFilePath
    
    iAmenTableLength getTableSizeFromSample gSAmenFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iAmenTable ftgenonce 0, 0, iAmenTableLength, 1, "instruments/amenBreak/amen-break.wav", 0, 0, 0

    kxpitch = iAmenFileSampleRate / iAmenFileSampleRate
    ;aAmen grain 0.1,   kxpitch,     10,     10,       10,         .010, iAmenTable, iTable,    0.01,      1
    
    ;sndwarp arguments
    kamplitude = 1
    ktimewarp = 0.9
    kresample linseg 1, p4, 1000
    isampleTable = iAmenTable
    ibeginningTime = 0
    iwindowSize = 5
    irandw = 0
    ioverlap = 1
    ienvelopeTable = iTable
    itimemode = 0
    aAmen sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "AmenBreakOut", aAmen

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

