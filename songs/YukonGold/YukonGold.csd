<CsoundSynthesizer>
  <CsOptions>
      -odac -Ma  -m0
      -iadc
      -B512 -b60
      -t80

      ;--midioutfile=midiout.mid
      ;-F midiout.mid
      ;-+rtmidi=virtual
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

    #include "instruments/DrumKits/DefaultDrumKit/DefaultDrumKit-manifest.orc"
    #include "songs/YukonGold/instruments/orchestra-manifest.orc"
    #include "songs/YukonGold/patterns/pattern-manifest.orc"

    instr config
      gkRingModForLeadSynthFader = .5
      gkLeadSynthFader = .5
      gkRingModForLeadSynthModulator1Frequency = oscil(10, .1) + 2000
      gkRingModForLeadSynthModulator1Ammount = oscil(.4, .07) + .4
      gkRingModForLeadSynthModulator2Frequency = oscil(100, .01) + 500
      gkRingModForLeadSynthModulator2Ammount = oscil(.25, .3) + .25
      gkRingModForLeadSynthModulator3Frequency = 0
      gkRingModForLeadSynthModulator3Ammount = 0
      gkRingModForLeadSynthModulator4Frequency = 0
      gkRingModForLeadSynthModulator4Ammount = 0
      gkRingModForLeadSynthModulator5Frequency = 0
      gkRingModForLeadSynthModulator5Ammount = 0
      gkDefaultDrumKitReverbWet = oscil(.0005, .1) + 0.01
      gkDefaultDrumKitBusFader = 1.3
    endin

  </CsInstruments>

  <CsScore>
    i "config" 0 .1
    i "bassPattern1" 0 64
    i "synthPattern1" 0 64
    i "drumPattern1" 8 56
    i "synthLead1" 16 48
    i "RafflesiaBreak" 0 64 60 1
  </CsScore>
</CsoundSynthesizer>
