/*
 * Midi note and control assignments for an electric drumkit
 * and SPD-30 running into an Akai MPC-200XL and X-Session
 * controller/interface.
 */

/* SPD-30 Notes */
giSpd30Pad1Note = 68
giSpd30Pad2Note = 61
giSpd30Pad3Note = 62
giSpd30Pad4Note = 71 ; 63 at less than full velocity
giSpd30Pad5Note = 72
giSpd30Pad6Note = 73
giSpd30Pad7Note = 66
giSpd30Pad8Note = 67 ;75 at full velocity

/* Drum Kit Notes */
giRideNote = 49
giHatOpenNote = 55
giHatClosedNote = 47
giHatPedalNote = 56
giHatSplashNote = 0
giCrashNote = 51
giKickNote = 82
giSnareNote = 38
giTomPad1Note = 45
giTomPad2Note = 52
giTom1Note = 54
giTom2Note = 46

/* MPC Pad Notes */
giPadA1Note = 37
giPadA2Note = 36
giPadA3Note = 42
giPadA4Note = 82
giPadA5Note = 40
giPadA6Note = 38
giPadA7Note = 46
giPadA8Note = 44
giPadA9Note = 48
giPadA10Note = 47
giPadA11Note = 45
giPadA12Note = 43
giPadA13Note = 49
giPadA14Note = 55
giPadA15Note = 51
giPadA16Note = 53
giPadB1Note = 54
giPadB2Note = 69
giPadB3Note = 81
giPadB4Note = 80
giPadB5Note = 65
giPadB6Note = 66
giPadB7Note = 76
giPadB8Note = 77
giPadB9Note = 56
giPadB10Note = 62
giPadB11Note = 63
giPadB12Note = 64
giPadB13Note = 73
giPadB14Note = 74
giPadB15Note = 71
giPadB16Note = 39
giPadC1Note = 52
giPadC2Note = 57
giPadC3Note = 58
giPadC4Note = 59
giPadC5Note = 60
giPadC6Note = 61
giPadC7Note = 67
giPadC8Note = 68
giPadC9Note = 70
giPadC10Note = 72
giPadC11Note = 75
giPadC12Note = 78
giPadC13Note = 79
giPadC14Note = 35
giPadC15Note = 41
giPadC16Note = 50
giPadD1Note = 83
giPadD2Note = 84
giPadD3Note = 85
giPadD4Note = 86
giPadD5Note = 87
giPadD6Note = 88
giPadD7Note = 89
giPadD8Note = 90
giPadD9Note = 91
giPadD10Note = 92
giPadD11Note = 93
giPadD12Note = 94
giPadD13Note = 95
giPadD14Note = 96
giPadD15Note = 97
giPadD16Note = 98

giTestNotes[] init 30
/* giTestNotes maps a set of adjacent, low numbered, unassigned keys to other notes for convenience in testing notes on a virtual midi keyboard. */
giTestNotes[12] = giKickNote ;z
giTestNotes[13] = giHatPedalNote ;s
giTestNotes[14] = giHatOpenNote ;x
giTestNotes[15] = giHatClosedNote ;d
giTestNotes[16] = giSnareNote ;c
giTestNotes[17] = giTomPad1Note ;v
giTestNotes[18] = giTomPad2Note ;g
giTestNotes[19] = giTom1Note ;b
giTestNotes[20] = giTom2Note ;h
giTestNotes[21] = giRideNote ;n
giTestNotes[22] = giCrashNote ;j
giTestNotes[23] = giSpd30Pad1Note ;m
giTestNotes[24] = giSpd30Pad2Note ;q
giTestNotes[25] = giSpd30Pad3Note ;2
giTestNotes[26] = giSpd30Pad4Note ;w
giTestNotes[27] = giSpd30Pad5Note
giTestNotes[28] = giSpd30Pad6Note
giTestNotes[29] = giSpd30Pad7Note
giTestNotes[30] = giSpd30Pad8Note


giXSessionFaderLeftControlNumber = 40
giXSessionFaderRightControlNumber = 50

giXSessionKnobC1ControlNumber = 105
giXSessionKnobC2ControlNumber = 106
giXSessionKnobC3ControlNumber = 107
giXSessionKnobC4ControlNumber = 108
giXSessionKnobC5ControlNumber = 110
giXSessionKnobC6ControlNumber = 111
giXSessionKnobC7ControlNumber = 112
giXSessionKnobC8ControlNumber = 116
giXSessionKnobC9ControlNumber = 70
giXSessionKnobC10ControlNumber = 71
giXSessionKnobC11ControlNumber = 75
giXSessionKnobC12ControlNumber = 80
giXSessionKnobC13ControlNumber = 82
giXSessionKnobC14ControlNumber = 83
giXSessionKnobC15ControlNumber = 55
giXSessionKnobC16ControlNumber = 87

giXSessionButton1ControlNumber = 22
giXSessionButton2ControlNumber = 23
giXSessionButton3ControlNumber = 24
giXSessionButton4ControlNumber = 41
giXSessionButton5ControlNumber = 42
giXSessionButton6ControlNumber = 44
giXSessionButton7ControlNumber = 52
giXSessionButton8ControlNumber = 53
giXSessionButton9ControlNumber = 54
giXSessionButton0ControlNumber = 57
