instrumentRoute "InTimeSamplerTemplate", "Mixer"

alwayson "InTimeSamplerTemplateMixerChannel"

gkInTimeSamplerTemplateEqBass init 1
gkInTimeSamplerTemplateEqMid init 1
gkInTimeSamplerTemplateEqHigh init 1
gkInTimeSamplerTemplateFader init 1
gkInTimeSamplerTemplatePan init 50

/* MIDI Config Values */
massign giInTimeSamplerTemplateMidiChannel, "InTimeSamplerTemplate"

gSInTimeSamplerTemplateSamplePath = "instruments/breakBeatInstruments/amen-break.wav"
giInTimeSamplerTemplateSampleChannels filenchnls gSInTimeSamplerTemplateSamplePath
giInTimeSamplerTemplateSampleLength filelen gSInTimeSamplerTemplateSamplePath
giInTimeSamplerTemplateSampleLengthInBeats = 16
giInTimeSamplerTemplateLengthOfBeat = giInTimeSamplerTemplateSampleLength / giInTimeSamplerTemplateSampleLengthInBeats
giInTimeSamplerTemplateLengthBPM init 60 /giInTimeSamplerTemplateLengthOfBeat
giInTimeSamplerTemplateLengthOfBeatFactor = i(gkBPM) / giInTimeSamplerTemplateLengthBPM
giInTimeSamplerTemplateSample ftgen 0, 0, 0, 1, gSInTimeSamplerTemplateSamplePath, 0, 0, 0

instr InTimeSamplerTemplate
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5)/261.1 * giInTimeSamplerTemplateLengthOfBeatFactor
  iPitch = iPitch == 0 ? 1 : iPitch
  iStartBeat = p6
  iEndBeat = p7
  kAmplitudeEnvelope madsr .005, .01, flexibleAmplitudeInput(p4), .01
  iBasePitch = 1
  iLoopingMode = 1 ; 1: normal looping 2: forward & backward looping 0: no looping.
  iStartTimeInSamples = iStartBeat * giInTimeSamplerTemplateLengthOfBeat * sr
  iEndTimeInSamples = iEndBeat * giInTimeSamplerTemplateLengthOfBeat * sr

  if giInTimeSamplerTemplateSampleChannels = 2 then
    aInTimeSamplerTemplateL, aInTimeSamplerTemplateR loscil kAmplitudeEnvelope, iPitch, giInTimeSamplerTemplateSample, iBasePitch, iLoopingMode, iStartTimeInSamples, iEndTimeInSamples
  else
    aInTimeSamplerTemplateL loscil kAmplitudeEnvelope, iPitch, giInTimeSamplerTemplateSample, iBasePitch, iLoopingMode, iStartTimeInSamples, iEndTimeInSamples
    aInTimeSamplerTemplateR = aInTimeSamplerTemplateL
  endif

  outleta "OutL", aInTimeSamplerTemplateL
  outleta "OutR", aInTimeSamplerTemplateR
endin

instr InTimeSamplerTemplateBassKnob
  gkInTimeSamplerTemplateEqBass linseg p4, p3, p5
endin

instr InTimeSamplerTemplateMidKnob
  gkInTimeSamplerTemplateEqMid linseg p4, p3, p5
endin

instr InTimeSamplerTemplateHighKnob
  gkInTimeSamplerTemplateEqHigh linseg p4, p3, p5
endin

instr InTimeSamplerTemplateFader
  gkInTimeSamplerTemplateFader linseg p4, p3, p5
endin

instr InTimeSamplerTemplatePan
  gkInTimeSamplerTemplatePan linseg p4, p3, p5
endin

instr InTimeSamplerTemplateMixerChannel
  aInTimeSamplerTemplateL inleta "InL"
  aInTimeSamplerTemplateR inleta "InR"

  aInTimeSamplerTemplateL, aInTimeSamplerTemplateR mixerChannel aInTimeSamplerTemplateL, aInTimeSamplerTemplateR, gkInTimeSamplerTemplateFader, gkInTimeSamplerTemplatePan, gkInTimeSamplerTemplateEqBass, gkInTimeSamplerTemplateEqMid, gkInTimeSamplerTemplateEqHigh

  outleta "OutL", aInTimeSamplerTemplateL
  outleta "OutR", aInTimeSamplerTemplateR
endin

