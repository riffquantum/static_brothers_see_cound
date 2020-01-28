/* walkInTheSoftRainSample
    A set of sampling instruments each using different opcodes for playing and manipulating the intro break from Sinking by The cure. This file differs from the other break instruments in that each primary instrument requries you to select a segment. There are two variations of the sample included.

    Sample Source: Put The Hand In The Hand - Elvis Presley
    BPM: ~112
    Length: 4 or 8 beats
*/

connect "walkInTheSoftRainSampleDiskin", "walkInTheSoftRainSampleOutL", "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleInL"
connect "walkInTheSoftRainSampleDiskin", "walkInTheSoftRainSampleOutR", "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleInR"

connect "walkInTheSoftRainSampleDiskgrain", "walkInTheSoftRainSampleOutL", "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleInL"
connect "walkInTheSoftRainSampleDiskgrain", "walkInTheSoftRainSampleOutR", "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleInR"

connect "walkInTheSoftRainSampleSndwarp", "walkInTheSoftRainSampleOutL", "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleInL"
connect "walkInTheSoftRainSampleSndwarp", "walkInTheSoftRainSampleOutR", "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleInR"

connect "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleOutL", "Mixer", "MixerInL"
connect "walkInTheSoftRainSampleMixerChannel", "walkInTheSoftRainSampleOutR", "Mixer", "MixerInR"

alwayson "walkInTheSoftRainSampleMixerChannel"

gkwalkInTheSoftRainSampleEqBass init 1
gkwalkInTheSoftRainSampleEqMid init 1
gkwalkInTheSoftRainSampleEqHigh init 1
gkwalkInTheSoftRainSampleFader init 1
gkwalkInTheSoftRainSamplePan init 50

giwalkInTheSoftRainSampleSegmentBPMs[] fillarray 113, 113
giwalkInTheSoftRainSampleSegmentLengths[] fillarray 32, 64

instr walkInTheSoftRainSampleDiskin
    gkPitchEnvelope linseg .99, 1, 1.01, .1, 1

    iSkipTimeInBeats = p4
    iSampleSegment = p5
    SwalkInTheSoftRainFilePath sprintfk "localSamples/walkInTheSoftRain%i.wav", iSampleSegment

    iFileLength filelen SwalkInTheSoftRainFilePath
    iSampleLengthInBeats = giwalkInTheSoftRainSampleSegmentLengths[iSampleSegment]


    iwalkInTheSoftRainLengthofBeat = iFileLength / iSampleLengthInBeats
    iwalkInTheSoftRainSampleBPM = 60 / iwalkInTheSoftRainLengthofBeat

    iwalkInTheSoftRainFactor = i(gkBPM) / iwalkInTheSoftRainSampleBPM
    kpitch = iwalkInTheSoftRainFactor

    iSkipTime = iFileLength / iSampleLengthInBeats * iSkipTimeInBeats

    iwraparound= 1
    iformat = 0
    iskipinit = 0

    awalkInTheSoftRainL, awalkInTheSoftRainR diskin SwalkInTheSoftRainFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    outleta "walkInTheSoftRainSampleOutL", awalkInTheSoftRainL
    outleta "walkInTheSoftRainSampleOutR", awalkInTheSoftRainR

endin

instr walkInTheSoftRainSampleDiskgrain
    iSampleSegment = p8

    SwalkInTheSoftRainFilePath sprintfk "instruments/walkInTheSoftRainSample/walkInTheSoftRainSample%i.wav", iSampleSegment
    iFileLength filelen SwalkInTheSoftRainFilePath
    iwalkInTheSoftRainSampleBPM = giwalkInTheSoftRainSampleSegmentBPMs[iSampleSegment]
    iSampleLength = giwalkInTheSoftRainSampleSegmentLengths[iSampleSegment]
    iwalkInTheSoftRainFactor = i(gkBPM) / iwalkInTheSoftRainSampleBPM

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kamplitude = p4
    iTimeFactor = p5 * iwalkInTheSoftRainFactor
    kpitch = p6
    iskipTimeInBeats = p7

    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iFileLength / iSampleLength * iskipTimeInBeats

    awalkInTheSoftRainL, awalkInTheSoftRainR diskgrain SwalkInTheSoftRainFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "walkInTheSoftRainSampleOutL", awalkInTheSoftRainL
    outleta "walkInTheSoftRainSampleOutR", awalkInTheSoftRainR

endin

