; Sample

connect "Sample", "SampleOut", "SampleMixerChannel", "SampleIn"
connect "SampleMixerChannel", "SampleOutL", "Mixer", "MixerInL"
connect "SampleMixerChannel", "SampleOutR", "Mixer", "MixerInR"
alwayson "SampleMixerChannel"

gkSampleFader init 1
gkSamplePan init 50

instr Sample
    iSample ftgenonce 0, 0, 0, 1, "instruments/LinnDrumLM-2/Normalized/Kick.aif", 0, 0, 0

    iTableLen = ftlen(iSample)
    iDur      = ftlen(iSample) / sr

    aSample poscil3 p4, p5/iDur, iSample
            out aSample
endin

instr SampleFader
    gkSampleFader linseg p4, p3, p5
endin

instr SamplePan
    gkSamplePan linseg p4, p3, p5
endin

instr SampleMixerChannel
    aSampleL inleta "SampleIn"
    aSampleR inleta "SampleIn"

    kpanvalue linseg 0, 1, 100

    kSampleFader = gkSampleFader
    kSamplePan = gkSamplePan

    if kSamplePan > 100 then
        kSamplePan = 100
    elseif kSamplePan < 0 then
        kSamplePan = 0
    endif

    aSampleL = (aSampleL * ((100 - kSamplePan) * 2 / 100)) * kSampleFader
    aSampleR = (aSampleR * (kSamplePan * 2 / 100)) * kSampleFader

    outleta "SampleOutL", aSampleL
    outleta "SampleOutR", aSampleR
endin
