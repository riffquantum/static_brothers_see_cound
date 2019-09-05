connect "InTimeSyncloopSamplerTemplate", "InTimeSyncloopSamplerTemplateOutL", "InTimeSyncloopSamplerTemplateMixerChannel", "InTimeSyncloopSamplerTemplateInL"
connect "InTimeSyncloopSamplerTemplate", "InTimeSyncloopSamplerTemplateOutR", "InTimeSyncloopSamplerTemplateMixerChannel", "InTimeSyncloopSamplerTemplateInR"

alwayson "InTimeSyncloopSamplerTemplateMixerChannel"

gkInTimeSyncloopSamplerTemplateHold init 40 ;12.8
gkInTimeSyncloopSamplerTemplateGrainSpacing init 54 ;54 - default setting for normal playback
gkInTimeSyncloopSamplerTemplateWaveSpacing init 84 ;84 - default setting for normal playback
gkInTimeSyncloopSamplerTemplateFxDepth init 0 ;0
gkInTimeSyncloopSamplerTemplateFxSpeed init .8
gkInTimeSyncloopSamplerTemplateRandomize init 0

gkInTimeSyncloopSamplerTemplateEqBass init 1
gkInTimeSyncloopSamplerTemplateEqMid init 1
gkInTimeSyncloopSamplerTemplateEqHigh init 1
gkInTimeSyncloopSamplerTemplateFader init 1
gkInTimeSyncloopSamplerTemplatePan init 50

/* MIDI Config Values */
giInTimeSyncloopSamplerTemplateHoldAdjustmentControl = 1
giInTimeSyncloopSamplerTemplateGrainSpacingAdjustmentControl = 2
giInTimeSyncloopSamplerTemplateWaveSpacingAdjustmentControl = 7
giInTimeSyncloopSamplerTemplateFxDepthAdjustmentControl = 4
giInTimeSyncloopSamplerTemplateFxSpeedAdjustmentControl = 5
massign giInTimeSyncloopSamplerTemplateMidiChannel, "InTimeSyncloopSamplerTemplate"

/* Sound File Data */
gSInTimeSyncloopSamplerTemplatesampleFilePath = "instruments/breakBeatInstruments/amenBreak/amen-break.wav"
giInTimeSyncloopSamplerTemplateSampleNumberOfBeats = 16
giInTimeSyncloopSamplerTemplateFileNumChannels filenchnls gSInTimeSyncloopSamplerTemplatesampleFilePath
giInTimeSyncloopSamplerTemplateFileLength filelen gSInTimeSyncloopSamplerTemplatesampleFilePath
giInTimeSyncloopSamplerTemplateFileSampleRate filesr gSInTimeSyncloopSamplerTemplatesampleFilePath
giInTimeSyncloopSamplerTemplateStartTime = 0
giInTimeSyncloopSamplerTemplateEndTime = giInTimeSyncloopSamplerTemplateFileLength
giInTimeSyncloopSamplerTemplateLengthOfOneBeat = giInTimeSyncloopSamplerTemplateFileLength / giInTimeSyncloopSamplerTemplateSampleNumberOfBeats
giInTimeSyncloopSamplerTemplateBPM = 60 / giInTimeSyncloopSamplerTemplateLengthOfOneBeat
giInTimeSyncloopSamplerTemplateFactor = giBPM / giInTimeSyncloopSamplerTemplateBPM

if giInTimeSyncloopSamplerTemplateFileNumChannels == 2 then
    giInTimeSyncloopSamplerTemplateSampleTableL ftgenonce 0, 0, 0, 1, gSInTimeSyncloopSamplerTemplatesampleFilePath, giInTimeSyncloopSamplerTemplateStartTime, 0, 1
    giInTimeSyncloopSamplerTemplateSampleTableR ftgenonce 0, 0, 0, 1, gSInTimeSyncloopSamplerTemplatesampleFilePath, giInTimeSyncloopSamplerTemplateStartTime, 0, 2
