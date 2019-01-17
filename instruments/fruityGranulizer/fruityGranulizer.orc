/* fruityGranulizer
    An Attempt to copy the fruity granulizer VST.
*/

connect "fruityGranulizer", "fruityGranulizerOutL", "fruityGranulizerMixerChannel", "fruityGranulizerInL"
connect "fruityGranulizer", "fruityGranulizerOutR", "fruityGranulizerMixerChannel", "fruityGranulizerInR"

alwayson "fruityGranulizerMixerChannel"

gkfruityGranulizerAttack init 0
gkfruityGranulizerHold init 10
gkfruityGranulizerGrainSpacing init 1
gkfruityGranulizerWaveSpacing init 1
gkfruityGranulizerPan init 0
gkfruityGranulizerFxDepth init 0
gkfruityGranulizerFxSpeed init 0
gkfruityGranulizerRandomize init 0
gifruityGranulizerTime init 0

gkfruityGranulizerEqBass init 1
gkfruityGranulizerEqMid init 1
gkfruityGranulizerEqHigh init 1
gkfruityGranulizerFader init 1
gkfruityGranulizerPan init 50

instr fruityGranulizerAttackKnob
    gkfruityGranulizerAttack linseg p4, p3, p5
endin

instr fruityGranulizerHoldKnob
    gkfruityGranulizerHold linseg p4, p3, p5
endin

instr fruityGranulizerGrainSpacingKnob
    gkfruityGranulizerGrainSpacing linseg p4, p3, p5
endin

instr fruityGranulizerWaveSpacingKnob
    gkfruityGranulizerWaveSpacing linseg p4, p3, p5
endin

instr fruityGranulizerPanKnob
    gkfruityGranulizerPan linseg p4, p3, p5
endin

instr fruityGranulizerFxDepthKnob
    gkfruityGranulizerFxDepth linseg p4, p3, p5
endin

instr fruityGranulizerFxSpeedKnob
    gkfruityGranulizerFxSpeed linseg p4, p3, p5
endin

instr fruityGranulizerRandomizeKnob
    gkfruityGranulizerRandomize linseg p4, p3, p5
endin

instr fruityGranulizerTimeKnob
    gkfruityGranulizerTime linseg p4, p3, p5
endin

