/* generalSampler
    A general purpose wrapper for sampling via diskin opcode. 
*/

connect "generalSampler", "generalSamplerOutL", "generalSamplerMixerChannel", "generalSamplerInL"
connect "generalSampler", "generalSamplerOutR", "generalSamplerMixerChannel", "generalSamplerInR"

connect "generalSamplerMixerChannel", "generalSamplerOutL", "Mixer", "MixerInL"
connect "generalSamplerMixerChannel", "generalSamplerOutR", "Mixer", "MixerInR"
alwayson "generalSamplerMixerChannel"

gkgeneralSamplerEqBass init 1
gkgeneralSamplerEqMid init 1
gkgeneralSamplerEqHigh init 1
gkgeneralSamplerFader init 1
gkgeneralSamplerPan init 50

instr generalSamplerDiskin
    SsampleFilename = p4
    kpitch = p5
    iSkipTime = p6
    
    SsampleFilePath strcat "instruments/generalSampler/samples/", SsampleFilename
    iFileNumChannels filenchnls SsampleFilePath

    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    if iFileNumChannels == 2 then
        ageneralSamplerL, ageneralSamplerR diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
    elseif iFileNumChannels == 1 then
        ageneralSamplerL diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
        ageneralSamplerR = ageneralSamplerL
    endif

    outleta "generalSamplerOutL", ageneralSamplerL
    outleta "generalSamplerOutR", ageneralSamplerR

endin

instr generalSamplerDiskgrain
    SsampleFilename = p4
    kamplitude = p5
    iTimeFactor = p6
    kpitch = p7
    iskipTime = p8
    kgrainsize = p9
    ioverlaps = p10

    iTable ftgenonce 0, 0, 8192, 20, 2, 1
    SsampleFilePath strcat "instruments/generalSampler/samples/", SsampleFilename
    iFileNumChannels filenchnls SsampleFilePath
    kpointerRate = 1/ioverlaps * iTimeFactor
    kfreq = ioverlaps/kgrainsize
    imaxgrainsize = 1

    if iFileNumChannels == 2 then
        ageneralSamplerL, ageneralSamplerR diskgrain SsampleFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime
    elseif iFileNumChannels == 1 then
        ageneralSamplerL diskgrain SsampleFilePath, kamplitude,    kfreq,     kpitch, kgrainsize ,     kpointerRate, iTable,  ioverlaps, imaxgrainsize, iskipTime
        ageneralSamplerR = ageneralSamplerL
    endif

    outleta "generalSamplerOutL", ageneralSamplerL
    outleta "generalSamplerOutR", ageneralSamplerR

endin

instr generalSamplerSndwarp
    SsampleFilename = p4
    kamplitude = p4
    ktimewarp = p5
    kresample = p6
    ibeginningTime =  p7
    ioverlap = p8
    iwindowSize = 10
    
    SsampleFilePath strcat "instruments/generalSampler/samples/", SsampleFilename
    iFileNumChannels filenchnls SsampleFilePath
    igeneralSamplerFileSampleRate filesr SsampleFilePath
    igeneralSamplerTableLength getTableSizeFromSample SsampleFilePath
    ;iTable ftgenonce 0, 0, 8192, 20, 2, 1
    iTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    
    igeneralSamplerTable ftgenonce 0, 0, igeneralSamplerTableLength, 1, SsampleFilePath, 0, 0, 0
    isampleTable = igeneralSamplerTable
    
    irandw = 0
    ienvelopeTable = iTable
    itimemode = 0

    if iFileNumChannels == 2 then
        ageneralSamplerL, ageneralSamplerR sndwarpst kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iFileNumChannels == 1 then
        ageneralSamplerL sndwarp kamplitude, ktimewarp, kresample, isampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
        ageneralSamplerR = ageneralSamplerL
    endif

    outleta "generalSamplerOutL", ageneralSamplerL
    outleta "generalSamplerOutR", ageneralSamplerR

endin

instr generalSamplerBassKnob
    gkgeneralSamplerEqBass linseg p4, p3, p5
endin

instr generalSamplerMidKnob
    gkgeneralSamplerEqMid linseg p4, p3, p5
endin

instr generalSamplerHighKnob
    gkgeneralSamplerEqHigh linseg p4, p3, p5  
endin

instr generalSamplerFader
    gkgeneralSamplerFader linseg p4, p3, p5
endin

instr generalSamplerPan
    gkgeneralSamplerPan linseg p4, p3, p5
endin

instr generalSamplerMixerChannel
    ageneralSamplerL inleta "generalSamplerInL"
    ageneralSamplerR inleta "generalSamplerInR"

    kgeneralSamplerFader = gkgeneralSamplerFader
    kgeneralSamplerPan = gkgeneralSamplerPan
    kgeneralSamplerEqBass = gkgeneralSamplerEqBass
    kgeneralSamplerEqMid = gkgeneralSamplerEqMid
    kgeneralSamplerEqHigh = gkgeneralSamplerEqHigh

    ageneralSamplerL, ageneralSamplerR threeBandEqStereo ageneralSamplerL, ageneralSamplerR, kgeneralSamplerEqBass, kgeneralSamplerEqMid, kgeneralSamplerEqHigh

    if kgeneralSamplerPan > 100 then
        kgeneralSamplerPan = 100
    elseif kgeneralSamplerPan < 0 then
        kgeneralSamplerPan = 0
    endif

    ageneralSamplerL = (ageneralSamplerL * ((100 - kgeneralSamplerPan) * 2 / 100)) * kgeneralSamplerFader
    ageneralSamplerR = (ageneralSamplerR * (kgeneralSamplerPan * 2 / 100)) * kgeneralSamplerFader

    outleta "generalSamplerOutL", ageneralSamplerL
    outleta "generalSamplerOutR", ageneralSamplerR
endin

