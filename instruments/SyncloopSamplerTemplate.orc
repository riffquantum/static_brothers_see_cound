instrumentRoute "SyncloopSamplerTemplate", "Mixer"
alwayson "SyncloopSamplerTemplateMixerChannel"

gkSyncloopSamplerTemplateHold init 40 ;12.8
gkSyncloopSamplerTemplateGrainSpacing init 54 ;54 - default setting for normal playback
gkSyncloopSamplerTemplateWaveSpacing init 84 ;84 - default setting for normal playback
gkSyncloopSamplerTemplateFxDepth init 0 ;0
gkSyncloopSamplerTemplateFxSpeed init .8
gkSyncloopSamplerTemplateRandomize init 0

gkSyncloopSamplerTemplateEqBass init 1
gkSyncloopSamplerTemplateEqMid init 1
gkSyncloopSamplerTemplateEqHigh init 1
gkSyncloopSamplerTemplateFader init 1
gkSyncloopSamplerTemplatePan init 50

/* MIDI Config Values */
giSyncloopSamplerTemplateHoldAdjustmentControl = 1
giSyncloopSamplerTemplateGrainSpacingAdjustmentControl = 2
giSyncloopSamplerTemplateWaveSpacingAdjustmentControl = 7
giSyncloopSamplerTemplateFxDepthAdjustmentControl = 4
giSyncloopSamplerTemplateFxSpeedAdjustmentControl = 5

/* Sound File Data */
gSSyncloopSamplerTemplatesampleFilePath = "instruments/breakBeatInstruments/AmenBreak.wav"
giSyncloopSamplerTemplateFileNumChannels filenchnls gSSyncloopSamplerTemplatesampleFilePath
giSyncloopSamplerTemplateFileLength filelen gSSyncloopSamplerTemplatesampleFilePath
giSyncloopSamplerTemplateFileSampleRate filesr gSSyncloopSamplerTemplatesampleFilePath
giSyncloopSamplerTemplateStartTime = 0
giSyncloopSamplerTemplateEndTime = giSyncloopSamplerTemplateFileLength

if giSyncloopSamplerTemplateFileNumChannels == 2 then
  giSyncloopSamplerTemplateSampleTableL ftgenonce 0, 0, 0, 1, gSSyncloopSamplerTemplatesampleFilePath, giSyncloopSamplerTemplateStartTime, 0, 1
  giSyncloopSamplerTemplateSampleTableR ftgenonce 0, 0, 0, 1, gSSyncloopSamplerTemplatesampleFilePath, giSyncloopSamplerTemplateStartTime, 0, 2
else
  giSyncloopSamplerTemplateSampleTable ftgenonce 0, 0, 0, 1, gSSyncloopSamplerTemplatesampleFilePath, giSyncloopSamplerTemplateStartTime, 0, 0
endif

instr SyncloopSamplerTemplateHoldKnob
  ;Length each grain is held before moving onto the next.
  gkSyncloopSamplerTemplateHold linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateGrainSpacingKnob
  ;Grain spacing in playback. Turn to right for greater spacing between played grains (slower playback). Turn left for smaller spacing (faster playback).
  gkSyncloopSamplerTemplateGrainSpacing linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateWaveSpacingKnob
  ;This basically controls the number of grains generated from the wave sample. This value ranges from -300% to 300%. For normal playback, set both Grain Spacing and Wave Spacing to 100%. Small values mean more grains are used for the wave (smaller wave spacing). Using negative values results in reversed playback of the grains. NOTES: Grain playback order is reversed, not the sound contained in each grain.
  gkSyncloopSamplerTemplateWaveSpacing linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateFxDepthKnob
  ;Amplitude of the LFO applied to the wave spacing value. Turn to right to increase the amplitude. To turn the LFO off, turn the knob maximum to left.
  gkSyncloopSamplerTemplateFxDepth linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateFxSpeedKnob
  ;Speed of the LFO applied to the wave spacing value. Turning to right makes the LFO faster, turning left, slower.
  gkSyncloopSamplerTemplateFxSpeed linseg p4, p3, p5
endin