else
    giInTimeSyncloopSamplerTemplateSampleTable ftgenonce 0, 0, 0, 1, gSInTimeSyncloopSamplerTemplatesampleFilePath, giInTimeSyncloopSamplerTemplateStartTime, 0, 0
endif

instr InTimeSyncloopSamplerTemplateHoldKnob
    ;Length each grain is held before moving onto the next.
    gkInTimeSyncloopSamplerTemplateHold linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateGrainSpacingKnob
    ;Grain spacing in playback. Turn to right for greater spacing between played grains (slower playback). Turn left for smaller spacing (faster playback).
    gkInTimeSyncloopSamplerTemplateGrainSpacing linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateWaveSpacingKnob
    ;This basically controls the number of grains generated from the wave sample. This value ranges from -300% to 300%. For normal playback, set both Grain Spacing and Wave Spacing to 100%. Small values mean more grains are used for the wave (smaller wave spacing). Using negative values results in reversed playback of the grains. NOTES: Grain playback order is reversed, not the sound contained in each grain.
    gkInTimeSyncloopSamplerTemplateWaveSpacing linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateFxDepthKnob
    ;Amplitude of the LFO applied to the wave spacing value. Turn to right to increase the amplitude. To turn the LFO off, turn the knob maximum to left.
    gkInTimeSyncloopSamplerTemplateFxDepth linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateFxSpeedKnob
    ;Speed of the LFO applied to the wave spacing value. Turning to right makes the LFO faster, turning left, slower.
    gkInTimeSyncloopSamplerTemplateFxSpeed linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplate
    iAmplitude flexibleAmplitudeInput p4

    iPitch flexiblePitchInput p5

    iPitch = iPitch / 261.6 ; Ratio of frequency to Middle C

    /* Below are two options for amplitude envelope. */
    kAmplitudeEnvelope madsr .005, .01, iAmplitude, .01, 0, (giInTimeSyncloopSamplerTemplateFileLength) ;Sample plays for note duration
    ;kAmplitudeEnvelope linenr iAmplitude, .05, (giInTimeSyncloopSamplerTemplateFileLength * 1/iPitch), 1 ; Sample plays through entirely

    /* MIDI Pitchbend */
    kPitchBend = 0
    midipitchbend kPitchBend
    kPitch = iPitch + kPitchBend

    /* This section sets up MIDI control mappings. There are two opcodes that could be used for assignment: midicontrolchange and ctrl7. I'm leaving them both in here pending a decision about which is better. ctrl7 can be called outside of this instrument. It would be nice to consolidate all of this setup in global space near the top of this file. Initial values for these controls are set in the mixer channel. */
    kInTimeSyncloopSamplerTemplateHoldAdjustment = 1
    kInTimeSyncloopSamplerTemplateGrainSpacingAdjustment = 1
    kInTimeSyncloopSamplerTemplateWaveSpacingAdjustment = 1
    kInTimeSyncloopSamplerTemplateFxDepthAdjustment = 0
    kInTimeSyncloopSamplerTemplateFxSpeedAdjustment = 1

    midicontrolchange giInTimeSyncloopSamplerTemplateHoldAdjustmentControl, kInTimeSyncloopSamplerTemplateHoldAdjustment, 1, 128
    midicontrolchange giInTimeSyncloopSamplerTemplateGrainSpacingAdjustmentControl, kInTimeSyncloopSamplerTemplateGrainSpacingAdjustment, 1, 128 ; this curve puts 1 at about 34
    midicontrolchange giInTimeSyncloopSamplerTemplateWaveSpacingAdjustmentControl, kInTimeSyncloopSamplerTemplateWaveSpacingAdjustment, 1, 128
    midicontrolchange giInTimeSyncloopSamplerTemplateFxDepthAdjustmentControl, kInTimeSyncloopSamplerTemplateFxDepthAdjustment, 1, 128
    midicontrolchange giInTimeSyncloopSamplerTemplateFxSpeedAdjustmentControl, kInTimeSyncloopSamplerTemplateFxSpeedAdjustment, 1, 128

    /*
    kInTimeSyncloopSamplerTemplateHoldAdjustment ctrl7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateHoldAdjustmentControl,  .01, 5
    kInTimeSyncloopSamplerTemplateGrainSpacingAdjustment ctrl7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateGrainSpacingAdjustmentControl,  .1, 3.5 ; this curve puts 1 at about 34
    kInTimeSyncloopSamplerTemplateWaveSpacingAdjustment ctrl7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateWaveSpacingAdjustmentControl,  .01, 3
    kInTimeSyncloopSamplerTemplateFxDepthAdjustment ctrl7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateFxDepthAdjustmentControl,  0, 3
    kInTimeSyncloopSamplerTemplateFxSpeedAdjustment ctrl7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateFxSpeedAdjustmentControl,  .1, 40
    */

    kInTimeSyncloopSamplerTemplateHold = gkInTimeSyncloopSamplerTemplateHold * (kInTimeSyncloopSamplerTemplateHoldAdjustment/65)^3
    kInTimeSyncloopSamplerTemplateGrainSpacing = gkInTimeSyncloopSamplerTemplateGrainSpacing * (kInTimeSyncloopSamplerTemplateGrainSpacingAdjustment/65)^2
    kInTimeSyncloopSamplerTemplateWaveSpacing = gkInTimeSyncloopSamplerTemplateWaveSpacing * (kInTimeSyncloopSamplerTemplateWaveSpacingAdjustment/65)^2
    kInTimeSyncloopSamplerTemplateFxDepth = gkInTimeSyncloopSamplerTemplateFxDepth * (kInTimeSyncloopSamplerTemplateFxDepthAdjustment/65)^2
    kInTimeSyncloopSamplerTemplateFxSpeed = gkInTimeSyncloopSamplerTemplateFxSpeed * (kInTimeSyncloopSamplerTemplateFxSpeedAdjustment/65)^2

    /* Syncloop Params */
    ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
    iMaxOverlaps = 50
    kGrainSizeInMiliseconds = kInTimeSyncloopSamplerTemplateHold
    kGrainSize = kGrainSizeInMiliseconds/1000
    kWaveSpacingOscillator oscil (kInTimeSyncloopSamplerTemplateFxDepth)/100*3, kInTimeSyncloopSamplerTemplateFxSpeed
    kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((kInTimeSyncloopSamplerTemplateGrainSpacing*1.852/100)^2)


    /* Wavespacing Factor */
    kInTimeSyncloopSamplerTemplateWaveSpacing = kInTimeSyncloopSamplerTemplateWaveSpacing - 50
    if kInTimeSyncloopSamplerTemplateWaveSpacing == 0 then
      kInTimeSyncloopSamplerTemplateWaveSpacing = 1
    endif

    kInTimeSyncloopSamplerTemplateWaveSpacing = (kInTimeSyncloopSamplerTemplateWaveSpacing / 34)^3 + kWaveSpacingOscillator
    kPointerRate = (1/iMaxOverlaps) * kInTimeSyncloopSamplerTemplateWaveSpacing

    /* Synthesis and Output */
    if giInTimeSyncloopSamplerTemplateFileNumChannels == 2 then
        aInTimeSyncloopSamplerTemplateL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate * giInTimeSyncloopSamplerTemplateFactor, 0, giInTimeSyncloopSamplerTemplateEndTime, giInTimeSyncloopSamplerTemplateSampleTableL, ienvelopeTable, iMaxOverlaps
        aInTimeSyncloopSamplerTemplateR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate * giInTimeSyncloopSamplerTemplateFactor, 0, giInTimeSyncloopSamplerTemplateEndTime, giInTimeSyncloopSamplerTemplateSampleTableR, ienvelopeTable, iMaxOverlaps

        aInTimeSyncloopSamplerTemplateL = aInTimeSyncloopSamplerTemplateL * kAmplitudeEnvelope
        aInTimeSyncloopSamplerTemplateR = aInTimeSyncloopSamplerTemplateR * kAmplitudeEnvelope
    else
        aInTimeSyncloopSamplerTemplateL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate * giInTimeSyncloopSamplerTemplateFactor, 0, giInTimeSyncloopSamplerTemplateEndTime, giInTimeSyncloopSamplerTemplateSampleTable, ienvelopeTable, iMaxOverlaps
        aInTimeSyncloopSamplerTemplateR = aInTimeSyncloopSamplerTemplateR * kAmplitudeEnvelope
        aInTimeSyncloopSamplerTemplateR = aInTimeSyncloopSamplerTemplateL
    endif

    outleta "InTimeSyncloopSamplerTemplateOutL", aInTimeSyncloopSamplerTemplateL
    outleta "InTimeSyncloopSamplerTemplateOutR", aInTimeSyncloopSamplerTemplateR
