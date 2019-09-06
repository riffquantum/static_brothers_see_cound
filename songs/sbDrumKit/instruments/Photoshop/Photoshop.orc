connect "Photoshop", "PhotoshopOutL", "PhotoshopMixerChannel", "PhotoshopInL"
connect "Photoshop", "PhotoshopOutR", "PhotoshopMixerChannel", "PhotoshopInR"

connect "PhotoshopMixerChannel", "PhotoshopOutL", "Mixer", "MixerInL"
connect "PhotoshopMixerChannel", "PhotoshopOutR", "Mixer", "MixerInR"

alwayson "PhotoshopMixerChannel"

gkPhotoshopEqBass init 1
gkPhotoshopEqMid init 1
gkPhotoshopEqHigh init 1
gkPhotoshopFader init 1
gkPhotoshopPan init 50

/* MIDI Config Values */
;massign giPhotoshopMidiChannel, "Photoshop"

instr Photoshop
    SFilePath = "localSamples/glitch2.wav"
    iLengthOfSample filelen SFilePath
    iNumberOfChannels filenchnls SFilePath


    ifreq flexiblePitchInput p5

    ifreq = ifreq / 261.6 ; Ratio of frequency to Middle C
    kPitchBend = 0
    midipitchbend kPitchBend

    kfreq = ifreq + kPitchBend

    iAmplitude flexibleAmplitudeInput p4

    kAmplitudeEnvelope madsr .005, .01, iAmplitude, .05, 0, (iLengthOfSample) ;Sample plays for note duration
    ;kAmplitudeEnvelope linenr iAmplitude, .05, (iLengthOfSample * 1/ifreq), 1 ; Sample plays through entirely

    if iNumberOfChannels == 2 then
      aOutL, aOutR diskin SFilePath, kfreq, 0, 0

      aOutL = kAmplitudeEnvelope * aOutL
      aOutR = kAmplitudeEnvelope * aOutR

    elseif iNumberOfChannels == 1 then
      aOut diskin SFilePath, kfreq, 0, 0

      aOutL = kAmplitudeEnvelope * aOut
      aOutR = kAmplitudeEnvelope * aOut
    endif

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