instr SyncloopSamplerTemplate
  iAmplitude flexibleAmplitudeInput p4
  iPitch = flexiblePitchInput(p5) / 261.6 ; Ratio of frequency to Middle C
  kAmplitudeEnvelope = madsr(.005, .01, 1, .01, 0, (giSyncloopSamplerTemplateFileLength)) * iAmplitude

  /* MIDI Pitchbend */
  kPitchBend = 0
  midipitchbend kPitchBend
  kPitch = iPitch + kPitchBend

  /* This section sets up MIDI control mappings. There are two opcodes that could be used for assignment: midicontrolchange and ctrl7. I'm leaving them both in here pending a decision about which is better. ctrl7 can be called outside of this instrument. It would be nice to consolidate all of this setup in global space near the top of this file. Initial values for these controls are set in the mixer channel. */
  kSyncloopSamplerTemplateHoldAdjustment = 1
  kSyncloopSamplerTemplateGrainSpacingAdjustment = 1
  kSyncloopSamplerTemplateWaveSpacingAdjustment = 1
  kSyncloopSamplerTemplateFxDepthAdjustment = 0
  kSyncloopSamplerTemplateFxSpeedAdjustment = 1

  midicontrolchange giSyncloopSamplerTemplateHoldAdjustmentControl, kSyncloopSamplerTemplateHoldAdjustment, 1, 128
  midicontrolchange giSyncloopSamplerTemplateGrainSpacingAdjustmentControl, kSyncloopSamplerTemplateGrainSpacingAdjustment, 1, 128 ; this curve puts 1 at about 34
  midicontrolchange giSyncloopSamplerTemplateWaveSpacingAdjustmentControl, kSyncloopSamplerTemplateWaveSpacingAdjustment, 1, 128
  midicontrolchange giSyncloopSamplerTemplateFxDepthAdjustmentControl, kSyncloopSamplerTemplateFxDepthAdjustment, 1, 128
  midicontrolchange giSyncloopSamplerTemplateFxSpeedAdjustmentControl, kSyncloopSamplerTemplateFxSpeedAdjustment, 1, 128

  /*
  kSyncloopSamplerTemplateHoldAdjustment ctrl7 giSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateHoldAdjustmentControl,  .01, 5
  kSyncloopSamplerTemplateGrainSpacingAdjustment ctrl7 giSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateGrainSpacingAdjustmentControl,  .1, 3.5 ; this curve puts 1 at about 34
  kSyncloopSamplerTemplateWaveSpacingAdjustment ctrl7 giSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateWaveSpacingAdjustmentControl,  .01, 3
  kSyncloopSamplerTemplateFxDepthAdjustment ctrl7 giSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateFxDepthAdjustmentControl,  0, 3
  kSyncloopSamplerTemplateFxSpeedAdjustment ctrl7 giSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateFxSpeedAdjustmentControl,  .1, 40
  */

  kSyncloopSamplerTemplateHold = gkSyncloopSamplerTemplateHold * (kSyncloopSamplerTemplateHoldAdjustment/65)^3
  kSyncloopSamplerTemplateGrainSpacing = gkSyncloopSamplerTemplateGrainSpacing * (kSyncloopSamplerTemplateGrainSpacingAdjustment/65)^2
  kSyncloopSamplerTemplateWaveSpacing = gkSyncloopSamplerTemplateWaveSpacing * (kSyncloopSamplerTemplateWaveSpacingAdjustment/65)^2
  kSyncloopSamplerTemplateFxDepth = gkSyncloopSamplerTemplateFxDepth * (kSyncloopSamplerTemplateFxDepthAdjustment/65)^2
  kSyncloopSamplerTemplateFxSpeed = gkSyncloopSamplerTemplateFxSpeed * (kSyncloopSamplerTemplateFxSpeedAdjustment/65)^2

  /* Syncloop Params */
  ienvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0 ; HALF A SINE WAVE
  iMaxOverlaps = 5
  kGrainSizeInMiliseconds = kSyncloopSamplerTemplateHold
  kGrainSize = kGrainSizeInMiliseconds/1000
  kWaveSpacingOscillator oscil (kSyncloopSamplerTemplateFxDepth)/100*3, kSyncloopSamplerTemplateFxSpeed
  kGrainFrequency = iMaxOverlaps/kGrainSize * 1/((kSyncloopSamplerTemplateGrainSpacing*1.852/100)^2)


  /* Wavespacing Factor */
  kSyncloopSamplerTemplateWaveSpacing = kSyncloopSamplerTemplateWaveSpacing - 50
  if kSyncloopSamplerTemplateWaveSpacing == 0 then
    kSyncloopSamplerTemplateWaveSpacing = 1
  endif

  kSyncloopSamplerTemplateWaveSpacing = (kSyncloopSamplerTemplateWaveSpacing / 34)^3 + kWaveSpacingOscillator
  kPointerRate = (1/iMaxOverlaps) * kSyncloopSamplerTemplateWaveSpacing

  /* Synthesis and Output */
  if giSyncloopSamplerTemplateFileNumChannels == 2 then
      aSyncloopSamplerTemplateL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giSyncloopSamplerTemplateEndTime, giSyncloopSamplerTemplateSampleTableL, ienvelopeTable, iMaxOverlaps
      aSyncloopSamplerTemplateR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giSyncloopSamplerTemplateEndTime, giSyncloopSamplerTemplateSampleTableR, ienvelopeTable, iMaxOverlaps

      aSyncloopSamplerTemplateL = aSyncloopSamplerTemplateL * kAmplitudeEnvelope
      aSyncloopSamplerTemplateR = aSyncloopSamplerTemplateR * kAmplitudeEnvelope
  else
      aSyncloopSamplerTemplateL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giSyncloopSamplerTemplateEndTime, giSyncloopSamplerTemplateSampleTable, ienvelopeTable, iMaxOverlaps
      aSyncloopSamplerTemplateR = aSyncloopSamplerTemplateR * kAmplitudeEnvelope
      aSyncloopSamplerTemplateR = aSyncloopSamplerTemplateL
  endif

  outleta "OutL", aSyncloopSamplerTemplateL
  outleta "OutR", aSyncloopSamplerTemplateR
