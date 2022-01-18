/*
  flexiblePitchInput
  This opcode handles pitch input for instruments that can be triggered as
  score events or by MIDI input. If an explicit pitch is passed in, it will
  interpret it and return a frequency in Hertz. If no pitch is passed in then
  it will look for a note number in a MIDI event using the `notnum` opcode.

  Global Variables
    giGlobalTuningSystem - i - An integer corresponding to a tuning system.
    Integers are associated with particular tuning systems in the opcode
    selectTuningSystemAndReturnFrequency. flexiblePitchInput accepts a scoped
    tuning system as an argument but will fall back to the global value if none
    is provided.

  Input Arugments:
    iPitch - The pitch to be intepreted. If the value is 0 then the opcode will
      look for MIDI information. If value is greater than 15 it will be
      interpreted as a frequency in Hertz and simply passed through. Otherwise
      it will be treated as a pitch class value and converted to hertz according
      to the selected tuning system.
    iTuningSystem - An integer referring to the tuning system through which the
      pitch class should be should be interpreted. Integers are associated with particular tuning systems in the selectTuningSystemAndReturnFrequency
      opcode. This serves as a means of overriding the global tuning system for
      an individual instrument.
    iDivisionsInTuningSystem - The number of divisions in the tuning system.
      Used to split up MIDI note numbers into octaves. TO DO: This could likely
      be eliminated by setting up a global config with these values in the
      selectTuningSystemAndReturnFrequency opcode.

  Outputs:
    iFrequency - a frequency value in Hertz.

  To Do:
    Consider building Midi pitch bend into this. It might be best to leave that up
    individual instrument definitions though.
*/
opcode flexiblePitchInput, i, ijo
  iPitch, iTuningSystem, iDivisionsInTuningSystem xin
  iTuningSystem = iTuningSystem == -1 ? giGlobalTuningSystem : iTuningSystem
  iDivisionsInTuningSystem = iDivisionsInTuningSystem == 0 ? giDivisionsInTuningSystem : iDivisionsInTuningSystem

  if iPitch == 0 then
    iPitch midiNoteNumberToPitchClassValue notnum(), iDivisionsInTuningSystem
  endif

  if iPitch < 15 then
    iFrequency selectTuningSystemAndReturnFrequency iPitch, iTuningSystem
  else
    iFrequency = iPitch
  endif

  xout iFrequency
endop
