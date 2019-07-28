connect "InTimeSamplerTemplate", "InTimeSamplerTemplateOut", "InTimeSamplerTemplateMixerChannel", "InTimeSamplerTemplateIn"
alwayson "InTimeSamplerTemplateMixerChannel"

gkInTimeSamplerTemplateEqBass init 1
gkInTimeSamplerTemplateEqMid init 1
gkInTimeSamplerTemplateEqHigh init 1
gkInTimeSamplerTemplateFader init 1
gkInTimeSamplerTemplatePan init 50


instr InTimeSamplerTemplate
    SInTimeSamplerTemplateFilePath init "instruments/breakBeatInstruments/amenBreak/amen-break.wav"

    iInTimeSamplerTemplateFileLength filelen SInTimeSamplerTemplateFilePath
    iInTimeSamplerTemplateLengthOfOneBeat = iInTimeSamplerTemplateFileLength / 16

    iInTimeSamplerTemplateBPM init 60 / iInTimeSamplerTemplateLengthOfOneBeat
    giInTimeSamplerTemplateFactor = giBPM / iInTimeSamplerTemplateBPM

    kpitchFactor = p5
    iSkipTimeInBeats = p4

    aInTimeSamplerTemplateL, aInTimeSamplerTemplateR breakSamplerDiskin SInTimeSamplerTemplateFilePath, 16, iSkipTimeInBeats, kpitchFactor

    aInTimeSamplerTemplate = aInTimeSamplerTemplateL

    outleta "InTimeSamplerTemplateOut", aInTimeSamplerTemplate
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
    aInTimeSamplerTemplateL inleta "InTimeSamplerTemplateIn"
    aInTimeSamplerTemplateR inleta "InTimeSamplerTemplateIn"

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

