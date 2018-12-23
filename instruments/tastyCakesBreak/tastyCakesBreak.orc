/* tastyCakesBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Tasty Cakes by Idris Muhammed. I really should have cleaned the record though.

    Sample Source: Tasty Cakes - Idris Muhammad
    BPM: ~119
    Length: 8 beats
*/

connect "tastyCakesBreakDiskin", "tastyCakesBreakOutL", "tastyCakesBreakMixerChannel", "tastyCakesBreakInL"
connect "tastyCakesBreakDiskin", "tastyCakesBreakOutR", "tastyCakesBreakMixerChannel", "tastyCakesBreakInR"

connect "tastyCakesBreakDiskgrain", "tastyCakesBreakOutL", "tastyCakesBreakMixerChannel", "tastyCakesBreakInL"
connect "tastyCakesBreakDiskgrain", "tastyCakesBreakOutR", "tastyCakesBreakMixerChannel", "tastyCakesBreakInR"

connect "tastyCakesBreakSndwarp", "tastyCakesBreakOutL", "tastyCakesBreakMixerChannel", "tastyCakesBreakInL"
connect "tastyCakesBreakSndwarp", "tastyCakesBreakOutR", "tastyCakesBreakMixerChannel", "tastyCakesBreakInR"

alwayson "tastyCakesBreakMixerChannel"

gktastyCakesBreakEqBass init 1
gktastyCakesBreakEqMid init 1
gktastyCakesBreakEqHigh init 1
gktastyCakesBreakFader init 1
gktastyCakesBreakPan init 50
gStastyCakesFilePath init "instruments/tastyCakesBreak/tastyCakesBreak.wav"

gitastyCakesBreakBPM init 119

gitastyCakesFileLength filelen gStastyCakesFilePath
gitastyCakesLengthOfBeat = gitastyCakesFileLength / 8


instr tastyCakesBreakDiskin
    itastyCakesFactor = giBPM / gitastyCakesBreakBPM
    kpitch = itastyCakesFactor

    iSkipTimeInBeats = p4
    iSkipTime = gitastyCakesLengthOfBeat * iSkipTimeInBeats

    iwraparound= 1
    iformat = 0
    iskipinit = 0

    atastyCakesL, atastyCakesR diskin gStastyCakesFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "tastyCakesBreakOutL", atastyCakesL
    outleta "tastyCakesBreakOutR", atastyCakesR

endin

instr tastyCakesBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    itastyCakesFactor = giBPM / gitastyCakesBreakBPM
    iTimeFactor = p5 * itastyCakesFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = gitastyCakesLengthOfBeat * iskipTimeInBeats

    atastyCakesL, atastyCakesR diskgrain gStastyCakesFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "tastyCakesBreakOutL", atastyCakesL
    outleta "tastyCakesBreakOutR", atastyCakesR

endin

instr tastyCakesBreakSndwarp
    itastyCakesFileSampleRate filesr gStastyCakesFilePath
    itastyCakesTableLength getTableSizeFromSample gStastyCakesFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    itastyCakesTable ftgenonce 0, 0, itastyCakesTableLength, 1, gStastyCakesFilePath, 0, 0, 0

    kamplitude = p4
    itastyCakesFactor = giBPM / gitastyCakesBreakBPM
    ktimewarp = p5 * (1/itastyCakesFactor)
    kresample = p6
    isampleTable = itastyCakesTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  gitastyCakesLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    atastyCakesL, atastyCakesR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "tastyCakesBreakOutL", atastyCakesL
    outleta "tastyCakesBreakOutR", atastyCakesR

endin

instr tastyCakesBreakBassKnob
    gktastyCakesBreakEqBass linseg p4, p3, p5
endin

instr tastyCakesBreakMidKnob
    gktastyCakesBreakEqMid linseg p4, p3, p5
endin

instr tastyCakesBreakHighKnob
    gktastyCakesBreakEqHigh linseg p4, p3, p5
endin

instr tastyCakesBreakFader
    gktastyCakesBreakFader linseg p4, p3, p5
endin

instr tastyCakesBreakPan
    gktastyCakesBreakPan linseg p4, p3, p5
endin

instr tastyCakesBreakMixerChannel
    atastyCakesBreakL inleta "tastyCakesBreakInL"
    atastyCakesBreakR inleta "tastyCakesBreakInR"

    ktastyCakesBreakFader = gktastyCakesBreakFader
    ktastyCakesBreakPan = gktastyCakesBreakPan
    ktastyCakesBreakEqBass = gktastyCakesBreakEqBass
    ktastyCakesBreakEqMid = gktastyCakesBreakEqMid
    ktastyCakesBreakEqHigh = gktastyCakesBreakEqHigh

    atastyCakesBreakL, atastyCakesBreakR threeBandEqStereo atastyCakesBreakL, atastyCakesBreakR, ktastyCakesBreakEqBass, ktastyCakesBreakEqMid, ktastyCakesBreakEqHigh

    if ktastyCakesBreakPan > 100 then
        ktastyCakesBreakPan = 100
    elseif ktastyCakesBreakPan < 0 then
        ktastyCakesBreakPan = 0
    endif

    atastyCakesBreakL = (atastyCakesBreakL * ((100 - ktastyCakesBreakPan) * 2 / 100)) * ktastyCakesBreakFader
    atastyCakesBreakR = (atastyCakesBreakR * (ktastyCakesBreakPan * 2 / 100)) * ktastyCakesBreakFader

    outleta "tastyCakesBreakOutL", atastyCakesBreakL
    outleta "tastyCakesBreakOutR", atastyCakesBreakR
endin