instr walkInTheSoftRainSampleSndwarp
    iSampleSegment = p9

    SwalkInTheSoftRainFilePath sprintfk "instruments/walkInTheSoftRainSample/walkInTheSoftRainSample%i.wav", iSampleSegment
    iFileLength filelen SwalkInTheSoftRainFilePath
    iwalkInTheSoftRainSampleBPM = giwalkInTheSoftRainSampleSegmentBPMs[iSampleSegment]
    iSampleLength = giwalkInTheSoftRainSampleSegmentLengths[iSampleSegment]
    iwalkInTheSoftRainFactor = i(gkBPM) / iwalkInTheSoftRainSampleBPM

    kamplitude = p4
    ktimewarp = p5 * (1/iwalkInTheSoftRainFactor)
    kresample = p6
    iskipTimeInBeats = p7
    ioverlap = p8

    iwalkInTheSoftRainFileSampleRate filesr SwalkInTheSoftRainFilePath
    iwalkInTheSoftRainTableLength getTableSizeFromSample SwalkInTheSoftRainFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iwalkInTheSoftRainTable ftgenonce 0, 0, iwalkInTheSoftRainTableLength, 1, SwalkInTheSoftRainFilePath, 0, 0, 0

    isampleTable = iwalkInTheSoftRainTable
    ibeginningTime =  iFileLength / iSampleLength * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    awalkInTheSoftRainL, awalkInTheSoftRainR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "walkInTheSoftRainSampleOutL", awalkInTheSoftRainL
    outleta "walkInTheSoftRainSampleOutR", awalkInTheSoftRainR

endin

instr walkInTheSoftRainSampleBassKnob
    gkwalkInTheSoftRainSampleEqBass linseg p4, p3, p5
endin

instr walkInTheSoftRainSampleMidKnob
    gkwalkInTheSoftRainSampleEqMid linseg p4, p3, p5
endin

instr walkInTheSoftRainSampleHighKnob
    gkwalkInTheSoftRainSampleEqHigh linseg p4, p3, p5
endin

instr walkInTheSoftRainSampleFader
    gkwalkInTheSoftRainSampleFader linseg p4, p3, p5
endin

instr walkInTheSoftRainSamplePan
    gkwalkInTheSoftRainSamplePan linseg p4, p3, p5
endin

instr walkInTheSoftRainSampleMixerChannel
    awalkInTheSoftRainSampleL inleta "walkInTheSoftRainSampleInL"
    awalkInTheSoftRainSampleR inleta "walkInTheSoftRainSampleInR"

    kwalkInTheSoftRainSampleFader = gkwalkInTheSoftRainSampleFader
    kwalkInTheSoftRainSamplePan = gkwalkInTheSoftRainSamplePan
    kwalkInTheSoftRainSampleEqBass = gkwalkInTheSoftRainSampleEqBass
    kwalkInTheSoftRainSampleEqMid = gkwalkInTheSoftRainSampleEqMid
    kwalkInTheSoftRainSampleEqHigh = gkwalkInTheSoftRainSampleEqHigh

    awalkInTheSoftRainSampleL, awalkInTheSoftRainSampleR threeBandEqStereo awalkInTheSoftRainSampleL, awalkInTheSoftRainSampleR, kwalkInTheSoftRainSampleEqBass, kwalkInTheSoftRainSampleEqMid, kwalkInTheSoftRainSampleEqHigh



    awalkInTheSoftRainSampleR pitchShifter awalkInTheSoftRainSampleR, gkPitchEnvelope, 0, 1
    awalkInTheSoftRainSampleL pitchShifter awalkInTheSoftRainSampleL, gkPitchEnvelope, 0, 1
    /*awalkInTheSoftRainSample1L pitchShifter awalkInTheSoftRainSampleL, 1.3, 0, 1
    awalkInTheSoftRainSample2R pitchShifter awalkInTheSoftRainSampleR, .8, 0, 1
    awalkInTheSoftRainSample3L pitchShifter awalkInTheSoftRainSampleL, 1.5, 0, 2
    awalkInTheSoftRainSample3R pitchShifter awalkInTheSoftRainSampleR, 1.5, 0, 2
    awalkInTheSoftRainSampleR = awalkInTheSoftRainSample1R + awalkInTheSoftRainSample2R + awalkInTheSoftRainSample3R
    awalkInTheSoftRainSampleL = awalkInTheSoftRainSample1L + awalkInTheSoftRainSample2L + awalkInTheSoftRainSample3L
    */

    if kwalkInTheSoftRainSamplePan > 100 then
        kwalkInTheSoftRainSamplePan = 100
    elseif kwalkInTheSoftRainSamplePan < 0 then
        kwalkInTheSoftRainSamplePan = 0
    endif

    awalkInTheSoftRainSampleL = (awalkInTheSoftRainSampleL * ((100 - kwalkInTheSoftRainSamplePan) * 2 / 100)) * kwalkInTheSoftRainSampleFader
    awalkInTheSoftRainSampleR = (awalkInTheSoftRainSampleR * (kwalkInTheSoftRainSamplePan * 2 / 100)) * kwalkInTheSoftRainSampleFader

    outleta "walkInTheSoftRainSampleOutL", awalkInTheSoftRainSampleL
    outleta "walkInTheSoftRainSampleOutR", awalkInTheSoftRainSampleR
endin

