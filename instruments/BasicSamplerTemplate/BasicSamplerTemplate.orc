gSBasicSamplerTemplateName = "BasicSamplerTemplate"
gSBasicSamplerTemplateRoute = "Delay"
instrumentRoute gSBasicSamplerTemplateName, gSBasicSamplerTemplateRoute

alwayson "BasicSamplerTemplateMixerChannel"

gkBasicSamplerTemplateEqBass init 1
gkBasicSamplerTemplateEqMid init 1
gkBasicSamplerTemplateEqHigh init 1
gkBasicSamplerTemplateFader init 1
gkBasicSamplerTemplatePan init 50

/* MIDI Config Values */
massign giBasicSamplerTemplateMidiChannel, "BasicSamplerTemplate"

instr BasicSamplerTemplate
    SFilePath = "localSamples/bell.wav"
    iLengthOfSample filelen SFilePath
    iNumberOfChannels filenchnls SFilePath


    ifreq flexiblePitchInput p5

    ifreq = ifreq / 261.6 ; Ratio of frequency to Middle C
    kPitchBend = 0
    midipitchbend kPitchBend

    kfreq = ifreq + kPitchBend

    iAmplitude flexibleAmplitudeInput p4

    kAmplitudeEnvelope madsr .005, .01, iAmplitude, .05, 0, (iLengthOfSample) ;Sample plays for note duration
    ; kAmplitudeEnvelope linenr iAmplitude, .05, (iLengthOfSample * 1/ifreq), 1 ; Sample plays through entirely

    if iNumberOfChannels == 2 then
      aOutL, aOutR diskin SFilePath, kfreq, 0, 0

      aOutL = kAmplitudeEnvelope * aOutL
      aOutR = kAmplitudeEnvelope * aOutR

    elseif iNumberOfChannels == 1 then
      aOut diskin SFilePath, kfreq, 0, 0

      aOutL = kAmplitudeEnvelope * aOut
      aOutR = kAmplitudeEnvelope * aOut
    endif

    outleta "BasicSamplerTemplateOutL", aOutL
    outleta "BasicSamplerTemplateOutR", aOutR
endin

instr BasicSamplerTemplateBassKnob
    gkBasicSamplerTemplateEqBass linseg p4, p3, p5
endin

instr BasicSamplerTemplateMidKnob
    gkBasicSamplerTemplateEqMid linseg p4, p3, p5
endin

instr BasicSamplerTemplateHighKnob
    gkBasicSamplerTemplateEqHigh linseg p4, p3, p5
endin

instr BasicSamplerTemplateFader
    gkBasicSamplerTemplateFader linseg p4, p3, p5
endin

instr BasicSamplerTemplatePan
    gkBasicSamplerTemplatePan linseg p4, p3, p5
endin

instr BasicSamplerTemplateMixerChannel
    aBasicSamplerTemplateL inleta "BasicSamplerTemplateInL"
    aBasicSamplerTemplateR inleta "BasicSamplerTemplateInR"

    kBasicSamplerTemplateFader = gkBasicSamplerTemplateFader
    kBasicSamplerTemplatePan = gkBasicSamplerTemplatePan
    kBasicSamplerTemplateEqBass = gkBasicSamplerTemplateEqBass
    kBasicSamplerTemplateEqMid = gkBasicSamplerTemplateEqMid
    kBasicSamplerTemplateEqHigh = gkBasicSamplerTemplateEqHigh

    aBasicSamplerTemplateL, aBasicSamplerTemplateR threeBandEqStereo aBasicSamplerTemplateL, aBasicSamplerTemplateR, kBasicSamplerTemplateEqBass, kBasicSamplerTemplateEqMid, kBasicSamplerTemplateEqHigh

    if kBasicSamplerTemplatePan > 100 then
        kBasicSamplerTemplatePan = 100
    elseif kBasicSamplerTemplatePan < 0 then
        kBasicSamplerTemplatePan = 0
    endif

    aBasicSamplerTemplateL = (aBasicSamplerTemplateL * ((100 - kBasicSamplerTemplatePan) * 2 / 100)) * kBasicSamplerTemplateFader
    aBasicSamplerTemplateR = (aBasicSamplerTemplateR * (kBasicSamplerTemplatePan * 2 / 100)) * kBasicSamplerTemplateFader

    outleta "BasicSamplerTemplateOutL", aBasicSamplerTemplateL
    outleta "BasicSamplerTemplateOutR", aBasicSamplerTemplateR
endin
