/* diskinSampler
    A general purpose wrapper for sampling via diskin opcode. 
*/

connect "diskinSampler", "diskinSamplerOutL", "diskinSamplerMixerChannel", "diskinSamplerInL"
connect "diskinSampler", "diskinSamplerOutR", "diskinSamplerMixerChannel", "diskinSamplerInR"

connect "diskinSamplerMixerChannel", "diskinSamplerOutL", "Mixer", "MixerInL"
connect "diskinSamplerMixerChannel", "diskinSamplerOutR", "Mixer", "MixerInR"
alwayson "diskinSamplerMixerChannel"

gkdiskinSamplerFader init 1
gkdiskinSamplerPan init 50

instr diskinSampler
    SsampleFilename = p4
    kpitch = p5
    iSkipTime = p6
    
    SsampleFilePath strcat "instruments/diskinSampler/samples/", SsampleFilename
    iFileNumChannels filenchnls SsampleFilePath

    
    iwraparound= 1
    iformat = 0
    iskipinit = 0

    if iFileNumChannels == 2 then
        aDiskinSamplerL, aDiskinSamplerR diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
    elseif iFileNumChannels == 1 then
        aDiskinSamplerL diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
        aDiskinSamplerR = aDiskinSamplerL
    endif

    outleta "diskinSamplerOutL", aDiskinSamplerL
    outleta "diskinSamplerOutR", aDiskinSamplerR

endin

instr diskinSamplerFader
    gkdiskinSamplerFader linseg p4, p3, p5
endin

instr diskinSamplerPan
    gkdiskinSamplerPan linseg p4, p3, p5
endin

instr diskinSamplerMixerChannel
    adiskinSamplerL inleta "diskinSamplerInL"
    adiskinSamplerR inleta "diskinSamplerInR"

    kdiskinSamplerFader = gkdiskinSamplerFader
    kdiskinSamplerPan = gkdiskinSamplerPan

    if kdiskinSamplerPan > 100 then
        kdiskinSamplerPan = 100
    elseif kdiskinSamplerPan < 0 then
        kdiskinSamplerPan = 0
    endif

    adiskinSamplerL = (adiskinSamplerL * ((100 - kdiskinSamplerPan) * 2 / 100)) * kdiskinSamplerFader
    adiskinSamplerR = (adiskinSamplerR * (kdiskinSamplerPan * 2 / 100)) * kdiskinSamplerFader

    outleta "diskinSamplerOutL", adiskinSamplerL
    outleta "diskinSamplerOutR", adiskinSamplerR
endin

