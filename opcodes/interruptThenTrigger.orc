;interruptThenTrigger -- Accepts an instrument number. Tracks fractional modifiers, interrupts the last instance trigger this way and then returns an updated instrument number.

giLastUsedFractionalModifierList[] init 9999

opcode interruptThenTrigger, i, i
	iInstrumentNumber xin
  iInstrumentNumberToInterrupt = iInstrumentNumber + (giLastUsedFractionalModifierList[iInstrumentNumber] - 1)/1000
  iInstrumentNumber = iInstrumentNumber + (giLastUsedFractionalModifierList[iInstrumentNumber] )/1000

  if giLastUsedFractionalModifierList[iInstrumentNumber] == 999 then
    giLastUsedFractionalModifierList[iInstrumentNumber] = 1
  else
    giLastUsedFractionalModifierList[iInstrumentNumber] = giLastUsedFractionalModifierList[iInstrumentNumber] + 1
  endif
  turnoff2 iInstrumentNumberToInterrupt, 4, 1

  xout iInstrumentNumber
endop
