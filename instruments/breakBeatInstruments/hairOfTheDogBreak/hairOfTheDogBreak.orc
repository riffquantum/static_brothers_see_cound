/* hairOfTheDogBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the intro drum break from Hair Of The Dog by Nazareth.

    Sample Source: Hair Of The Dog - Nazareth
    BPM: ~125
    Length: 16 beats
*/

connect "hairOfTheDogBreakDiskin", "hairOfTheDogBreakOutL", "hairOfTheDogBreakMixerChannel", "hairOfTheDogBreakInL"
connect "hairOfTheDogBreakDiskin", "hairOfTheDogBreakOutR", "hairOfTheDogBreakMixerChannel", "hairOfTheDogBreakInR"

connect "hairOfTheDogBreakDiskgrain", "hairOfTheDogBreakOutL", "hairOfTheDogBreakMixerChannel", "hairOfTheDogBreakInL"
connect "hairOfTheDogBreakDiskgrain", "hairOfTheDogBreakOutR", "hairOfTheDogBreakMixerChannel", "hairOfTheDogBreakInR"

connect "hairOfTheDogBreakSndwarp", "hairOfTheDogBreakOutL", "hairOfTheDogBreakMixerChannel", "hairOfTheDogBreakInL"
connect "hairOfTheDogBreakSndwarp", "hairOfTheDogBreakOutR", "hairOfTheDogBreakMixerChannel", "hairOfTheDogBreakInR"

alwayson "hairOfTheDogBreakMixerChannel"

gkhairOfTheDogBreakEqBass init 1
gkhairOfTheDogBreakEqMid init 1
gkhairOfTheDogBreakEqHigh init 1
gkhairOfTheDogBreakFader init 1
gkhairOfTheDogBreakPan init 50
gShairOfTheDogFilePath init "instruments/breakBeatInstruments/hairOfTheDogBreak/hairOfTheDogBreak.wav"

gihairOfTheDogBreakBPM init 125

gihairOfTheDogFileLength filelen gShairOfTheDogFilePath
gihairOfTheDogLengthOfBeat = gihairOfTheDogFileLength / 16


instr hairOfTheDogBreakDiskin
    iSkipTimeInBeats = p4
    kpitchFactor = p5

    ahairOfTheDogL, ahairOfTheDogR breakSamplerDiskin gShairOfTheDogFilePath, 16, iSkipTimeInBeats, kpitchFactor

    outleta "hairOfTheDogBreakOutL", ahairOfTheDogL
    outleta "hairOfTheDogBreakOutR", ahairOfTheDogR

endin

instr hairOfTheDogBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    ihairOfTheDogFactor = giBPM / gihairOfTheDogBreakBPM
    iTimeFactor = p5 * ihairOfTheDogFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gihairOfTheDogLengthOfBeat * iskipTimeInBeats

    ahairOfTheDogL, ahairOfTheDogR diskgrain gShairOfTheDogFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "hairOfTheDogBreakOutL", ahairOfTheDogL
    outleta "hairOfTheDogBreakOutR", ahairOfTheDogR

endin

instr hairOfTheDogBreakSndwarp
    ihairOfTheDogFileSampleRate filesr gShairOfTheDogFilePath
    ihairOfTheDogTableLength getTableSizeFromSample gShairOfTheDogFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    ihairOfTheDogTable ftgenonce 0, 0, ihairOfTheDogTableLength, 1, gShairOfTheDogFilePath, 0, 0, 0

    kamplitude = p4
    ihairOfTheDogFactor = giBPM / gihairOfTheDogBreakBPM
    ktimewarp = p5 * (1/ihairOfTheDogFactor)
    kresample = p6
    isampleTable = ihairOfTheDogTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gihairOfTheDogLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    ahairOfTheDogL, ahairOfTheDogR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "hairOfTheDogBreakOutL", ahairOfTheDogL
    outleta "hairOfTheDogBreakOutR", ahairOfTheDogR

endin

instr hairOfTheDogBreakBassKnob
    gkhairOfTheDogBreakEqBass linseg p4, p3, p5
endin

instr hairOfTheDogBreakMidKnob
    gkhairOfTheDogBreakEqMid linseg p4, p3, p5
endin

instr hairOfTheDogBreakHighKnob
    gkhairOfTheDogBreakEqHigh linseg p4, p3, p5
endin

instr hairOfTheDogBreakFader
    gkhairOfTheDogBreakFader linseg p4, p3, p5
endin

instr hairOfTheDogBreakPan
    gkhairOfTheDogBreakPan linseg p4, p3, p5
endin

instr hairOfTheDogBreakMixerChannel
    ahairOfTheDogBreakL inleta "hairOfTheDogBreakInL"
    ahairOfTheDogBreakR inleta "hairOfTheDogBreakInR"

    khairOfTheDogBreakFader = gkhairOfTheDogBreakFader
    khairOfTheDogBreakPan = gkhairOfTheDogBreakPan
    khairOfTheDogBreakEqBass = gkhairOfTheDogBreakEqBass
    khairOfTheDogBreakEqMid = gkhairOfTheDogBreakEqMid
    khairOfTheDogBreakEqHigh = gkhairOfTheDogBreakEqHigh

    ahairOfTheDogBreakL, ahairOfTheDogBreakR threeBandEqStereo ahairOfTheDogBreakL, ahairOfTheDogBreakR, khairOfTheDogBreakEqBass, khairOfTheDogBreakEqMid, khairOfTheDogBreakEqHigh

    if khairOfTheDogBreakPan > 100 then
        khairOfTheDogBreakPan = 100
    elseif khairOfTheDogBreakPan < 0 then
        khairOfTheDogBreakPan = 0
    endif

    ahairOfTheDogBreakL = (ahairOfTheDogBreakL * ((100 - khairOfTheDogBreakPan) * 2 / 100)) * khairOfTheDogBreakFader
    ahairOfTheDogBreakR = (ahairOfTheDogBreakR * (khairOfTheDogBreakPan * 2 / 100)) * khairOfTheDogBreakFader

    outleta "hairOfTheDogBreakOutL", ahairOfTheDogBreakL
    outleta "hairOfTheDogBreakOutR", ahairOfTheDogBreakR
endin

