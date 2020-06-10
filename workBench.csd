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

    /* MIDI Config Values */
    massign giNewInstrumentMidiChannel, "NewInstrument"

    instr NewInstrument
      iAmplitude flexibleAmplitudeInput p4
      kPitch = flexiblePitchInput(p5)

      aNewInstrumentL = 0
      aNewInstrumentR = 0


      outleta "OutL", aNewInstrumentL
      outleta "OutR", aNewInstrumentR
    endin

    instr NewEffect
      ; midiMonitor
      aNewEffectInL inleta "InL"
      aNewEffectInR inleta "InR"

      aNewEffectOutL = aNewEffectInL
      aNewEffectOutR = aNewEffectInR

      outleta "OutL", aNewEffectOutL
      outleta "OutR", aNewEffectOutR
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
      aNewInstrumentL inleta "InL"
      aNewInstrumentR inleta "InR"

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

      outleta "OutL", aNewInstrumentL
      outleta "OutR", aNewInstrumentR
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
      aNewEffectL inleta "InL"
      aNewEffectR inleta "InR"

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

      outleta "OutL", aNewEffectL
      outleta "OutR", aNewEffectR
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
