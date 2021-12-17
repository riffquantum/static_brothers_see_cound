/*
  ARPEGGIATOR
  Creates a pair of instruments that arpeggiate another instrument by triggering notes according to
  a given table of pitches.

  Global Variables:
    Index - i - Used internally to iterate across the arpeggio.
    Notes - i, ftable - A table of pitches that constitute the arpeggio to play.
    NoteDuration - k - The duration of notes triggered.
    NoteFrequency - k - The frequency at which notes will be triggered as notes per second.
    InstrumentToArpegiate

  P Fields:
    p4 - Velocity - Number - A velocity expressed as a number between 0 and 127.
    p5 - Starting Pitch - Number - The starting pitch for the arpeggio. Should be
      written as a pitch class value.
    p6 - Number - DurationOfNotes - Modifies global duration for the instance by multiplication.
      0 defaults to 1.
    p7 - Number - FrequencyOfNotes - Modifies global frequency for the instance by multiplication.
      0 defaults to 1.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    INSTRUMENT_TO_ARPEGGIATE - String - Name of the instrument to be triggered by the Arpeggiator
*/

#define ARPEGGIATOR(INSTRUMENT_NAME'INSTRUMENT_TO_ARPEGGIATE) #
  gi$INSTRUMENT_NAME.Index init 0
  gi$INSTRUMENT_NAME.Notes ftgen 0, 0, 0, -2, 0.00, 0.03, 0.04, 0.06, 0.08, 0.095, 0.11, 1, 1.02, 1.07
  gk$INSTRUMENT_NAME.NoteDuration init .1
  gk$INSTRUMENT_NAME.NoteFrequency init 3
  gi$INSTRUMENT_NAME.InstrumentToArpegiate = nstrnum("$INSTRUMENT_TO_ARPEGGIATE")

  instr $INSTRUMENT_NAME.Scheduler
    ; Possible Improvements:
    ; 1. Scope arpeggio advancement to instrument instance.
    ; 2. Allow for a table of note durations instead of a single value
    ; 3. Allow different cycle styles: up, down, up forever, down forever, up and down, down and up, random
    iDuration = i(gk$INSTRUMENT_NAME.NoteDuration) * p3
    iAmplitude = p4

    iPitchInteger = pitchClassToIntegerNote(p5) + pitchClassToIntegerNote(table(gi$INSTRUMENT_NAME.Index, gi$INSTRUMENT_NAME.Notes))
    iPitch = integerNoteToPitchClass(iPitchInteger)

    schedule gi$INSTRUMENT_NAME.InstrumentToArpegiate, 0, iDuration, iAmplitude, iPitch

    gi$INSTRUMENT_NAME.Index = gi$INSTRUMENT_NAME.Index >= ftlen(gi$INSTRUMENT_NAME.Notes)-1 ? 0 : gi$INSTRUMENT_NAME.Index + (1/active("$INSTRUMENT_NAME."))
  endin

  instr $INSTRUMENT_NAME
    iAmplitude = p4 == 0 ? veloc() : p4
    iDurationOfNotes = p6 == 0 ? 1 : p6;
    kFrequencyOfNotes = gk$INSTRUMENT_NAME.NoteFrequency * (p7 == 0 ? 1 : p7)

    if active("$INSTRUMENT_NAME") == 1 then
      gi$INSTRUMENT_NAME.Index = 0
    endif

    iMidiNote notnum
    iMidiNote = midiNoteNumberToPitchClassValue(iMidiNote)

    iStartingPitch = p5 == 0 ? iMidiNote : p5

    kTrigger metro kFrequencyOfNotes

    schedkwhen kTrigger, 0, 0, "$INSTRUMENT_NAME.Scheduler", 0, iDurationOfNotes, iAmplitude, iStartingPitch
  endin
#
