/* amenBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from Horizontal Key, Vertical Gate by Dendritic Arbor.

    Sample Source: Horizontal Key, Vertical Gate by Dendritic Arbor

    Length: 8 beats
*/

connect "KeyGateBreakDiskin", "KeyGateBreakOutL", "KeyGateBreakMixerChannel", "KeyGateBreakInL"
connect "KeyGateBreakDiskin", "KeyGateBreakOutR", "KeyGateBreakMixerChannel", "KeyGateBreakInR"

connect "KeyGateBreakDiskgrain", "KeyGateBreakOutL", "KeyGateBreakMixerChannel", "KeyGateBreakInL"
connect "KeyGateBreakDiskgrain", "KeyGateBreakOutR", "KeyGateBreakMixerChannel", "KeyGateBreakInR"

connect "KeyGateBreakSndwarp", "KeyGateBreakOutL", "KeyGateBreakMixerChannel", "KeyGateBreakInL"
connect "KeyGateBreakSndwarp", "KeyGateBreakOutR", "KeyGateBreakMixerChannel", "KeyGateBreakInR"

alwayson "KeyGateBreakMixerChannel"

gkKeyGateBreakEqBass init 1
gkKeyGateBreakEqMid init 1
gkKeyGateBreakEqHigh init 1
gkKeyGateBreakFader init 1
gkKeyGateBreakPan init 50



instr KeyGateBreakDiskin
    iSkipTimeInBeats = p4
    iBreakSegment = p5
    kpitchFactor = p6
    SKeyGateFilePath sprintfk "instruments/breakBeatInstruments/KeyGateBreak/KeyGateBreak%i.wav", iBreakSegment

    aKeyGateL, aKeyGateR breakSamplerDiskin SKeyGateFilePath, 4, iSkipTimeInBeats, kpitchFactor

    outleta "KeyGateBreakOutL", aKeyGateL
    outleta "KeyGateBreakOutR", aKeyGateR

endin

instr KeyGateBreakDiskgrain
    iBreakSegment = p8
    SKeyGateFilePath sprintfk "instruments/breakBeatInstruments/keyGateBreak/keyGateBreak%i.wav", iBreakSegment
    iKeyGateFileLength filelen SKeyGateFilePath
    iKeyGateLengthOfBeat = iKeyGateFileLength / 4
    iKeyGateBreakBPM init 60 / iKeyGateLengthOfBeat
    iKeyGateFactor = giBPM / iKeyGateBreakBPM

    kamplitude = p4
    kpitchFactor = p5

    if kpitchFactor==0 then
      kpitchFactor = 1
    endif
    kTimeFactor = kpitchFactor * iKeyGateFactor
    kpitch = p6
    iskipTimeInBeats = p7

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * kTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iKeyGateLengthOfBeat * iskipTimeInBeats

    aKeyGateL, aKeyGateR diskgrain SKeyGateFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "KeyGateBreakOutL", aKeyGateL
    outleta "KeyGateBreakOutR", aKeyGateR
endin

instr KeyGateBreakSndwarp
    iBreakSegment = p9
    SKeyGateFilePath sprintfk "instruments/breakBeatInstruments/keyGateBreak/keyGateBreak%i.wav", iBreakSegment
    iKeyGateFileLength filelen SKeyGateFilePath
    iKeyGateLengthOfBeat = iKeyGateFileLength / 4
    iKeyGateBreakBPM init 60 / iKeyGateLengthOfBeat
    iKeyGateFactor = giBPM / iKeyGateBreakBPM

    iKeyGateFileSampleRate filesr SKeyGateFilePath
    iKeyGateTableLength getTableSizeFromSample SKeyGateFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iKeyGateTable ftgenonce 0, 0, iKeyGateTableLength, 1, SKeyGateFilePath, 0, 0, 0

    kamplitude = p4
    kpitchFactor = p5

    if kpitchFactor==0 then
      kpitchFactor = 1
    endif
    ktimewarp = kpitchFactor * (1/iKeyGateFactor)
    kresample = p6
    isampleTable = iKeyGateTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  iKeyGateLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    aKeyGateL, aKeyGateR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "KeyGateBreakOutL", aKeyGateL
    outleta "KeyGateBreakOutR", aKeyGateR

endin

instr KeyGateBreakBassKnob
    gkKeyGateBreakEqBass linseg p4, p3, p5
endin

instr KeyGateBreakMidKnob
    gkKeyGateBreakEqMid linseg p4, p3, p5
endin

instr KeyGateBreakHighKnob
    gkKeyGateBreakEqHigh linseg p4, p3, p5
endin

instr KeyGateBreakFader
    gkKeyGateBreakFader linseg p4, p3, p5
endin

instr KeyGateBreakPan
    gkKeyGateBreakPan linseg p4, p3, p5
endin

instr KeyGateBreakMixerChannel
    aKeyGateBreakL inleta "KeyGateBreakInL"
    aKeyGateBreakR inleta "KeyGateBreakInR"

    kKeyGateBreakFader = gkKeyGateBreakFader
    kKeyGateBreakPan = gkKeyGateBreakPan
    kKeyGateBreakEqBass = gkKeyGateBreakEqBass
    kKeyGateBreakEqMid = gkKeyGateBreakEqMid
    kKeyGateBreakEqHigh = gkKeyGateBreakEqHigh

    aKeyGateBreakL, aKeyGateBreakR threeBandEqStereo aKeyGateBreakL, aKeyGateBreakR, kKeyGateBreakEqBass, kKeyGateBreakEqMid, kKeyGateBreakEqHigh

    if kKeyGateBreakPan > 100 then
        kKeyGateBreakPan = 100
    elseif kKeyGateBreakPan < 0 then
        kKeyGateBreakPan = 0
    endif

    aKeyGateBreakL = (aKeyGateBreakL * ((100 - kKeyGateBreakPan) * 2 / 100)) * kKeyGateBreakFader
    aKeyGateBreakR = (aKeyGateBreakR * (kKeyGateBreakPan * 2 / 100)) * kKeyGateBreakFader

    outleta "KeyGateBreakOutL", aKeyGateBreakL
    outleta "KeyGateBreakOutR", aKeyGateBreakR
endin

