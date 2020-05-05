<CsoundSynthesizer>
  <CsOptions>
      -odac -Ma  -m0
      -iadc
      -B512 -b128

      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"

    gkBPM init 140

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    instr Dummy
      ; midiMonitor
    endin

    giMetronomeIsOn = 0

    alwayson "NewEffect"
    alwayson "NewEffectMixerChannel"
    alwayson "NewInstrumentMixerChannel"

    gkNewInstrumentEqBass init 1
    gkNewInstrumentEqMid init 1
    gkNewInstrumentEqHigh init 1
    gkNewInstrumentFader init 1
    gkNewInstrumentPan init 50
    gSNewInstrumentName = "NewInstrument"
    gSNewInstrumentRoute = "NewEffect"
    instrumentRoute gSNewInstrumentName, gSNewInstrumentRoute

    gkNewEffectEqBass init 1
    gkNewEffectEqMid init 1
    gkNewEffectEqHigh init 1
    gkNewEffectFader init 1
    gkNewEffectPan init 50
    gSNewEffectName = "NewEffect"
    gSNewEffectRoute = "Mixer"
    instrumentRoute gSNewEffectName, gSNewEffectRoute

    gSNewInstrumentSampleFilePath = "localSamples/blueangel4.wav"
    giNewInstrumentNumberOfChannels filenchnls gSNewInstrumentSampleFilePath
    giNewInstrumentSampleLength filelen gSNewInstrumentSampleFilePath
    giNewInstrumentStartTime = 1
    giNewInstrumentEndTime = giNewInstrumentSampleLength
    giNewInstrumentEnvelopeTable ftgenonce 2, 0, 16384, 9, 0.5, 1, 0
    giNewInstrumentSampleRate filesr gSNewInstrumentSampleFilePath

    if giNewInstrumentNumberOfChannels == 2 then
        giNewInstrumentSampleTableL ftgenonce 0, 0, 0, 1, gSNewInstrumentSampleFilePath, giNewInstrumentStartTime, 0, 1
        giNewInstrumentSampleTableR ftgenonce 0, 0, 0, 1, gSNewInstrumentSampleFilePath, giNewInstrumentStartTime, 0, 2
    else
        giNewInstrumentSampleTable ftgenonce 0, 0, 0, 1, gSNewInstrumentSampleFilePath, giNewInstrumentStartTime, 0, 0
    endif

    /* MIDI Config Values */
    massign giNewInstrumentMidiChannel, "NewInstrument"

    instr NewInstrument
      iAmplitude flexibleAmplitudeInput p4
      kAmplitudeEnvelope madsr .005, .01, iAmplitude, .5
      kPitch = flexiblePitchInput(p5) / 261.6

      kTimeStretch linseg 1, 1, .5
      kGrainSizeAdjustment = .1
      kGrainFrequencyAdjustment = 1
      kPitchAdjustment linseg 2.5, .25, 2.75
      kGrainOverlapPercentageAdjustment = 1

      kPitch *= kPitchAdjustment
      kGrainOverlapPercentage = 88 * kGrainOverlapPercentageAdjustment
      kGrainSize = 0.01 * kGrainSizeAdjustment
      kGrainFrequency = 1/(kGrainSize/(100/kGrainOverlapPercentage)) * kGrainFrequencyAdjustment
      kPointerRate = kTimeStretch * kGrainOverlapPercentage/100

      iMaxOverlaps = 1000

      if giNewInstrumentNumberOfChannels == 2 then
        aNewInstrumentL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giNewInstrumentEndTime, giNewInstrumentSampleTableL, giNewInstrumentEnvelopeTable, iMaxOverlaps

        aNewInstrumentR syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giNewInstrumentEndTime, giNewInstrumentSampleTableR, giNewInstrumentEnvelopeTable, iMaxOverlaps

        aNewInstrumentL = aNewInstrumentL * kAmplitudeEnvelope
        aNewInstrumentR = aNewInstrumentR * kAmplitudeEnvelope
      else
        aNewInstrumentL syncloop 1, kGrainFrequency, kPitch, kGrainSize, kPointerRate, 0, giNewInstrumentEndTime, giNewInstrumentSampleTable, giNewInstrumentEnvelopeTable, iMaxOverlaps

        aNewInstrumentR = aNewInstrumentR * kAmplitudeEnvelope

        aNewInstrumentR = aNewInstrumentL
      endif

      outleta "NewInstrumentOutL", aNewInstrumentL
      outleta "NewInstrumentOutR", aNewInstrumentR
    endin

    instr NewEffect
      ; midiMonitor
      aNewEffectInL inleta "NewEffectInL"
      aNewEffectInR inleta "NewEffectInR"

      aNewEffectOutL = aNewEffectInL
      aNewEffectOutR = aNewEffectInR

      outleta "NewEffectOutL", aNewEffectOutL
      outleta "NewEffectOutR", aNewEffectOutR
    endin

    instr NewInstrumentBassKnob
      gkNewInstrumentEqBass linseg p4, p3, p5
    endin

    instr NewInstrumentMidKnob
      gkNewInstrumentEqMid linseg p4, p3, p5
    endin

    instr NewInstrumentHighKnob
      gkNewInstrumentEqHigh linseg p4, p3, p5
    endin

    instr NewInstrumentFader
      gkNewInstrumentFader linseg p4, p3, p5
    endin

    instr NewInstrumentPan
      gkNewInstrumentPan linseg p4, p3, p5
    endin

    instr NewInstrumentMixerChannel
      aNewInstrumentL inleta "NewInstrumentInL"
      aNewInstrumentR inleta "NewInstrumentInR"

      kNewInstrumentFader = gkNewInstrumentFader
      kNewInstrumentPan = gkNewInstrumentPan
      kNewInstrumentEqBass = gkNewInstrumentEqBass
      kNewInstrumentEqMid = gkNewInstrumentEqMid
      kNewInstrumentEqHigh = gkNewInstrumentEqHigh

      aNewInstrumentL, aNewInstrumentR threeBandEqStereo aNewInstrumentL, aNewInstrumentR, kNewInstrumentEqBass, kNewInstrumentEqMid, kNewInstrumentEqHigh

      if kNewInstrumentPan > 100 then
          kNewInstrumentPan = 100
      elseif kNewInstrumentPan < 0 then
          kNewInstrumentPan = 0
      endif

      aNewInstrumentL = (aNewInstrumentL * ((100 - kNewInstrumentPan) * 2 / 100)) * kNewInstrumentFader
      aNewInstrumentR = (aNewInstrumentR * (kNewInstrumentPan * 2 / 100)) * kNewInstrumentFader

      outleta "NewInstrumentOutL", aNewInstrumentL
      outleta "NewInstrumentOutR", aNewInstrumentR
    endin

    instr NewEffectBassKnob
      gkNewEffectEqBass linseg p4, p3, p5
    endin

    instr NewEffectMidKnob
      gkNewEffectEqMid linseg p4, p3, p5
    endin

    instr NewEffectHighKnob
      gkNewEffectEqHigh linseg p4, p3, p5
    endin

    instr NewEffectFader
      gkNewEffectFader linseg p4, p3, p5
    endin

    instr NewEffectPan
      gkNewEffectPan linseg p4, p3, p5
    endin

    instr NewEffectMixerChannel
      aNewEffectL inleta "NewEffectInL"
      aNewEffectR inleta "NewEffectInR"

      kNewEffectFader = gkNewEffectFader
      kNewEffectPan = gkNewEffectPan
      kNewEffectEqBass = gkNewEffectEqBass
      kNewEffectEqMid = gkNewEffectEqMid
      kNewEffectEqHigh = gkNewEffectEqHigh

      aNewEffectL, aNewEffectR threeBandEqStereo aNewEffectL, aNewEffectR, kNewEffectEqBass, kNewEffectEqMid, kNewEffectEqHigh

      if kNewEffectPan > 100 then
          kNewEffectPan = 100
      elseif kNewEffectPan < 0 then
          kNewEffectPan = 0
      endif

      aNewEffectL = (aNewEffectL * ((100 - kNewEffectPan) * 2 / 100)) * kNewEffectFader
      aNewEffectR = (aNewEffectR * (kNewEffectPan * 2 / 100)) * kNewEffectFader

      outleta "NewEffectOutL", aNewEffectL
      outleta "NewEffectOutR", aNewEffectR
    endin

    instr WorkingPattern
      iPatternLength = p3 * i(gkBPM)/60

      iBeatsPerMeasure = 4
      iMeasureIndex = 0

      until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureIndex*iBeatsPerMeasure
        iMeasureCount = iMeasureIndex + 1

        beatScoreline "Kick", iBaseTime+0.0, 4, 4, .9

        iMeasureIndex += 1
      od
    endin

  </CsInstruments>

  <CsScore>
    #define bpm # 100 #
    t 0 [$bpm]
    i "Metronome" 0 3600
    i "WorkingPattern" 0 3600

  </CsScore>
</CsoundSynthesizer>
