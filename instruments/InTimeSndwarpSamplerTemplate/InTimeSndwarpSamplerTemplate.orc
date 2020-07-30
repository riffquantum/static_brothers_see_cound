instrumentRoute "InTimeSndwarpSamplerTemplate", "Mixer"

alwayson "InTimeSndwarpSamplerTemplateMixerChannel"

gkInTimeSndwarpSamplerTemplateEqBass init 1
gkInTimeSndwarpSamplerTemplateEqMid init 1
gkInTimeSndwarpSamplerTemplateEqHigh init 1
gkInTimeSndwarpSamplerTemplateFader init 1
gkInTimeSndwarpSamplerTemplatePan init 50

gSInTimeSndwarpSamplerTemplateSamplePath = "instruments/breakBeatInstruments/AmenBreak.wav"
giInTimeSndwarpSamplerTemplateChannels filenchnls gSInTimeSndwarpSamplerTemplateSamplePath
giInTimeSndwarpSamplerTemplateSampleLength filelen gSInTimeSndwarpSamplerTemplateSamplePath
giInTimeSndwarpSamplerTemplateSampleLengthInBeats = 16
giInTimeSndwarpSamplerTemplateSLengthOfBeat = giInTimeSndwarpSamplerTemplateSampleLength / giInTimeSndwarpSamplerTemplateSampleLengthInBeats
giInTimeSndwarpSamplerTemplateBPM init 60 /giInTimeSndwarpSamplerTemplateSLengthOfBeat
giInTimeSndwarpSamplerTemplateFactor = i(gkBPM) / giInTimeSndwarpSamplerTemplateBPM
giInTimeSndwarpSamplerTemplateSample ftgen 0, 0, 0, 1, gSInTimeSndwarpSamplerTemplateSamplePath, 0, 0, 0
giInTimeSndwarpSamplerTemplateEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0

instr InTimeSndwarpSamplerTemplate
  iAmplitude = flexibleAmplitudeInput(p4)
  kAmplitudeEnvelope = madsr(.005, .01, 1, .01) * iAmplitude
  iFrequency = flexiblePitchInput(p5) / 261.6 ; Ratio of frequency to Middle C
  iGrainAmplitude = 1
  iStartTime = p6
  iTimeStretch = p7
  iTimeStretch = iTimeStretch == 0 ? 1/giInTimeSndwarpSamplerTemplateFactor : 1/giInTimeSndwarpSamplerTemplateFactor * iTimeStretch
  iWindowSize = 3000
  iWindowRandomization = iWindowSize * 2
  iOverlaps = 50
  iTimeMode = 0

  if giInTimeSndwarpSamplerTemplateChannels == 2 then
    aInTimeSndwarpSamplerTemplateL, aInTimeSndwarpSamplerTemplateR sndwarpst iGrainAmplitude, iTimeStretch, iFrequency, giInTimeSndwarpSamplerTemplateSample, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, giInTimeSndwarpSamplerTemplateEnvelopeTable, iTimeMode
  else
    aInTimeSndwarpSamplerTemplateL sndwarp iGrainAmplitude, iTimeStretch, iFrequency, giInTimeSndwarpSamplerTemplateSample, iStartTime, iWindowSize, iWindowRandomization, iOverlaps, giInTimeSndwarpSamplerTemplateEnvelopeTable, iTimeMode
    aInTimeSndwarpSamplerTemplateR = aInTimeSndwarpSamplerTemplateL
  endif

  aInTimeSndwarpSamplerTemplateL = kAmplitudeEnvelope * aInTimeSndwarpSamplerTemplateL
  aInTimeSndwarpSamplerTemplateR = kAmplitudeEnvelope * aInTimeSndwarpSamplerTemplateR

  outleta "OutL", aInTimeSndwarpSamplerTemplateL
  outleta "OutR", aInTimeSndwarpSamplerTemplateR
endin

instr InTimeSndwarpSamplerTemplateBassKnob
  gkInTimeSndwarpSamplerTemplateEqBass linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplateMidKnob
  gkInTimeSndwarpSamplerTemplateEqMid linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplateHighKnob
  gkInTimeSndwarpSamplerTemplateEqHigh linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplateFader
  gkInTimeSndwarpSamplerTemplateFader linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplatePan
  gkInTimeSndwarpSamplerTemplatePan linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplateMixerChannel
  aInTimeSndwarpSamplerTemplateL inleta "InL"
  aInTimeSndwarpSamplerTemplateR inleta "InR"

  aInTimeSndwarpSamplerTemplateL, aInTimeSndwarpSamplerTemplateR mixerChannel aInTimeSndwarpSamplerTemplateL, aInTimeSndwarpSamplerTemplateR, gkInTimeSndwarpSamplerTemplateFader, gkInTimeSndwarpSamplerTemplatePan, gkInTimeSndwarpSamplerTemplateEqBass, gkInTimeSndwarpSamplerTemplateEqMid, gkInTimeSndwarpSamplerTemplateEqHigh

  outleta "OutL", aInTimeSndwarpSamplerTemplateL
  outleta "OutR", aInTimeSndwarpSamplerTemplateR
endin
