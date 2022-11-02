/*
  beatScoreline, _
  _ is an alias of beatScoreline.

  This opcode faciliates i events called from the orchestra instead of the score by wrapping
  schedule statements and calculating start times and durations based on the value of gkBPM.

  Global Variables:
    BPM - k - This opcode has no global variables scoped to it but it is heavily coupled
      with gkBPM which it uses to calculate timeing for events. Aliased to _ for convenience
      in sequencing.

  Input Arugments:
    SName -Instrument name for event to be called.
    iStart - Start time in beats for event to be called.
    iDuration - Duration in beats for event to be called.
    iP4 - Corresponds to p4 for the instrument to be called
    iP5 - Corresponds to p5 for the instrument to be called
    iP6 - Corresponds to p6 for the instrument to be called
    iP7 - Corresponds to p7 for the instrument to be called
    iP8 - Corresponds to p8 for the instrument to be called
    iP9 - Corresponds to p9 for the instrument to be called
    iP10 - Corresponds to p10 for the instrument to be called
    iP11 - Corresponds to p11 for the instrument to be called
    iP12 - Corresponds to p12 for the instrument to be called
    iP13 - Corresponds to p13 for the instrument to be called

  Outputs:
    none
*/

opcode _, 0, Siioooooooooooooooo
  SName, iStart, iDuration, iP4, iP5, iP6, iP7, iP8, iP9, iP10, iP11, iP12, iP13, iP14, iP15, iP16, iP17, iP18, iP19 xin

  beatScoreline SName, iStart, iDuration, iP4, iP5, iP6, iP7, iP8, iP9, iP10, iP11, iP12, iP13, iP14, iP15, iP16, iP17, iP18, iP19
endop
