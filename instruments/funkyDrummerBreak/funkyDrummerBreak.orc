/* funkyDrummerBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Funky Drummer by James Brown.
    
    Sample Source: Funky Drummer - James Brown
    BPM: ~101
    Length: 16 beats
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
gSFunkyDrummerFilePath init "instruments/funkyDrummerBreak/funkydrummerbreak.wav"

giFunkyDrummerBreakBPM init 101
giFunkyDrummerFactor = giBPM / giFunkyDrummerBreakBPM

giFunkyDrummerFileLength filelen gSFunkyDrummerFilePath
giFunkyDrummerLengthOfBeat = giFunkyDrummerFileLength / 16


instr funkyDrummerBreakDiskin
    kpitch = giFunkyDrummerFactor
    
    iSkipTimeInBeats = p4
    iSkipTime = giFunkyDrummerLengthOfBeat * iSkipTimeInBeats
    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    afunkyDrummerL, afunkyDrummerR diskin gSFunkyDrummerFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * giFunkyDrummerFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = giFunkyDrummerLengthOfBeat * iskipTimeInBeats

    afunkyDrummerL, afunkyDrummerR diskgrain gSFunkyDrummerFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakSndwarp
    iFunkyDrummerFileSampleRate filesr gSFunkyDrummerFilePath
    iFunkyDrummerTableLength getTableSizeFromSample gSFunkyDrummerFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iFunkyDrummerTable ftgenonce 0, 0, iFunkyDrummerTableLength, 1, gSFunkyDrummerFilePath, 0, 0, 0
    
    kamplitude = p4
    ktimewarp = p5 * (1/giFunkyDrummerFactor)
    kresample = p6
    isampleTable = iFunkyDrummerTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  giFunkyDrummerLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    afunkyDrummerL, afunkyDrummerR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

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

