;interruptThenTrigger -- Accepts an instrument number. Tracks fractional modifiers, interrupts the last instance triggered this way and then returns an updated instrument number.

giLastUsedFractionalModifierList[] init 9999

opcode interruptThenTrigger, 0, iioooooo
	iInstrumentNumber, iNewNoteDuration, iP4, iP5, iP6, iP7, iP8, iP9 xin
  iInstrumentNumberToInterrupt = iInstrumentNumber + (giLastUsedFractionalModifierList[iInstrumentNumber] - 1)/1000
  iInstrumentNumber = iInstrumentNumber + (giLastUsedFractionalModifierList[iInstrumentNumber] )/1000

  if giLastUsedFractionalModifierList[iInstrumentNumber] == 999 then
    giLastUsedFractionalModifierList[iInstrumentNumber] = 1
  else
    giLastUsedFractionalModifierList[iInstrumentNumber] = giLastUsedFractionalModifierList[iInstrumentNumber] + 1
  endif
  turnoff2 iInstrumentNumberToInterrupt, 4, 1

  event_i "i", iInstrumentNumber, 0, iNewNoteDuration, iP4, iP5, iP6, iP7, iP8, iP9
endop
