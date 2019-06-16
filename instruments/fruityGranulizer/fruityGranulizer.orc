/* fruityGranulizer
    An Attempt to copy the fruity granulizer VST.
*/

connect "fruityGranulizer", "fruityGranulizerOutL", "fruityGranulizerMixerChannel", "fruityGranulizerInL"
connect "fruityGranulizer", "fruityGranulizerOutR", "fruityGranulizerMixerChannel", "fruityGranulizerInR"

alwayson "fruityGranulizerMixerChannel"

gkfruityGranulizerHold init 10 ;12.8
gkfruityGranulizerGrainSpacing init 54 ;54 - default setting for normal playback
gkfruityGranulizerWaveSpacing init 84 ;84 - default setting for normal playback
gkfruityGranulizerFxDepth init 0 ;0
gkfruityGranulizerFxSpeed init .8
gkfruityGranulizerRandomize init 0

gkfruityGranulizerEqBass init 1
gkfruityGranulizerEqMid init 1
gkfruityGranulizerEqHigh init 1
gkfruityGranulizerFader init 1
gkfruityGranulizerPan init 50

instr fruityGranulizerHoldKnob
    ;Length each grain is held before moving onto the next.
    gkfruityGranulizerHold linseg p4, p3, p5
endin

instr fruityGranulizerGrainSpacingKnob
    ;Grain spacing in playback. Turn to right for greater spacing between played grains (slower playback). Turn left for smaller spacing (faster playback).
    gkfruityGranulizerGrainSpacing linseg p4, p3, p5
endin

instr fruityGranulizerWaveSpacingKnob
    ;This basically controls the number of grains generated from the wave sample. This value ranges from -300% to 300%. For normal playback, set both Grain Spacing and Wave Spacing to 100%. Small values mean more grains are used for the wave (smaller wave spacing). Using negative values results in reversed playback of the grains. NOTES: Grain playback order is reversed, not the sound contained in each grain.
    gkfruityGranulizerWaveSpacing linseg p4, p3, p5
endin

instr fruityGranulizerFxDepthKnob
    ;Amplitude of the LFO applied to the wave spacing value. Turn to right to increase the amplitude. To turn the LFO off, turn the knob maximum to left.
    gkfruityGranulizerFxDepth linseg p4, p3, p5
endin

instr fruityGranulizerFxSpeedKnob
    ;Speed of the LFO applied to the wave spacing value. Turning to right makes the LFO faster, turning left, slower.
    gkfruityGranulizerFxSpeed linseg p4, p3, p5
endin

instr fruityGranulizer
    SsampleFilePath = p4
    kamplitude = p5
    kPitch = p6
    iStartTime = p7
    iEndTime = p8

    /* Sound File Data */
    iFileNumChannels filenchnls SsampleFilePath
    iFileLength filelen SsampleFilePath
    iFileSampleRate filesr SsampleFilePath

    if iFileNumChannels == 2 then
        iSampleTableL ftgenonce 0, 0, 0, 1, SsampleFilePath, iStartTime, 0, 1
        iSampleTableR ftgenonce 0, 0, 0, 1, SsampleFilePath, iStartTime, 0, 2
    else
        iSampleTable ftgenonce 0, 0, 0, 1, SsampleFilePath, iStartTime, 0, 0
    endif

    if iEndTime == 0 then
        iEndTime = iFileLength
    endif

    /* Syncloop Params */
    ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
    iMaxOverlaps = 5
    kGrainSizeInMiliseconds = 40
    kGrainSize = kGrainSizeInMiliseconds/1000
    kWaveSpacingOscillator oscil (gkfruityGranulizerFxDepth)/100*3, gkfruityGranulizerFxSpeed
    kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((gkfruityGranulizerGrainSpacing*1.852/100)^2)

    /* Wavespacing Factor */
    kfruityGranulizerWaveSpacing = gkfruityGranulizerWaveSpacing - 50
    if kfruityGranulizerWaveSpacing == 0 then
      kfruityGranulizerWaveSpacing = 1
    endif

    kfruityGranulizerWaveSpacing = (kfruityGranulizerWaveSpacing / 34)^3 + kWaveSpacingOscillator
    kPointerRate = (1/iMaxOverlaps) * kfruityGranulizerWaveSpacing

    /* Synthesis and Output */
    if iFileNumChannels == 2 then
        afruityGranulizerL syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTableL, ienvelopeTable, iMaxOverlaps
        afruityGranulizerR syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTableR, ienvelopeTable, iMaxOverlaps
    else
        afruityGranulizerL syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTable, ienvelopeTable, iMaxOverlaps
        afruityGranulizerR = afruityGranulizerL
    endif

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