endin

instr InTimeSyncloopSamplerTemplateBassKnob
    gkInTimeSyncloopSamplerTemplateEqBass linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateMidKnob
    gkInTimeSyncloopSamplerTemplateEqMid linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateHighKnob
    gkInTimeSyncloopSamplerTemplateEqHigh linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateFader
    gkInTimeSyncloopSamplerTemplateFader linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplatePan
    gkInTimeSyncloopSamplerTemplatePan linseg p4, p3, p5
endin

instr InTimeSyncloopSamplerTemplateMixerChannel
    /* Set MIDI Control default values here. This would be better in global space where we define our global variables for this instrument but it was not working there for some reason. The mixer channel, as an instrument-specific always-on instrument is a convenient (if not semantic) place to do it. */
    initc7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateHoldAdjustmentControl, .5
    initc7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateGrainSpacingAdjustmentControl, .5
    initc7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateWaveSpacingAdjustmentControl, .5
    initc7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateFxDepthAdjustmentControl, .5
    initc7 giInTimeSyncloopSamplerTemplateMidiChannel, giInTimeSyncloopSamplerTemplateFxSpeedAdjustmentControl, .5
    /* End MIDI control settings */

    aInTimeSyncloopSamplerTemplateL inleta "InTimeSyncloopSamplerTemplateInL"
    aInTimeSyncloopSamplerTemplateR inleta "InTimeSyncloopSamplerTemplateInR"

    kInTimeSyncloopSamplerTemplateFader = gkInTimeSyncloopSamplerTemplateFader
    kInTimeSyncloopSamplerTemplatePan = gkInTimeSyncloopSamplerTemplatePan
    kInTimeSyncloopSamplerTemplateEqBass = gkInTimeSyncloopSamplerTemplateEqBass
    kInTimeSyncloopSamplerTemplateEqMid = gkInTimeSyncloopSamplerTemplateEqMid
    kInTimeSyncloopSamplerTemplateEqHigh = gkInTimeSyncloopSamplerTemplateEqHigh

    aInTimeSyncloopSamplerTemplateL, aInTimeSyncloopSamplerTemplateR threeBandEqStereo aInTimeSyncloopSamplerTemplateL, aInTimeSyncloopSamplerTemplateR, kInTimeSyncloopSamplerTemplateEqBass, kInTimeSyncloopSamplerTemplateEqMid, kInTimeSyncloopSamplerTemplateEqHigh

    if kInTimeSyncloopSamplerTemplatePan > 100 then
        kInTimeSyncloopSamplerTemplatePan = 100
    elseif kInTimeSyncloopSamplerTemplatePan < 0 then
        kInTimeSyncloopSamplerTemplatePan = 0
    endif

    aInTimeSyncloopSamplerTemplateL = (aInTimeSyncloopSamplerTemplateL * ((100 - kInTimeSyncloopSamplerTemplatePan) * 2 / 100)) * kInTimeSyncloopSamplerTemplateFader
    aInTimeSyncloopSamplerTemplateR = (aInTimeSyncloopSamplerTemplateR * (kInTimeSyncloopSamplerTemplatePan * 2 / 100)) * kInTimeSyncloopSamplerTemplateFader

    outleta "InTimeSyncloopSamplerTemplateOutL", aInTimeSyncloopSamplerTemplateL
    outleta "InTimeSyncloopSamplerTemplateOutR", aInTimeSyncloopSamplerTemplateR
endin