endin

instr SyncloopSamplerTemplateBassKnob
  gkSyncloopSamplerTemplateEqBass linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateMidKnob
  gkSyncloopSamplerTemplateEqMid linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateHighKnob
  gkSyncloopSamplerTemplateEqHigh linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateFader
  gkSyncloopSamplerTemplateFader linseg p4, p3, p5
endin

instr SyncloopSamplerTemplatePan
  gkSyncloopSamplerTemplatePan linseg p4, p3, p5
endin

instr SyncloopSamplerTemplateMixerChannel
  /* Set MIDI Control default values here. This would be better in global space where we define our global variables for this instrument but it was not working there for some reason. The mixer channel, as an instrument-specific always-on instrument is a convenient (if not semantic) place to do it. */
  ; iSyncloopSamplerTemplateMidiChannel = 0
  ; initc7 iSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateHoldAdjustmentControl, .5
  ; initc7 iSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateGrainSpacingAdjustmentControl, .5
  ; initc7 iSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateWaveSpacingAdjustmentControl, .5
  ; initc7 iSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateFxDepthAdjustmentControl, .5
  ; initc7 iSyncloopSamplerTemplateMidiChannel, giSyncloopSamplerTemplateFxSpeedAdjustmentControl, .5
  /* End MIDI control settings */

  aSyncloopSamplerTemplateL inleta "InL"
  aSyncloopSamplerTemplateR inleta "InR"

  aSyncloopSamplerTemplateL, aSyncloopSamplerTemplateR mixerChannel aSyncloopSamplerTemplateL, aSyncloopSamplerTemplateR, gkSyncloopSamplerTemplateFader, gkSyncloopSamplerTemplatePan, gkSyncloopSamplerTemplateEqBass, gkSyncloopSamplerTemplateEqMid, gkSyncloopSamplerTemplateEqHigh

  outleta "OutL", aSyncloopSamplerTemplateL
  outleta "OutR", aSyncloopSamplerTemplateR
endin
