; This opcode accepts a MIDI velocity value (0 - 127) and returns
; an amplitude value scaled to 0dbs minus a head room value
; expressed in db. A value of 0db here translates to 1 amplitude
; in the opcode below. A value of -80db translates to 0 amplitude.
; 20db translates to 10 amplitude. I think I might be
; misunderstanding db.
giHeadRoomInDb = 15

opcode velocityToAmplitude, i, i
  iNoteVelocity xin

  iScaleValue = 0dbfs - ampdb(giHeadRoomInDb)
  iScaleValue = iScaleValue < 0 ? 0 : iScaleValue
  iAmplitude = iNoteVelocity/127 * iScaleValue

  xout iAmplitude
endop
