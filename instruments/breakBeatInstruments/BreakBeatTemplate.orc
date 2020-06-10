gSBreakBeatTemplateName = "BreakBeatTemplate"
gSBreakBeatTemplateRoute = "Mixer"
instrumentRoute gSBreakBeatTemplateName, gSBreakBeatTemplateRoute

alwayson "BreakBeatTemplateMixerChannel"

gkBreakBeatTemplateEqBass init 1
gkBreakBeatTemplateEqMid init 1
gkBreakBeatTemplateEqHigh init 1
gkBreakBeatTemplateFader init 1
gkBreakBeatTemplatePan init 50


gSBreakBeatTemplateFilePath init "instruments/breakBeatInstruments/amen-break.wav"
giBreakBeatTemplateLengthInBeats init 16
giBreakBeatTemplateChannels filenchnls gSBreakBeatTemplateFilePath
giBreakBeatTemplateFileLength filelen gSBreakBeatTemplateFilePath
giBreakBeatTemplateLengthOfBeat = giBreakBeatTemplateFileLength / giBreakBeatTemplateLengthInBeats

giBreakBeatTemplateBPM init 60 / giBreakBeatTemplateLengthOfBeat
gkBreakBeatTemplateFactor = gkBPM / giBreakBeatTemplateBPM

instr BreakBeatTemplate
  iAmplitude = p4
  kPitch = p5
  iSkipTimeInBeats = p4

  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aBreakBeatTemplateSample loscil kAmplitudeEnvelope, 1, giBreakBeatTemplateSample, 1

  aBreakBeatTemplate = aBreakBeatTemplateSample

  outleta "OutL", aBreakBeatTemplate
  outleta "OutR", aBreakBeatTemplate
endin

instr BreakBeatTemplateDiskin
    kpitchFactor = p5
    iSkipTimeInBeats = p4

    aBreakBeatTemplateL, aBreakBeatTemplateR breakSamplerDiskin gSBreakBeatTemplateFilePath, 16, iSkipTimeInBeats, kpitchFactor

    outleta "OutL", aBreakBeatTemplateL
    outleta "OutR", aBreakBeatTemplateR
endin

instr BreakBeatTemplateDiskgrain
    kamplitude = p4
    kpitchFactor = p5
    if kpitchFactor==0 then
      kpitchFactor = 1
    endif
    kTimeFactor = kpitchFactor * gkBreakBeatTemplateFactor
    kpitch = p6
    iskipTimeInBeats = p7

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * kTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = giBreakBeatTemplateLengthOfBeat * iskipTimeInBeats

    aBreakBeatTemplate diskgrain gSBreakBeatTemplateFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "OutL", aBreakBeatTemplate
    outleta "OutR", aBreakBeatTemplate
endin

instr BreakBeatTemplateSndwarp
    iBreakBeatTemplateFileSampleRate filesr gSBreakBeatTemplateFilePath
    iBreakBeatTemplateTableLength getTableSizeFromSample gSBreakBeatTemplateFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iBreakBeatTemplateTable ftgenonce 0, 0, iBreakBeatTemplateTableLength, 1, gSBreakBeatTemplateFilePath, 0, 0, 0

    kamplitude = p4
    kpitchFactor = p5

    if kpitchFactor==0 then
      kpitchFactor = 1
    endif
    ktimewarp = kpitchFactor * (1/gkBreakBeatTemplateFactor)
    kresample = p6
    isampleTable = iBreakBeatTemplateTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  giBreakBeatTemplateLengthOfBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    aBreakBeatTemplate sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "OutL", aBreakBeatTemplate
    outleta "OutR", aBreakBeatTemplate
endin

instr BreakBeatTemplateBassKnob
    gkBreakBeatTemplateEqBass linseg p4, p3, p5
endin

instr BreakBeatTemplateMidKnob
    gkBreakBeatTemplateEqMid linseg p4, p3, p5
endin

instr BreakBeatTemplateHighKnob
    gkBreakBeatTemplateEqHigh linseg p4, p3, p5
endin

instr BreakBeatTemplateFader
    gkBreakBeatTemplateFader linseg p4, p3, p5
endin

instr BreakBeatTemplatePan
    gkBreakBeatTemplatePan linseg p4, p3, p5
endin

instr BreakBeatTemplateMixerChannel
    aBreakBeatTemplateL inleta "BreakBeatTemplateIn"
    aBreakBeatTemplateR inleta "BreakBeatTemplateIn"

    kBreakBeatTemplateFader = gkBreakBeatTemplateFader
    kBreakBeatTemplatePan = gkBreakBeatTemplatePan
    kBreakBeatTemplateEqBass = gkBreakBeatTemplateEqBass
    kBreakBeatTemplateEqMid = gkBreakBeatTemplateEqMid
    kBreakBeatTemplateEqHigh = gkBreakBeatTemplateEqHigh

    aBreakBeatTemplateL, aBreakBeatTemplateR threeBandEqStereo aBreakBeatTemplateL, aBreakBeatTemplateR, kBreakBeatTemplateEqBass, kBreakBeatTemplateEqMid, kBreakBeatTemplateEqHigh

    if kBreakBeatTemplatePan > 100 then
        kBreakBeatTemplatePan = 100
    elseif kBreakBeatTemplatePan < 0 then
        kBreakBeatTemplatePan = 0
    endif

    aBreakBeatTemplateL = (aBreakBeatTemplateL * ((100 - kBreakBeatTemplatePan) * 2 / 100)) * kBreakBeatTemplateFader
    aBreakBeatTemplateR = (aBreakBeatTemplateR * (kBreakBeatTemplatePan * 2 / 100)) * kBreakBeatTemplateFader

    outleta "OutL", aBreakBeatTemplateL
    outleta "OutR", aBreakBeatTemplateR
endin

