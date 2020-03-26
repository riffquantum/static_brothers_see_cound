alwayson "TempoMaintainer"
instr TempoMaintainer
  tempo gkBPM, i(gkBPM)
  printk2 gkBPM
endin

instr TempoChanger
  iCurrentBPM = i(gkBPM)
  iNewTempo = p4

  if p3 <= .1 then
    gkBPM = iNewTempo
  else
    gkBPM linseg iCurrentBPM, p3-(p3*.01), iNewTempo, (p3*.01), iNewTempo
  endif
endin

massign giTempoKnobMidiChannel, "TempoKnob"
instr TempoKnob
  initc7 giTempoKnobMidiChannel, 1, .5

  midicontrolchange 1, gkBPM, 1, 400

  printk2 gkBPM
endin
