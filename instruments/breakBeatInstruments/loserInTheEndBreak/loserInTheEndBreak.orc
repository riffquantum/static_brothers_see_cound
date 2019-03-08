/* loserInTheEndBreak
    A set of sampling instruments each using different opcodes for playing and manipulating a drum break from Loser In The End by Queen.

    Sample Source: Loser In The End - Queen
    BPM: ~72.5
    Length: 16 beats
*/

connect "loserInTheEndBreakDiskin", "loserInTheEndBreakOutL", "loserInTheEndBreakMixerChannel", "loserInTheEndBreakInL"
connect "loserInTheEndBreakDiskin", "loserInTheEndBreakOutR", "loserInTheEndBreakMixerChannel", "loserInTheEndBreakInR"

connect "loserInTheEndBreakDiskgrain", "loserInTheEndBreakOutL", "loserInTheEndBreakMixerChannel", "loserInTheEndBreakInL"
connect "loserInTheEndBreakDiskgrain", "loserInTheEndBreakOutR", "loserInTheEndBreakMixerChannel", "loserInTheEndBreakInR"

connect "loserInTheEndBreakSndwarp", "loserInTheEndBreakOutL", "loserInTheEndBreakMixerChannel", "loserInTheEndBreakInL"
connect "loserInTheEndBreakSndwarp", "loserInTheEndBreakOutR", "loserInTheEndBreakMixerChannel", "loserInTheEndBreakInR"

alwayson "loserInTheEndBreakMixerChannel"

gkloserInTheEndBreakEqBass init 1
gkloserInTheEndBreakEqMid init 1
gkloserInTheEndBreakEqHigh init 1
gkloserInTheEndBreakFader init 1
gkloserInTheEndBreakPan init 50
gSloserInTheEndFilePath init "instruments/breakBeatInstruments/loserInTheEndBreak/loserInTheEndbreak.wav"

giloserInTheEndBreakBPM init 72.5

giloserInTheEndFileLength filelen gSloserInTheEndFilePath
giloserInTheEndLengthOfBeat = giloserInTheEndFileLength / 16


instr loserInTheEndBreakDiskin
  iSkipTimeInBeats = p4
  kpitchFactor = p5

  aloserInTheEndL, aloserInTheEndR breakSamplerDiskin gSloserInTheEndFilePath, 16, iSkipTimeInBeats, kpitchFactor

  outleta "loserInTheEndBreakOutL", aloserInTheEndL
  outleta "loserInTheEndBreakOutR", aloserInTheEndR

endin

instr loserInTheEndBreakDiskgrain
    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iloserInTheEndFactor = giBPM / giloserInTheEndBreakBPM
    iTimeFactor = p5 * iloserInTheEndFactor
    kpitch = p6
    iskipTimeInBeats = p7
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = giloserInTheEndLengthOfBeat * iskipTimeInBeats

    aloserInTheEndL, aloserInTheEndR diskgrain gSloserInTheEndFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "loserInTheEndBreakOutL", aloserInTheEndL
    outleta "loserInTheEndBreakOutR", aloserInTheEndR

endin

instr loserInTheEndBreakSndwarp
    iloserInTheEndFileSampleRate filesr gSloserInTheEndFilePath
    iloserInTheEndTableLength getTableSizeFromSample gSloserInTheEndFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iloserInTheEndTable ftgenonce 0, 0, iloserInTheEndTableLength, 1, gSloserInTheEndFilePath, 0, 0, 0

    ;sndwarp arguments
    kamplitude = p4
    iloserInTheEndFactor = giBPM / giloserInTheEndBreakBPM
    ktimewarp = p5 * (1/iloserInTheEndFactor)
    kresample = p6
    isampleTable = iloserInTheEndTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  giloserInTheEndLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    aloserInTheEndL, aloserInTheEndR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "loserInTheEndBreakOutL", aloserInTheEndL
    outleta "loserInTheEndBreakOutR", aloserInTheEndR

endin

instr loserInTheEndBreakBassKnob
    gkloserInTheEndBreakEqBass linseg p4, p3, p5
endin

instr loserInTheEndBreakMidKnob
    gkloserInTheEndBreakEqMid linseg p4, p3, p5
endin

instr loserInTheEndBreakHighKnob
    gkloserInTheEndBreakEqHigh linseg p4, p3, p5
endin

instr loserInTheEndBreakFader
    gkloserInTheEndBreakFader linseg p4, p3, p5
endin

instr loserInTheEndBreakPan
    gkloserInTheEndBreakPan linseg p4, p3, p5
endin

instr loserInTheEndBreakMixerChannel
    aloserInTheEndBreakL inleta "loserInTheEndBreakInL"
    aloserInTheEndBreakR inleta "loserInTheEndBreakInR"

    kloserInTheEndBreakFader = gkloserInTheEndBreakFader
    kloserInTheEndBreakPan = gkloserInTheEndBreakPan
    kloserInTheEndBreakEqBass = gkloserInTheEndBreakEqBass
    kloserInTheEndBreakEqMid = gkloserInTheEndBreakEqMid
    kloserInTheEndBreakEqHigh = gkloserInTheEndBreakEqHigh

    aloserInTheEndBreakL, aloserInTheEndBreakR threeBandEqStereo aloserInTheEndBreakL, aloserInTheEndBreakR, kloserInTheEndBreakEqBass, kloserInTheEndBreakEqMid, kloserInTheEndBreakEqHigh

    if kloserInTheEndBreakPan > 100 then
        kloserInTheEndBreakPan = 100
    elseif kloserInTheEndBreakPan < 0 then
        kloserInTheEndBreakPan = 0
    endif

    aloserInTheEndBreakL = (aloserInTheEndBreakL * ((100 - kloserInTheEndBreakPan) * 2 / 100)) * kloserInTheEndBreakFader
    aloserInTheEndBreakR = (aloserInTheEndBreakR * (kloserInTheEndBreakPan * 2 / 100)) * kloserInTheEndBreakFader

    outleta "loserInTheEndBreakOutL", aloserInTheEndBreakL
    outleta "loserInTheEndBreakOutR", aloserInTheEndBreakR
endin

