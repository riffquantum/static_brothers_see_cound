/* funkyDrummerBreak
    A set of funkyDrummer Break Instruments each using different opcodes for playing and manipulating the sample. This file is meant to serve as an area for experimentation with different opcodes for manipulating drum breaks
    BPM: ~101
*/

connect "funkyDrummerBreakDiskin", "funkyDrummerBreakOutL", "funkyDrummerBreakMixerChannel", "funkyDrummerBreakInL"
connect "funkyDrummerBreakDiskin", "funkyDrummerBreakOutR", "funkyDrummerBreakMixerChannel", "funkyDrummerBreakInR"

connect "funkyDrummerBreakDiskgrain", "funkyDrummerBreakOutL", "funkyDrummerBreakMixerChannel", "funkyDrummerBreakInL"
connect "funkyDrummerBreakDiskgrain", "funkyDrummerBreakOutR", "funkyDrummerBreakMixerChannel", "funkyDrummerBreakInR"

connect "funkyDrummerBreakSndwarp", "funkyDrummerBreakOutL", "funkyDrummerBreakMixerChannel", "funkyDrummerBreakInL"
connect "funkyDrummerBreakSndwarp", "funkyDrummerBreakOutR", "funkyDrummerBreakMixerChannel", "funkyDrummerBreakInR"

connect "funkyDrummerBreakMixerChannel", "funkyDrummerBreakOutL", "Mixer", "MixerInL"
connect "funkyDrummerBreakMixerChannel", "funkyDrummerBreakOutR", "Mixer", "MixerInR"
alwayson "funkyDrummerBreakMixerChannel"

gkfunkyDrummerBreakFader init 1
gkfunkyDrummerBreakPan init 50
gSfunkyDrummerFilePath init "instruments/funkyDrummerBreak/funkydrummerbreak.wav"

giFunkyDrummerBreakBPM init 101
giFunkyDrummerFactor = giBPM / giFunkyDrummerBreakBPM

instr funkyDrummerBPMsetter
    ;this does not work. Why?
    iMultiplier = p4
    ifunkyDrummerLength filelen gSfunkyDrummerFilePath
    ifunkyDrummerBPM = (60 / (ifunkyDrummerLength / 16)) * iMultiplier
    SScoreStatement sprintf {{t 0 %i}}, ifunkyDrummerBPM
    kTrigger metro 1

    scoreline SScoreStatement, kTrigger
endin

instr funkyDrummerBreakDiskin
    kpitch = giFunkyDrummerFactor
    
    iSkipTimeInBeats = p4
    iFileLength filelen gSfunkyDrummerFilePath
    iSkipTime = iFileLength / 16 * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    afunkyDrummerL, afunkyDrummerR diskin "instruments/funkyDrummerBreak/funkydrummerbreak.wav", kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakDiskgrain

    iTable ftgenonce 0, 0, 8192, 20, 2, 1

    ;Sfname,                                      kamp, kfreq, kpitch, kgrsize, kprate, ifun, iolaps [,imaxgrsize , ioffset]
    afunkyDrummerL, afunkyDrummerR diskgrain "instruments/funkyDrummerBreak/funkydrummerbreak.wav", 1,    10000,     1,  0.0001,     p4, iTable,  1000

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakSndwarp
    ifunkyDrummerFileSampleRate filesr gSfunkyDrummerFilePath
    
    ifunkyDrummerTableLength getTableSizeFromSample gSfunkyDrummerFilePath

    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    ifunkyDrummerTable ftgenonce 0, 0, ifunkyDrummerTableLength, 1, "instruments/funkyDrummerBreak/funkydrummerbreak.wav", 0, 0, 0

    kxpitch = ifunkyDrummerFileSampleRate / ifunkyDrummerFileSampleRate
    ;afunkyDrummer grain 0.1,   kxpitch,     10,     10,       10,         .010, ifunkyDrummerTable, iTable,    0.01,      1
    
    ;sndwarp arguments
    kamplitude = 1
    ktimewarp = 0.9
    kresample linseg 1, p4, 1000
    isampleTable = ifunkyDrummerTable
    ibeginningTime = 0
    iwindowSize = 5
    irandw = 0
    ioverlap = 1
    ienvelopeTable = iTable
    itimemode = 0
    afunkyDrummerL, afunkyDrummerR sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakFader
    gkfunkyDrummerBreakFader linseg p4, p3, p5
endin

instr funkyDrummerBreakPan
    gkfunkyDrummerBreakPan linseg p4, p3, p5
endin

instr funkyDrummerBreakMixerChannel
    afunkyDrummerBreakL inleta "funkyDrummerBreakInL"
    afunkyDrummerBreakR inleta "funkyDrummerBreakInR"

    kfunkyDrummerBreakFader = gkfunkyDrummerBreakFader
    kfunkyDrummerBreakPan = gkfunkyDrummerBreakPan

    if kfunkyDrummerBreakPan > 100 then
        kfunkyDrummerBreakPan = 100
    elseif kfunkyDrummerBreakPan < 0 then
        kfunkyDrummerBreakPan = 0
    endif

    afunkyDrummerBreakL = (afunkyDrummerBreakL * ((100 - kfunkyDrummerBreakPan) * 2 / 100)) * kfunkyDrummerBreakFader
    afunkyDrummerBreakR = (afunkyDrummerBreakR * (kfunkyDrummerBreakPan * 2 / 100)) * kfunkyDrummerBreakFader

    outleta "funkyDrummerBreakOutL", afunkyDrummerBreakL
    outleta "funkyDrummerBreakOutR", afunkyDrummerBreakR
endin

