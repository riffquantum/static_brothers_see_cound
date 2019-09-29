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

    giBPM = 100

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "patterns/pattern-manifest.orc"

    instr Dummy
      midiMonitor
    endin


    alwayson "NewEffect"
    alwayson "NewInstrumentMixerChannel"

    gkNewInstrumentEqBass init 1
    gkNewInstrumentEqMid init 1
    gkNewInstrumentEqHigh init 1
    gkNewInstrumentFader init 1
    gkNewInstrumentPan init 50

    /* MIDI Config Values */
    massign giNewInstrumentMidiChannel, "NewInstrument"
    connect "NewInstrument", "NewInstrumentOutL", "NewEffect", "NewEffectInL"
    connect "NewInstrument", "NewInstrumentOutR", "NewEffect", "NewEffectInR"

    connect "NewEffect", "NewEffectOutL", "NewInstrumentMixerChannel", "NewInstrumentInL"
    connect "NewEffect", "NewEffectOutR", "NewInstrumentMixerChannel", "NewInstrumentInR"

    instr NewInstrument
      iAmplitude flexibleAmplitudeInput p4
      iPitch flexiblePitchInput p5

      aNewInstrumentL pluck iAmplitude, iPitch, iPitch, 0, 1
      aNewInstrumentR = aNewInstrumentL

      outleta "NewInstrumentOutL", aNewInstrumentL
      outleta "NewInstrumentOutR", aNewInstrumentR
    endin

    instr NewEffect
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


    connect "NewInstrumentMixerChannel", "NewInstrumentOutL", "Mixer", "MixerInL"
    connect "NewInstrumentMixerChannel", "NewInstrumentOutR", "Mixer", "MixerInR"
  </CsInstruments>

  <CsScore>
    #define bpm # 100 #
    t 0 [$bpm]
    i "Metronome" 0 3600

  </CsScore>
</CsoundSynthesizer>
