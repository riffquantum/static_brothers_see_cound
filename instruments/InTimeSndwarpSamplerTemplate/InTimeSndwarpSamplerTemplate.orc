gSInTimeSndwarpSamplerTemplateName = "InTimeSndwarpSamplerTemplate"
gSInTimeSndwarpSamplerTemplateRoute = "Mixer"
instrumentRoute gSInTimeSndwarpSamplerTemplateName, gSInTimeSndwarpSamplerTemplateRoute

alwayson "InTimeSndwarpSamplerTemplatekMixerChannel"

gkInTimeSndwarpSamplerTemplatekEqBass init 1
gkInTimeSndwarpSamplerTemplatekEqMid init 1
gkInTimeSndwarpSamplerTemplatekEqHigh init 1
gkInTimeSndwarpSamplerTemplatekFader init 1
gkInTimeSndwarpSamplerTemplatekPan init 50


instr InTimeSndwarpSamplerTemplate
    SInTimeSndwarpSamplerTemplateFilePath init "instruments/breakBeatInstruments/amenBreak/amen-break.wav"

    iInTimeSndwarpSamplerTemplateFileLength filelen SInTimeSndwarpSamplerTemplateFilePath
    iInTimeSndwarpSamplerTemplateLengthOfOneBeat = iInTimeSndwarpSamplerTemplateFileLength / 16

    iInTimeSndwarpSamplerTemplatekBPM init 60 / iInTimeSndwarpSamplerTemplateLengthOfOneBeat
    iInTimeSndwarpSamplerTemplateFactor = giBPM / iInTimeSndwarpSamplerTemplatekBPM

    iInTimeSndwarpSamplerTemplateFileSampleRate filesr SInTimeSndwarpSamplerTemplateFilePath
    iInTimeSndwarpSamplerTemplateTableLength getTableSizeFromSample SInTimeSndwarpSamplerTemplateFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    iInTimeSndwarpSamplerTemplateTable ftgenonce 0, 0, iInTimeSndwarpSamplerTemplateTableLength, 1, SInTimeSndwarpSamplerTemplateFilePath, 0, 0, 0

    kamplitude = p4
    kpitchFactor = p5

    if kpitchFactor==0 then
      kpitchFactor = 1
    endif
    ktimewarp = kpitchFactor * (1/iInTimeSndwarpSamplerTemplateFactor)
    kresample = p6
    isampleTable = iInTimeSndwarpSamplerTemplateTable
    iskipTimeInBeats = p7
    ioverlap = p8
    ibeginningTime =  iInTimeSndwarpSamplerTemplateLengthOfOneBeat * iskipTimeInBeats
    iwindowSize = 10
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    aInTimeSndwarpSamplerTemplate sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode

    outleta "InTimeSndwarpSamplerTemplatekOutL", aInTimeSndwarpSamplerTemplate
    outleta "InTimeSndwarpSamplerTemplatekOutR", aInTimeSndwarpSamplerTemplate
endin

instr InTimeSndwarpSamplerTemplatekBassKnob
    gkInTimeSndwarpSamplerTemplatekEqBass linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplatekMidKnob
    gkInTimeSndwarpSamplerTemplatekEqMid linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplatekHighKnob
    gkInTimeSndwarpSamplerTemplatekEqHigh linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplatekFader
    gkInTimeSndwarpSamplerTemplatekFader linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplatekPan
    gkInTimeSndwarpSamplerTemplatekPan linseg p4, p3, p5
endin

instr InTimeSndwarpSamplerTemplatekMixerChannel
    aInTimeSndwarpSamplerTemplatekL inleta "InTimeSndwarpSamplerTemplatekInL"
    aInTimeSndwarpSamplerTemplatekR inleta "InTimeSndwarpSamplerTemplatekInR"

    kInTimeSndwarpSamplerTemplatekFader = gkInTimeSndwarpSamplerTemplatekFader
    kInTimeSndwarpSamplerTemplatekPan = gkInTimeSndwarpSamplerTemplatekPan
    kInTimeSndwarpSamplerTemplatekEqBass = gkInTimeSndwarpSamplerTemplatekEqBass
    kInTimeSndwarpSamplerTemplatekEqMid = gkInTimeSndwarpSamplerTemplatekEqMid
    kInTimeSndwarpSamplerTemplatekEqHigh = gkInTimeSndwarpSamplerTemplatekEqHigh

    aInTimeSndwarpSamplerTemplatekL, aInTimeSndwarpSamplerTemplatekR threeBandEqStereo aInTimeSndwarpSamplerTemplatekL, aInTimeSndwarpSamplerTemplatekR, kInTimeSndwarpSamplerTemplatekEqBass, kInTimeSndwarpSamplerTemplatekEqMid, kInTimeSndwarpSamplerTemplatekEqHigh

    if kInTimeSndwarpSamplerTemplatekPan > 100 then
        kInTimeSndwarpSamplerTemplatekPan = 100
    elseif kInTimeSndwarpSamplerTemplatekPan < 0 then
        kInTimeSndwarpSamplerTemplatekPan = 0
    endif

    aInTimeSndwarpSamplerTemplatekL = (aInTimeSndwarpSamplerTemplatekL * ((100 - kInTimeSndwarpSamplerTemplatekPan) * 2 / 100)) * kInTimeSndwarpSamplerTemplatekFader
    aInTimeSndwarpSamplerTemplatekR = (aInTimeSndwarpSamplerTemplatekR * (kInTimeSndwarpSamplerTemplatekPan * 2 / 100)) * kInTimeSndwarpSamplerTemplatekFader

    outleta "InTimeSndwarpSamplerTemplatekOutL", aInTimeSndwarpSamplerTemplatekL
    outleta "InTimeSndwarpSamplerTemplatekOutR", aInTimeSndwarpSamplerTemplatekR
endin

