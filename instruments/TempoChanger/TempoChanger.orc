alwayson "TempoMaintainer"

instr TempoMaintainer
  kTempoValue miditempo
  iInitialTempoValue = i(kTempoValue)
  gkBPM init iInitialTempoValue

  tempo gkBPM, iInitialTempoValue

  ; printks "gkBPM:       %f %n", .5, gkBPM
  ; printks "kTempoValue: %f %n", .5, kTempoValue
  ; printsBlockI iInitialTempoValue
endin

instr TempoChanger
  iCurrentBPM = i(gkBPM)
  iNewTempo = p4

  if p3 <= .1 then
    gkBPM = iNewTempo
  else
    gkBPM linseg iCurrentBPM, p3, iNewTempo
  endif
endin
