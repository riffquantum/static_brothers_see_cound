gSPhotoshopName = "Photoshop"
gSPhotoshopRoute = "Mixer"
instrumentRoute gSPhotoshopName, gSPhotoshopRoute

alwayson "PhotoshopMixerChannel"

gkPhotoshopEqBass init 1
gkPhotoshopEqMid init 1
gkPhotoshopEqHigh init 1
gkPhotoshopFader init 1
gkPhotoshopPan init 50

/* MIDI Config Values */
giPhotoshopMidiChannel = 10
massign giPhotoshopMidiChannel, "Photoshop"

gSPhotoshopFilePath = "localSamples/photoshop.wav"
giPhotoshopLengthOfSample filelen gSPhotoshopFilePath
giPhotoshopSampleStartTime = giPhotoshopLengthOfSample * .0435
giPhotoshopSampleLength = sr*1
giPhotoshopSampleTable ftgenonce 0, 0, giPhotoshopSampleLength, 1, gSPhotoshopFilePath, giPhotoshopSampleStartTime, 0, 0
giPhotoshopEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

instr Photoshop
    kAmplitudeEnvelope madsr .005, .01, flexibleAmplitudeInput(p4), 1.7
    iFrequency = flexiblePitchInput(p5) / 261.6 ; Ratio of frequency to Middle C
    iGrainAmplitude = 1
    iTimeStretch = 1
    iStartTime = 0
    iWindowSize = 3000
    iWindowRandomization = iWindowSize
    iOverlaps = 50
    iTimeMode = 0

    aOutL, aOutR sndwarp iGrainAmplitude, iTimeStretch, iFrequency, giPhotoshopSampleTable, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, giPhotoshopEnvelopeTable, iTimeMode

    aOutL = kAmplitudeEnvelope * aOutL
    aOutR = kAmplitudeEnvelope * aOutR

    outleta "PhotoshopOutL", aOutL
    outleta "PhotoshopOutR", aOutR
endin

instr PhotoshopBassKnob
    gkPhotoshopEqBass linseg p4, p3, p5
endin

instr PhotoshopMidKnob
    gkPhotoshopEqMid linseg p4, p3, p5
endin

instr PhotoshopHighKnob
    gkPhotoshopEqHigh linseg p4, p3, p5
endin

instr PhotoshopFader
    gkPhotoshopFader linseg p4, p3, p5
endin

instr PhotoshopPan
    gkPhotoshopPan linseg p4, p3, p5
endin

instr PhotoshopMixerChannel
    aPhotoshopL inleta "PhotoshopInL"
    aPhotoshopR inleta "PhotoshopInR"

    kPhotoshopFader = gkPhotoshopFader
    kPhotoshopPan = gkPhotoshopPan
    kPhotoshopEqBass = gkPhotoshopEqBass
    kPhotoshopEqMid = gkPhotoshopEqMid
    kPhotoshopEqHigh = gkPhotoshopEqHigh

    aPhotoshopL, aPhotoshopR threeBandEqStereo aPhotoshopL, aPhotoshopR, kPhotoshopEqBass, kPhotoshopEqMid, kPhotoshopEqHigh

    if kPhotoshopPan > 100 then
        kPhotoshopPan = 100
    elseif kPhotoshopPan < 0 then
        kPhotoshopPan = 0
    endif

    aPhotoshopL = (aPhotoshopL * ((100 - kPhotoshopPan) * 2 / 100)) * kPhotoshopFader
    aPhotoshopR = (aPhotoshopR * (kPhotoshopPan * 2 / 100)) * kPhotoshopFader

    outleta "PhotoshopOutL", aPhotoshopL
    outleta "PhotoshopOutR", aPhotoshopR
endin
