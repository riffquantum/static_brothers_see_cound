/* amenBreak
    A set of sampling instruments each using different opcodes for playing and manipulating the drum break from InTimeDiskgrainSamplerTemplate, Brother by The Winstons.

    Sample Source: InTimeDiskgrainSamplerTemplate, Brother - The Winstons
    BPM: ~137
    Length: 16 beats
*/

connect "InTimeDiskgrainSamplerTemplate", "InTimeDiskgrainSamplerTemplateOut", "InTimeDiskgrainSamplerTemplateMixerChannel", "InTimeDiskgrainSamplerTemplateIn"
alwayson "InTimeDiskgrainSamplerTemplateMixerChannel"

gkInTimeDiskgrainSamplerTemplateEqBass init 1
gkInTimeDiskgrainSamplerTemplateEqMid init 1
gkInTimeDiskgrainSamplerTemplateEqHigh init 1
gkInTimeDiskgrainSamplerTemplateFader init 1
gkInTimeDiskgrainSamplerTemplatePan init 50

/* MIDI Config Values */
giInTimeDiskgrainSamplerMidiChannel = 4
;massign giInTimeDiskgrainSamplerMidiChannel, "InTimeDiskgrainSamplerTemplate"

instr InTimeDiskgrainSamplerTemplate
    SInTimeDiskgrainSamplerTemplateFilePath init "instruments/breakBeatInstruments/amenBreak/amen-break.wav"

    iInTimeDiskgrainSamplerTemplateFileLength filelen SInTimeDiskgrainSamplerTemplateFilePath
    iInTimeDiskgrainSamplerTemplateLengthOfOneBeat = iInTimeDiskgrainSamplerTemplateFileLength / 16

    iInTimeDiskgrainSamplerTemplateBPM init 60 / iInTimeDiskgrainSamplerTemplateLengthOfOneBeat
    iInTimeDiskgrainSamplerTemplateFactor = giBPM / iInTimeDiskgrainSamplerTemplateBPM

    iAmplitude flexibleAmplitudeInput p4
    kAmplitudeEnvelope madsr .005, .01, iAmplitude, .5, 0, .01

    iPitch flexiblePitchInput p5

    kPitchFactor = iPitch / 261.6 ; Ratio of frequency to Middle C

    if kPitchFactor==0 then
      kPitchFactor = 1
    endif
    kTimeFactor = kPitchFactor * iInTimeDiskgrainSamplerTemplateFactor
    kpitch = p6
    iskipTimeInBeats = p7

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    kgrainsize = 0.004
    ioverlaps = 2
    kpointerRate = 1/ioverlaps * kTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1
    iskipTime = iInTimeDiskgrainSamplerTemplateLengthOfOneBeat * iskipTimeInBeats

    aInTimeDiskgrainSamplerTemplate diskgrain SInTimeDiskgrainSamplerTemplateFilePath, kAmplitudeEnvelope,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime

    outleta "InTimeDiskgrainSamplerTemplateOut", aInTimeDiskgrainSamplerTemplate
endin

instr InTimeDiskgrainSamplerTemplateBassKnob
    gkInTimeDiskgrainSamplerTemplateEqBass linseg p4, p3, p5
endin

instr InTimeDiskgrainSamplerTemplateMidKnob
    gkInTimeDiskgrainSamplerTemplateEqMid linseg p4, p3, p5
endin

instr InTimeDiskgrainSamplerTemplateHighKnob
    gkInTimeDiskgrainSamplerTemplateEqHigh linseg p4, p3, p5
endin

instr InTimeDiskgrainSamplerTemplateFader
    gkInTimeDiskgrainSamplerTemplateFader linseg p4, p3, p5
endin

instr InTimeDiskgrainSamplerTemplatePan
    gkInTimeDiskgrainSamplerTemplatePan linseg p4, p3, p5
endin

instr InTimeDiskgrainSamplerTemplateMixerChannel
    aInTimeDiskgrainSamplerTemplateL inleta "InTimeDiskgrainSamplerTemplateIn"
    aInTimeDiskgrainSamplerTemplateR inleta "InTimeDiskgrainSamplerTemplateIn"

    kInTimeDiskgrainSamplerTemplateFader = gkInTimeDiskgrainSamplerTemplateFader
    kInTimeDiskgrainSamplerTemplatePan = gkInTimeDiskgrainSamplerTemplatePan
    kInTimeDiskgrainSamplerTemplateEqBass = gkInTimeDiskgrainSamplerTemplateEqBass
    kInTimeDiskgrainSamplerTemplateEqMid = gkInTimeDiskgrainSamplerTemplateEqMid
    kInTimeDiskgrainSamplerTemplateEqHigh = gkInTimeDiskgrainSamplerTemplateEqHigh

    aInTimeDiskgrainSamplerTemplateL, aInTimeDiskgrainSamplerTemplateR threeBandEqStereo aInTimeDiskgrainSamplerTemplateL, aInTimeDiskgrainSamplerTemplateR, kInTimeDiskgrainSamplerTemplateEqBass, kInTimeDiskgrainSamplerTemplateEqMid, kInTimeDiskgrainSamplerTemplateEqHigh

    if kInTimeDiskgrainSamplerTemplatePan > 100 then
        kInTimeDiskgrainSamplerTemplatePan = 100
    elseif kInTimeDiskgrainSamplerTemplatePan < 0 then
        kInTimeDiskgrainSamplerTemplatePan = 0
    endif

    aInTimeDiskgrainSamplerTemplateL = (aInTimeDiskgrainSamplerTemplateL * ((100 - kInTimeDiskgrainSamplerTemplatePan) * 2 / 100)) * kInTimeDiskgrainSamplerTemplateFader
    aInTimeDiskgrainSamplerTemplateR = (aInTimeDiskgrainSamplerTemplateR * (kInTimeDiskgrainSamplerTemplatePan * 2 / 100)) * kInTimeDiskgrainSamplerTemplateFader

    outleta "InTimeDiskgrainSamplerTemplateOutL", aInTimeDiskgrainSamplerTemplateL
    outleta "InTimeDiskgrainSamplerTemplateOutR", aInTimeDiskgrainSamplerTemplateR
endin

