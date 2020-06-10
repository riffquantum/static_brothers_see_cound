instrumentRoute "BasicSamplerTemplate", "Delay"
alwayson "BasicSamplerTemplateMixerChannel"

gkBasicSamplerTemplateEqBass init 1
gkBasicSamplerTemplateEqMid init 1
gkBasicSamplerTemplateEqHigh init 1
gkBasicSamplerTemplateFader init 1
gkBasicSamplerTemplatePan init 50

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

  outleta "OutL", aOutL
  outleta "OutR", aOutR
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
  aBasicSamplerTemplateL inleta "InL"
  aBasicSamplerTemplateR inleta "InR"

  aBasicSamplerTemplateL, aBasicSamplerTemplateR mixerChannel aBasicSamplerTemplateL, aBasicSamplerTemplateR, gkBasicSamplerTemplateFader, gkBasicSamplerTemplatePan, gkBasicSamplerTemplateEqBass, gkBasicSamplerTemplateEqMid, gkBasicSamplerTemplateEqHigh

  outleta "OutL", aBasicSamplerTemplateL
  outleta "OutR", aBasicSamplerTemplateR
endin
