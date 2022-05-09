/*
  Section
  This is purely a utility instrument for laying out your top level score. By wrapping your highest level composotional
  instruments (ie. "Verse", "Chorus", "Bridge1") in this instrument you can take advantage of the score's Carry
  preprocessing and use things like `+`, `.`, or `^+x`. See documentation here: http://www.csounds.com/manual/html/ScoreTop.html#ScoreCarry.


  P Fields:
    p4 - InstrumentName - String - The name of the instrument to be activated. Becomes p1 of
      the section's i statement.
    p5...p8 - All pfields after p4 will be passed through to the section's i statement in
      the next slot down. p5 becomes p4, p6 becomes p5, and so on.
*/

instr Section
  SInstrumentName = p4

  beatScoreline SInstrumentName, 0, secondsToBeats(p3), p5, p6, p7, p8
endin
