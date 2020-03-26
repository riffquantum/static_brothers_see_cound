/* Thigpen1
    An Attempt to copy the fruity granulizer VST.
*/

gSThigpen1Name = "Thigpen1"
gSThigpen1Route = "Mixer"
instrumentRoute gSThigpen1Name, gSThigpen1Route

alwayson "Thigpen1MixerChannel"

gkThigpen1Hold init 13 ;12.8
gkThigpen1GrainSpacing init 51 ;54 - default setting for normal playback
gkThigpen1WaveSpacing init 8 ;84 - default setting for normal playback
gkThigpen1FxDepth init 0 ;0
gkThigpen1FxSpeed init .8
gkThigpen1Randomize init 0

gkThigpen1EqBass init 1
gkThigpen1EqMid init 1
gkThigpen1EqHigh init 1
gkThigpen1Fader init 1
gkThigpen1Pan init 50

instr Thigpen1HoldKnob
    ;Length each grain is held before moving onto the next.
    gkThigpen1Hold linseg p4, p3, p5
endin

instr Thigpen1GrainSpacingKnob
    ;Grain spacing in playback. Turn to right for greater spacing between played grains (slower playback). Turn left for smaller spacing (faster playback).
    gkThigpen1GrainSpacing linseg p4, p3, p5
endin

instr Thigpen1WaveSpacingKnob
    ;This basically controls the number of grains generated from the wave sample. This value ranges from -300% to 300%. For normal playback, set both Grain Spacing and Wave Spacing to 100%. Small values mean more grains are used for the wave (smaller wave spacing). Using negative values results in reversed playback of the grains. NOTES: Grain playback order is reversed, not the sound contained in each grain.
    gkThigpen1WaveSpacing linseg p4, p3, p5
endin

instr Thigpen1FxDepthKnob
    ;Amplitude of the LFO applied to the wave spacing value. Turn to right to increase the amplitude. To turn the LFO off, turn the knob maximum to left.
    gkThigpen1FxDepth linseg p4, p3, p5
endin

instr Thigpen1FxSpeedKnob
    ;Speed of the LFO applied to the wave spacing value. Turning to right makes the LFO faster, turning left, slower.
    gkThigpen1FxSpeed linseg p4, p3, p5
endin

instr Thigpen1
    ; faves: 7, 8, 9, 10, 11, 26, 27, 28
    SsampleFilePath = "localSamples/thigpen/thigpen8.wav"
    kamplitude = p4
    kPitch = p5
    iStartTime = p6
    iEndTime = p7

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
    kWaveSpacingOscillator oscil (gkThigpen1FxDepth)/100*3, gkThigpen1FxSpeed
    kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((gkThigpen1GrainSpacing*1.852/100)^2)

    /* Wavespacing Factor */
    kThigpen1WaveSpacing = gkThigpen1WaveSpacing - 50
    if kThigpen1WaveSpacing == 0 then
      kThigpen1WaveSpacing = 1
    endif

    kThigpen1WaveSpacing = (kThigpen1WaveSpacing / 34)^3 + kWaveSpacingOscillator
    kPointerRate = (1/iMaxOverlaps) * kThigpen1WaveSpacing

    /* Synthesis and Output */
    if iFileNumChannels == 2 then
        aThigpen1L syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTableL, ienvelopeTable, iMaxOverlaps
        aThigpen1R syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTableR, ienvelopeTable, iMaxOverlaps
    else
        aThigpen1L syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTable, ienvelopeTable, iMaxOverlaps
        aThigpen1R = aThigpen1L
    endif

    outleta "Thigpen1OutL", aThigpen1L
    outleta "Thigpen1OutR", aThigpen1R
endin

instr Thigpen1BassKnob
    gkThigpen1EqBass linseg p4, p3, p5
endin

instr Thigpen1MidKnob
    gkThigpen1EqMid linseg p4, p3, p5
endin

instr Thigpen1HighKnob
    gkThigpen1EqHigh linseg p4, p3, p5
endin

instr Thigpen1Fader
    gkThigpen1Fader linseg p4, p3, p5
endin

instr Thigpen1Pan
    gkThigpen1Pan linseg p4, p3, p5
endin

instr Thigpen1MixerChannel
    aThigpen1L inleta "Thigpen1InL"
    aThigpen1R inleta "Thigpen1InR"

    kThigpen1Fader = gkThigpen1Fader
    kThigpen1Pan = gkThigpen1Pan
    kThigpen1EqBass = gkThigpen1EqBass
    kThigpen1EqMid = gkThigpen1EqMid
    kThigpen1EqHigh = gkThigpen1EqHigh

    aThigpen1L, aThigpen1R threeBandEqStereo aThigpen1L, aThigpen1R, kThigpen1EqBass, kThigpen1EqMid, kThigpen1EqHigh

    if kThigpen1Pan > 100 then
        kThigpen1Pan = 100
    elseif kThigpen1Pan < 0 then
        kThigpen1Pan = 0
    endif

    aThigpen1L = (aThigpen1L * ((100 - kThigpen1Pan) * 2 / 100)) * kThigpen1Fader
    aThigpen1R = (aThigpen1R * (kThigpen1Pan * 2 / 100)) * kThigpen1Fader

    outleta "Thigpen1OutL", aThigpen1L
    outleta "Thigpen1OutR", aThigpen1R
endin
