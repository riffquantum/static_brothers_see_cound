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

      connect "newInstrument", "newInstrumentOutL", "newInstrumentMixerChannel", "newInstrumentInL"
      connect "newInstrument", "newInstrumentOutR", "newInstrumentMixerChannel", "newInstrumentInR"

      alwayson "newInstrument"
      alwayson "newInstrumentMixerChannel"

      gknewInstrumentHold init 40 ;12.8
      gknewInstrumentGrainSpacing init 54 ;54 - default setting for normal playback
      gknewInstrumentWaveSpacing init 84 ;84 - default setting for normal playback
      gknewInstrumentFxDepth init 0 ;0
      gknewInstrumentFxSpeed init .8
      gknewInstrumentRandomize init 0

      gknewInstrumentEqBass init 1
      gknewInstrumentEqMid init 1
      gknewInstrumentEqHigh init 1
      gknewInstrumentFader init 1
      gknewInstrumentPan init 50

      /* MIDI Config Values */
      ;massign ginewInstrumentMidiChannel, "newInstrument"
      ;alwayson "newInstrument"

      instr newInstrument

          anewInstrumentL = 0
          anewInstrumentR = 0

          midiMonitor

          outleta "newInstrumentOutL", anewInstrumentL
          outleta "newInstrumentOutR", anewInstrumentR
      endin

      instr newInstrumentBassKnob
          gknewInstrumentEqBass linseg p4, p3, p5
      endin

      instr newInstrumentMidKnob
          gknewInstrumentEqMid linseg p4, p3, p5
      endin

      instr newInstrumentHighKnob
          gknewInstrumentEqHigh linseg p4, p3, p5
      endin

      instr newInstrumentFader
          gknewInstrumentFader linseg p4, p3, p5
      endin

      instr newInstrumentPan
          gknewInstrumentPan linseg p4, p3, p5
      endin

      instr newInstrumentMixerChannel
          anewInstrumentL inleta "newInstrumentInL"
          anewInstrumentR inleta "newInstrumentInR"

          knewInstrumentFader = gknewInstrumentFader
          knewInstrumentPan = gknewInstrumentPan
          knewInstrumentEqBass = gknewInstrumentEqBass
          knewInstrumentEqMid = gknewInstrumentEqMid
          knewInstrumentEqHigh = gknewInstrumentEqHigh

          anewInstrumentL, anewInstrumentR threeBandEqStereo anewInstrumentL, anewInstrumentR, knewInstrumentEqBass, knewInstrumentEqMid, knewInstrumentEqHigh

          if knewInstrumentPan > 100 then
              knewInstrumentPan = 100
          elseif knewInstrumentPan < 0 then
              knewInstrumentPan = 0
          endif

          anewInstrumentL = (anewInstrumentL * ((100 - knewInstrumentPan) * 2 / 100)) * knewInstrumentFader
          anewInstrumentR = (anewInstrumentR * (knewInstrumentPan * 2 / 100)) * knewInstrumentFader

          outleta "newInstrumentOutL", anewInstrumentL
          outleta "newInstrumentOutR", anewInstrumentR
      endin


      connect "newInstrumentMixerChannel", "newInstrumentOutL", "Mixer", "MixerInL"
      connect "newInstrumentMixerChannel", "newInstrumentOutR", "Mixer", "MixerInR"
    </CsInstruments>

    <CsScore>
        #define bpm # 100 #
        t 0 [$bpm]
        i "Metronome" 0 3600

    </CsScore>
</CsoundSynthesizer>
