opcode instrumentToggle, 0, i
  iInstrumentNumber xin

  iInstrumentIsActive active iInstrumentNumber

  if iInstrumentIsActive > 0 then
    turnoff2 iInstrumentNumber, 8, 1
  else
    event_i "i", iInstrumentNumber, 0, -1
  endif
endop
