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

alwayson "funkyDrummerBreakMixerChannel"

gkfunkyDrummerBreakEqBass init 1
gkfunkyDrummerBreakEqMid init 1
gkfunkyDrummerBreakEqHigh init 1
gkfunkyDrummerBreakFader init 1
gkfunkyDrummerBreakPan init 50
gSfunkyDrummerFilePath init "instruments/breakBeatInstruments/funkyDrummerBreak/funkydrummerbreak.wav"

gifunkyDrummerBreakBPM init 101

gifunkyDrummerFileLength filelen gSfunkyDrummerFilePath
gifunkyDrummerLengthOfBeat = gifunkyDrummerFileLength / 16


instr funkyDrummerBreakDiskin
    iSkipTimeInBeats = p4
    kpitchFactor = p5

    afunkyDrummerL, afunkyDrummerR breakSamplerDiskin gSfunkyDrummerFilePath, 16, iSkipTimeInBeats, kpitchFactor

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    ifunkyDrummerFactor = giBPM / gifunkyDrummerBreakBPM
    iTimeFactor = p5 * ifunkyDrummerFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gifunkyDrummerLengthOfBeat * iskipTimeInBeats

    afunkyDrummerL, afunkyDrummerR diskgrain gSfunkyDrummerFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakSndwarp
    ifunkyDrummerFileSampleRate filesr gSfunkyDrummerFilePath
    ifunkyDrummerTableLength getTableSizeFromSample gSfunkyDrummerFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    ifunkyDrummerTable ftgenonce 0, 0, ifunkyDrummerTableLength, 1, gSfunkyDrummerFilePath, 0, 0, 0

    kamplitude = p4
    ifunkyDrummerFactor = giBPM / gifunkyDrummerBreakBPM
    ktimewarp = p5 * (1/ifunkyDrummerFactor)
    kresample = p6
    isampleTable = ifunkyDrummerTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gifunkyDrummerLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    afunkyDrummerL, afunkyDrummerR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "funkyDrummerBreakOutL", afunkyDrummerL
    outleta "funkyDrummerBreakOutR", afunkyDrummerR

endin

instr funkyDrummerBreakBassKnob
    gkfunkyDrummerBreakEqBass linseg p4, p3, p5
endin

instr funkyDrummerBreakMidKnob
    gkfunkyDrummerBreakEqMid linseg p4, p3, p5
endin

instr funkyDrummerBreakHighKnob
    gkfunkyDrummerBreakEqHigh linseg p4, p3, p5
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
    kfunkyDrummerBreakEqBass = gkfunkyDrummerBreakEqBass
    kfunkyDrummerBreakEqMid = gkfunkyDrummerBreakEqMid
    kfunkyDrummerBreakEqHigh = gkfunkyDrummerBreakEqHigh

    afunkyDrummerBreakL, afunkyDrummerBreakR threeBandEqStereo afunkyDrummerBreakL, afunkyDrummerBreakR, kfunkyDrummerBreakEqBass, kfunkyDrummerBreakEqMid, kfunkyDrummerBreakEqHigh

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