instr fruityGranulizer

    /* P FIELDS */
    SsampleFilename = p4
    kamplitude = p5
    kpitch = p6

    /* SAMPLE DATA */
    SsampleFilePath strcat "samples/", SsampleFilename
    iFileNumChannels filenchnls SsampleFilePath
    iFileLength filelen SsampleFilePath
    iFileSampleRate filesr SsampleFilePath
    iSampleTableLength getTableSizeFromSample SsampleFilePath
    ;ienvelopeTable ftgenonce 0, 0, 8192, 20, 2, 1
    ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
    iSampleTable ftgenonce 0, 0, iSampleTableLength, 1, SsampleFilePath, 0, 0, 0

    /* GRAIN3 */
    kGrainFrequency = 1500
    kGrainPhase = 0
    kRandomFrequencyVariation = 0
    kRandomPhaseVariation = 0
    kGrainDuration = .1
    kGrainsPerSecond = 100
    iMaxOverlaps = 10
    kFrequencyRandomnessDistribution = 0
    kPhaseRandomnessDistribution = 0
    iRandomnessSeed = 0
    iMode = 10

    if iFileNumChannels == 2 then
        afruityGranulizerL grain3 kGrainFrequency, kGrainPhase, kRandomFrequencyVariation, kRandomPhaseVariation, kGrainDuration, kGrainsPerSecond, iMaxOverlaps, iSampleTable, ienvelopeTable, kFrequencyRandomnessDistribution, kPhaseRandomnessDistribution, iRandomnessSeed, iMode
        afruityGranulizerR = afruityGranulizerL

    elseif iFileNumChannels == 1 then
        afruityGranulizerL grain3 kGrainFrequency, kGrainPhase, kRandomFrequencyVariation, kRandomPhaseVariation, kGrainDuration, kGrainsPerSecond, iMaxOverlaps, iSampleTable, ienvelopeTable, kFrequencyRandomnessDistribution, kPhaseRandomnessDistribution, iRandomnessSeed, iMode

        afruityGranulizerR = afruityGranulizerL
    endif


    /* SNDWARP */
    /*
    ktimewarp = 1
    kresample = 2
    ibeginningTime =  0
    irandw = 0
    ioverlap = 3
    iwindowSize = 4410
    itimemode = 1

    if iFileNumChannels == 2 then
        afruityGranulizerL, afruityGranulizerR sndwarpst kamplitude, ktimewarp, kresample, iSampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
    elseif iFileNumChannels == 1 then
        afruityGranulizerL sndwarp kamplitude, ktimewarp, kresample, iSampleTable, ibeginningTime, iwindowSize, irandw, ioverlap, ienvelopeTable, itimemode
        afruityGranulizerR = afruityGranulizerL
    endif
    */



    /* DISKGRAIN */
    /*
    ioverlaps = 4
    kGrainSize = (1/iFileSampleRate) * ioverlaps * 1
    kpointerRate = 1/ioverlaps * 1
    kGrainDensity = ioverlaps/kGrainSize * 1
    imaxgrainsize = 1

    if iFileNumChannels == 2 then
        afruityGranulizerL, afruityGranulizerR diskgrain SsampleFilePath, kamplitude, kGrainDensity, kpitch, kGrainSize, kpointerRate, ienvelopeTable, ioverlaps, imaxgrainsize, gifruityGranulizerTime
    elseif iFileNumChannels == 1 then
        afruityGranulizerL diskgrain SsampleFilePath, kamplitude, kGrainDensity, kpitch, kGrainSize, kpointerRate, ienvelopeTable, ioverlaps, imaxgrainsize, gifruityGranulizerTime
        afruityGranulizerR = afruityGranulizerL
    endif
    */

    outleta "fruityGranulizerOutL", afruityGranulizerL
    outleta "fruityGranulizerOutR", afruityGranulizerR

endin

instr fruityGranulizerBassKnob
    gkfruityGranulizerEqBass linseg p4, p3, p5
endin

instr fruityGranulizerMidKnob
    gkfruityGranulizerEqMid linseg p4, p3, p5
endin

instr fruityGranulizerHighKnob
    gkfruityGranulizerEqHigh linseg p4, p3, p5
endin

instr fruityGranulizerFader
    gkfruityGranulizerFader linseg p4, p3, p5
endin

instr fruityGranulizerPan
    gkfruityGranulizerPan linseg p4, p3, p5
endin

instr fruityGranulizerMixerChannel
    afruityGranulizerL inleta "fruityGranulizerInL"
    afruityGranulizerR inleta "fruityGranulizerInR"

    kfruityGranulizerFader = gkfruityGranulizerFader
    kfruityGranulizerPan = gkfruityGranulizerPan
    kfruityGranulizerEqBass = gkfruityGranulizerEqBass
    kfruityGranulizerEqMid = gkfruityGranulizerEqMid
    kfruityGranulizerEqHigh = gkfruityGranulizerEqHigh

    afruityGranulizerL, afruityGranulizerR threeBandEqStereo afruityGranulizerL, afruityGranulizerR, kfruityGranulizerEqBass, kfruityGranulizerEqMid, kfruityGranulizerEqHigh

    if kfruityGranulizerPan > 100 then
        kfruityGranulizerPan = 100
    elseif kfruityGranulizerPan < 0 then
        kfruityGranulizerPan = 0
    endif

    afruityGranulizerL = (afruityGranulizerL * ((100 - kfruityGranulizerPan) * 2 / 100)) * kfruityGranulizerFader
    afruityGranulizerR = (afruityGranulizerR * (kfruityGranulizerPan * 2 / 100)) * kfruityGranulizerFader

    outleta "fruityGranulizerOutL", afruityGranulizerL
    outleta "fruityGranulizerOutR", afruityGranulizerR
endin

