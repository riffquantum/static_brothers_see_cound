;interruptThenTrigger -- Accepts an instrument number. Tracks fractional modifiers, interrupts the last instance triggered this way and then returns an updated instrument number.

giLastUsedFractionalModifierList[] init 9999

instr Interrupter
  iInstrumentNumberToInterrupt = p4

  turnoff2 iInstrumentNumberToInterrupt, 4, 1
endin

opcode interruptThenTrigger, 0, iiooooooo
	iBaseInstrumentNumber, iNewNoteDuration, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin
  iInstrumentNumber = iBaseInstrumentNumber

  iInstrumentNumberToInterrupt = iInstrumentNumber + (giLastUsedFractionalModifierList[iInstrumentNumber])/1000
  iInstrumentNumber = iInstrumentNumber + (giLastUsedFractionalModifierList[iInstrumentNumber] + 1)/1000

  if giLastUsedFractionalModifierList[iInstrumentNumber] == 999 then
    giLastUsedFractionalModifierList[iInstrumentNumber] = 1
  else
    giLastUsedFractionalModifierList[iInstrumentNumber] = giLastUsedFractionalModifierList[iInstrumentNumber] + 1
  endif

  if iInstrumentNumberToInterrupt > iBaseInstrumentNumber then
    event_i "i", "Interrupter", 0, 0.1, iInstrumentNumberToInterrupt
  endif

  event_i "i", iInstrumentNumber, 0, iNewNoteDuration, iP4, iP5, iP6, iP7, iP8, iP9, iP10
endop
