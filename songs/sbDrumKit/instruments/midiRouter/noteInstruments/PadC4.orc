gSMidiNoteSampleList[giPadC4Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC4Note] filelen gSMidiNoteSampleList[giPadC4Note]
giMidiNoteInterruptList[giPadC4Note] = 0

instr PadC4, 2059
    if giDelayForDrumKitIsOn == 1 then
        turnoff2  nstrnum("DelayForDrumKit"), 8, 1
        giDelayForDrumKitIsOn = 0
        printsBlock "DelayForDrumKit is Off"
    else
        event_i "i", "DelayForDrumKit", 0, -1
        giDelayForDrumKitIsOn = 1
        printsBlock "DelayForDrumKit is On"
    endif
endin
