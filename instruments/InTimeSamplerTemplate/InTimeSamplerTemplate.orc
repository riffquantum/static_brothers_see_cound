gSInTimeSamplerTemplateName = "InTimeSamplerTemplate"
gSInTimeSamplerTemplateRoute = "Mixer"
instrumentRoute gSInTimeSamplerTemplateName, gSInTimeSamplerTemplateRoute

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

  outleta "InTimeSamplerTemplateOutL", aInTimeSamplerTemplateL
  outleta "InTimeSamplerTemplateOutR", aInTimeSamplerTemplateR
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
  aInTimeSamplerTemplateL inleta "InTimeSamplerTemplateInL"
  aInTimeSamplerTemplateR inleta "InTimeSamplerTemplateInR"

  kInTimeSamplerTemplateFader = gkInTimeSamplerTemplateFader
  kInTimeSamplerTemplatePan = gkInTimeSamplerTemplatePan
  kInTimeSamplerTemplateEqBass = gkInTimeSamplerTemplateEqBass
  kInTimeSamplerTemplateEqMid = gkInTimeSamplerTemplateEqMid
  kInTimeSamplerTemplateEqHigh = gkInTimeSamplerTemplateEqHigh

  aInTimeSamplerTemplateL, aInTimeSamplerTemplateR threeBandEqStereo aInTimeSamplerTemplateL, aInTimeSamplerTemplateR, kInTimeSamplerTemplateEqBass, kInTimeSamplerTemplateEqMid, kInTimeSamplerTemplateEqHigh

  if kInTimeSamplerTemplatePan > 100 then
      kInTimeSamplerTemplatePan = 100
  elseif kInTimeSamplerTemplatePan < 0 then
      kInTimeSamplerTemplatePan = 0
  endif

  aInTimeSamplerTemplateL = (aInTimeSamplerTemplateL * ((100 - kInTimeSamplerTemplatePan) * 2 / 100)) * kInTimeSamplerTemplateFader
  aInTimeSamplerTemplateR = (aInTimeSamplerTemplateR * (kInTimeSamplerTemplatePan * 2 / 100)) * kInTimeSamplerTemplateFader

  outleta "InTimeSamplerTemplateOutL", aInTimeSamplerTemplateL
  outleta "InTimeSamplerTemplateOutR", aInTimeSamplerTemplateR
endin

