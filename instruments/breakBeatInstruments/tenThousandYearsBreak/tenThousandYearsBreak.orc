/* tenThousandYearsBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the intro drum break from 10,000 Years by High On Fire.

    Sample Source: 10,000 Years - High On Fire
    BPM: ~62
    Length: 16 beats
*/

connect "tenThousandYearsBreakDiskin", "tenThousandYearsBreakOutL", "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakInL"
connect "tenThousandYearsBreakDiskin", "tenThousandYearsBreakOutR", "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakInR"

connect "tenThousandYearsBreakDiskgrain", "tenThousandYearsBreakOutL", "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakInL"
connect "tenThousandYearsBreakDiskgrain", "tenThousandYearsBreakOutR", "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakInR"

connect "tenThousandYearsBreakSndwarp", "tenThousandYearsBreakOutL", "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakInL"
connect "tenThousandYearsBreakSndwarp", "tenThousandYearsBreakOutR", "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakInR"

connect "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakOutL", "Mixer", "MixerInL"
connect "tenThousandYearsBreakMixerChannel", "tenThousandYearsBreakOutR", "Mixer", "MixerInR"

alwayson "tenThousandYearsBreakMixerChannel"

gktenThousandYearsBreakEqBass init 1
gktenThousandYearsBreakEqMid init 1
gktenThousandYearsBreakEqHigh init 1
gktenThousandYearsBreakFader init 1
gktenThousandYearsBreakPan init 50
gStenThousandYearsFilePath init "instruments/breakBeatInstruments/tenThousandYearsBreak/tenThousandYearsBreak.wav"

gitenThousandYearsBreakBPM init 62

gitenThousandYearsFileLength filelen gStenThousandYearsFilePath
gitenThousandYearsLengthOfBeat = gitenThousandYearsFileLength / 16


instr tenThousandYearsBreakDiskin
    iSkipTimeInBeats = p4
    kpitchFactor = p5

    atenThousandYearsL, atenThousandYearsR breakSamplerDiskin gStenThousandYearsFilePath, 16, iSkipTimeInBeats, kpitchFactor

    outleta "tenThousandYearsBreakOutL", atenThousandYearsL
    outleta "tenThousandYearsBreakOutR", atenThousandYearsR

endin

instr tenThousandYearsBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    itenThousandYearsFactor = giBPM / gitenThousandYearsBreakBPM
    iTimeFactor = p5 * itenThousandYearsFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gitenThousandYearsLengthOfBeat * iskipTimeInBeats

    atenThousandYearsL, atenThousandYearsR diskgrain gStenThousandYearsFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "tenThousandYearsBreakOutL", atenThousandYearsL
    outleta "tenThousandYearsBreakOutR", atenThousandYearsR

endin

instr tenThousandYearsBreakSndwarp
    itenThousandYearsFileSampleRate filesr gStenThousandYearsFilePath
    itenThousandYearsTableLength getTableSizeFromSample gStenThousandYearsFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    itenThousandYearsTable ftgenonce 0, 0, itenThousandYearsTableLength, 1, gStenThousandYearsFilePath, 0, 0, 0

    kamplitude = p4
    itenThousandYearsFactor = giBPM / gitenThousandYearsBreakBPM
    ktimewarp = p5 * (1/itenThousandYearsFactor)
    kresample = p6
    isampleTable = itenThousandYearsTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gitenThousandYearsLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    atenThousandYearsL, atenThousandYearsR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "tenThousandYearsBreakOutL", atenThousandYearsL
    outleta "tenThousandYearsBreakOutR", atenThousandYearsR

endin

instr tenThousandYearsBreakBassKnob
    gktenThousandYearsBreakEqBass linseg p4, p3, p5
endin

instr tenThousandYearsBreakMidKnob
    gktenThousandYearsBreakEqMid linseg p4, p3, p5
endin

instr tenThousandYearsBreakHighKnob
    gktenThousandYearsBreakEqHigh linseg p4, p3, p5
endin

instr tenThousandYearsBreakFader
    gktenThousandYearsBreakFader linseg p4, p3, p5
endin

instr tenThousandYearsBreakPan
    gktenThousandYearsBreakPan linseg p4, p3, p5
endin

instr tenThousandYearsBreakMixerChannel
    atenThousandYearsBreakL inleta "tenThousandYearsBreakInL"
    atenThousandYearsBreakR inleta "tenThousandYearsBreakInR"

    ktenThousandYearsBreakFader = gktenThousandYearsBreakFader
    ktenThousandYearsBreakPan = gktenThousandYearsBreakPan
    ktenThousandYearsBreakEqBass = gktenThousandYearsBreakEqBass
    ktenThousandYearsBreakEqMid = gktenThousandYearsBreakEqMid
    ktenThousandYearsBreakEqHigh = gktenThousandYearsBreakEqHigh

    atenThousandYearsBreakL, atenThousandYearsBreakR threeBandEqStereo atenThousandYearsBreakL, atenThousandYearsBreakR, ktenThousandYearsBreakEqBass, ktenThousandYearsBreakEqMid, ktenThousandYearsBreakEqHigh

    if ktenThousandYearsBreakPan > 100 then
        ktenThousandYearsBreakPan = 100
    elseif ktenThousandYearsBreakPan < 0 then
        ktenThousandYearsBreakPan = 0
    endif

    atenThousandYearsBreakL = (atenThousandYearsBreakL * ((100 - ktenThousandYearsBreakPan) * 2 / 100)) * ktenThousandYearsBreakFader
    atenThousandYearsBreakR = (atenThousandYearsBreakR * (ktenThousandYearsBreakPan * 2 / 100)) * ktenThousandYearsBreakFader

    outleta "tenThousandYearsBreakOutL", atenThousandYearsBreakL
    outleta "tenThousandYearsBreakOutR", atenThousandYearsBreakR
endin

