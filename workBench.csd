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
      midiMonitor
    endin

    giMetronomeIsOn = 1

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
      iPitch flexiblePitchInput p5
      iSineTable sineWave

      kTremolo = .75 + oscil(.25, 1.5, iSineTable)
      kAmplitudeEnvelope = madsr(.005, .01, iAmplitude, .5, 0)
      kAmplitudeEnvelope = kAmplitudeEnvelope * kTremolo


      aNewInstrumentL = oscil(kAmplitudeEnvelope*0.5, iPitch*1.1, iSineTable)
      aNewInstrumentL += oscil(kAmplitudeEnvelope, iPitch*1.1*.5, iSineTable)
      aNewInstrumentL += oscil(kAmplitudeEnvelope*0.25, iPitch*1.1*.9, iSineTable)

      aNewInstrumentR = oscil(kAmplitudeEnvelope*0.5, iPitch*.9, iSineTable)
      aNewInstrumentR += oscil(kAmplitudeEnvelope, iPitch*.9*.5, iSineTable)
      aNewInstrumentR += oscil(kAmplitudeEnvelope*0.25, iPitch*.9*.9, iSineTable)

      ;aNewInstrumentR = aNewInstrumentL

      outleta "NewInstrumentOutL", aNewInstrumentL
      outleta "NewInstrumentOutR", aNewInstrumentR
    endin

    instr NewEffect
      midiMonitor
      aNewEffectInL inleta "NewEffectInL"
      aNewEffectInR inleta "NewEffectInR"

      aNewEffectOutL = aNewEffectInL
      aNewEffectOutR = aNewEffectInR

      aNewEffectOutL += distortion(aNewEffectOutL, 1.3, .7, .1, .1)
      aNewEffectOutR += distortion(aNewEffectOutR, 1.3, .7, .1, .1)

      aNewEffectOutL = clip(aNewEffectOutL * 1.3, 1, 1, 0)
      aNewEffectOutR = clip(aNewEffectOutL * 1.3, 1, 1, 0)

      aNewEffectOutL = butterlp(aNewEffectOutL, 5000)
      aNewEffectOutR = butterlp(aNewEffectOutR, 5000)

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
  </CsInstruments>

  <CsScore>
    #define bpm # 100 #
    t 0 [$bpm]
    i "Metronome" 0 3600

  </CsScore>
</CsoundSynthesizer>
