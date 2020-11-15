instr PatternWriter
  iMeasureLength = p4
  kTime timeinsts

  prints "%n%n******************%nPattern Writer Active%n******************%n%n"

  kStatusCode, kChannel, kNoteNumber, kVelocity midiin
  ktrigger  changed  kStatusCode, kChannel, kNoteNumber, kVelocity

  kActiveNotes[][][] init 17, 128, 2

  if ktrigger = 1 then
    SInstrumentName = gSMidiChannelAssignments[kChannel]
    kTimeInBeatsInMeasure = (kTime * gkBPM/60) % iMeasureLength

    if kStatusCode == 144 && kVelocity != 0 then
      kActiveNotes[kChannel][kNoteNumber][0] = kVelocity
      kActiveNotes[kChannel][kNoteNumber][1] = kTimeInBeatsInMeasure
    elseif  (kStatusCode == 144 && kVelocity == 0) || kStatusCode == 128 then
      kDuration = kTimeInBeatsInMeasure - kActiveNotes[kChannel][kNoteNumber][1]

      if kDuration < 0 then
        kDuration = (iMeasureLength - kActiveNotes[kChannel][kNoteNumber][1]) + kTimeInBeatsInMeasure
      endif

      ; For 12 tone equal temperment
      kPitchClassNote = (kNoteNumber - 12) % 12
      kPitchClassOctave = (kNoteNumber - 12 - kPitchClassNote)/12
      kPitchClass = kPitchClassOctave + (kPitchClassNote/100)

      printks "%nbeatScoreline \"%s\", iBaseTime+%f, %f, %d, %f", 0, SInstrumentName, kActiveNotes[kChannel][kNoteNumber][1], kDuration, kActiveNotes[kChannel][kNoteNumber][0], kPitchClass
    endif
  endif
endin
