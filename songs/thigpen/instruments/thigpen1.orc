/* thigpen1
    An Attempt to copy the fruity granulizer VST.
*/

connect "thigpen1", "thigpen1OutL", "thigpen1MixerChannel", "thigpen1InL"
connect "thigpen1", "thigpen1OutR", "thigpen1MixerChannel", "thigpen1InR"

alwayson "thigpen1MixerChannel"

gkthigpen1Hold init 10 ;12.8
gkthigpen1GrainSpacing init 54 ;54 - default setting for normal playback
gkthigpen1WaveSpacing init 84 ;84 - default setting for normal playback
gkthigpen1FxDepth init 0 ;0
gkthigpen1FxSpeed init .8
gkthigpen1Randomize init 0

gkthigpen1EqBass init 1
gkthigpen1EqMid init 1
gkthigpen1EqHigh init 1
gkthigpen1Fader init 1
gkthigpen1Pan init 50

instr thigpen1HoldKnob
    ;Length each grain is held before moving onto the next.
    gkthigpen1Hold linseg p4, p3, p5
endin

instr thigpen1GrainSpacingKnob
    ;Grain spacing in playback. Turn to right for greater spacing between played grains (slower playback). Turn left for smaller spacing (faster playback).
    gkthigpen1GrainSpacing linseg p4, p3, p5
endin

instr thigpen1WaveSpacingKnob
    ;This basically controls the number of grains generated from the wave sample. This value ranges from -300% to 300%. For normal playback, set both Grain Spacing and Wave Spacing to 100%. Small values mean more grains are used for the wave (smaller wave spacing). Using negative values results in reversed playback of the grains. NOTES: Grain playback order is reversed, not the sound contained in each grain.
    gkthigpen1WaveSpacing linseg p4, p3, p5
endin

instr thigpen1FxDepthKnob
    ;Amplitude of the LFO applied to the wave spacing value. Turn to right to increase the amplitude. To turn the LFO off, turn the knob maximum to left.
    gkthigpen1FxDepth linseg p4, p3, p5
endin

instr thigpen1FxSpeedKnob
    ;Speed of the LFO applied to the wave spacing value. Turning to right makes the LFO faster, turning left, slower.
    gkthigpen1FxSpeed linseg p4, p3, p5
endin

instr thigpen1
    ; faves: 7, 8, 9, 10, 11, 26, 27, 28
    SsampleFilePath = "localSamples/thigpen/thigpen9.wav"
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
    kWaveSpacingOscillator oscil (gkthigpen1FxDepth)/100*3, gkthigpen1FxSpeed
    kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((gkthigpen1GrainSpacing*1.852/100)^2)

    /* Wavespacing Factor */
    kthigpen1WaveSpacing = gkthigpen1WaveSpacing - 50
    if kthigpen1WaveSpacing == 0 then
      kthigpen1WaveSpacing = 1
    endif

    kthigpen1WaveSpacing = (kthigpen1WaveSpacing / 34)^3 + kWaveSpacingOscillator
    kPointerRate = (1/iMaxOverlaps) * kthigpen1WaveSpacing

    /* Synthesis and Output */
    if iFileNumChannels == 2 then
        athigpen1L syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTableL, ienvelopeTable, iMaxOverlaps
        athigpen1R syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTableR, ienvelopeTable, iMaxOverlaps
    else
        athigpen1L syncloop kamplitude, kGrainFrequency, kPitch, kGrainSize, kPointerRate, iStartTime, iEndTime, iSampleTable, ienvelopeTable, iMaxOverlaps
        athigpen1R = athigpen1L
    endif

    outleta "thigpen1OutL", athigpen1L
    outleta "thigpen1OutR", athigpen1R
endin

instr thigpen1BassKnob
    gkthigpen1EqBass linseg p4, p3, p5
endin

instr thigpen1MidKnob
    gkthigpen1EqMid linseg p4, p3, p5
endin

instr thigpen1HighKnob
    gkthigpen1EqHigh linseg p4, p3, p5
endin

instr thigpen1Fader
    gkthigpen1Fader linseg p4, p3, p5
endin

instr thigpen1Pan
    gkthigpen1Pan linseg p4, p3, p5
endin

instr thigpen1MixerChannel
    athigpen1L inleta "thigpen1InL"
    athigpen1R inleta "thigpen1InR"

    kthigpen1Fader = gkthigpen1Fader
    kthigpen1Pan = gkthigpen1Pan
    kthigpen1EqBass = gkthigpen1EqBass
    kthigpen1EqMid = gkthigpen1EqMid
    kthigpen1EqHigh = gkthigpen1EqHigh

    athigpen1L, athigpen1R threeBandEqStereo athigpen1L, athigpen1R, kthigpen1EqBass, kthigpen1EqMid, kthigpen1EqHigh

    if kthigpen1Pan > 100 then
        kthigpen1Pan = 100
    elseif kthigpen1Pan < 0 then
        kthigpen1Pan = 0
    endif

    athigpen1L = (athigpen1L * ((100 - kthigpen1Pan) * 2 / 100)) * kthigpen1Fader
    athigpen1R = (athigpen1R * (kthigpen1Pan * 2 / 100)) * kthigpen1Fader

    outleta "thigpen1OutL", athigpen1L
    outleta "thigpen1OutR", athigpen1R
endin
